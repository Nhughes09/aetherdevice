/*
 * ADPS-100 Aetheric Power Station Firmware
 * STM32F103C8T6 "Blue Pill" Controller
 * 
 * Features:
 * - Auto-tune resonance (sweep varactor voltage, find peak)
 * - Monitor harvest power (ADC) - HIGH SENSITIVITY for detection
 * - Visual bar graph on OLED (shows even milliwatts)
 * - Control status LEDs (based on harvest level)
 * - Display stats on OLED
 * 
 * DETECTION MODE: Shows power from 0.001W to 50W
 * Perfect for seeing if ANY aetheric collection is happening
 */

#include "stm32f1xx_hal.h"
#include <string.h>
#include <stdio.h>
#include <math.h>

// Pin Definitions
#define LED_GREEN_PIN       GPIO_PIN_5
#define LED_GREEN_PORT      GPIOA
#define LED_BLUE_PIN        GPIO_PIN_6
#define LED_BLUE_PORT       GPIOA
#define LED_ORANGE_PIN      GPIO_PIN_7
#define LED_ORANGE_PORT     GPIOA

#define ADC_PEAK_CHANNEL    ADC_CHANNEL_0  // PA0
#define DAC_TUNE_CHANNEL    1              // PA4 (DAC output)

// I2C for OLED
#define OLED_I2C_ADDR       0x3C

// Tuning Parameters
#define TUNE_MIN_VOLTAGE    0
#define TUNE_MAX_VOLTAGE    4095
#define TUNE_STEP           16
#define TUNE_SETTLE_MS      10
#define RETUNE_INTERVAL_MS  5000

// Power Thresholds (ADC counts)
#define THRESHOLD_DETECT    5      // ~0.06W - ANYTHING detected!
#define THRESHOLD_BASIC     200    // ~5W
#define THRESHOLD_GOOD      600    // ~15W
#define THRESHOLD_EXCELLENT 1000   // ~25W

// Display modes
#define MODE_NORMAL         0
#define MODE_DETECTION      1      // High sensitivity mode

// Globals
ADC_HandleTypeDef hadc1;
DAC_HandleTypeDef hdac;
I2C_HandleTypeDef hi2c1;

volatile uint16_t current_tune_value = 0;
volatile uint16_t peak_adc_reading = 0;
volatile uint16_t best_tune_value = 0;
volatile uint32_t total_mwh_harvested = 0;  // milliwatt-hours for precision
volatile uint32_t last_tune_time = 0;
volatile uint8_t display_mode = MODE_DETECTION;  // Start in detection mode
volatile uint16_t adc_history[20];  // Rolling history for averaging
volatile uint8_t history_index = 0;

// Function Prototypes
void SystemClock_Config(void);
void GPIO_Init(void);
void ADC_Init(void);
void DAC_Init(void);
void I2C_Init(void);

void AutoTune(void);
uint16_t ReadPeakADC(void);
uint16_t ReadAveragedADC(void);
void SetTuneVoltage(uint16_t value);
void UpdateLEDs(uint16_t power_level);
void UpdateOLED_Detection(float power_mw, uint16_t raw_adc, uint16_t tune_value);
void UpdateOLED_Normal(uint16_t power_watts, uint16_t tune_value, uint32_t total_wh);
float ADCToMilliwatts(uint16_t adc_value);

// OLED Functions
void OLED_Init(void);
void OLED_Clear(void);
void OLED_WriteString(uint8_t row, const char* str);
void OLED_DrawBarGraph(uint8_t row, float value, float max_value);

/*
 * Main Entry Point
 */
int main(void) {
    HAL_Init();
    SystemClock_Config();
    
    GPIO_Init();
    ADC_Init();
    DAC_Init();
    I2C_Init();
    
    // Initialize ADC history
    memset((void*)adc_history, 0, sizeof(adc_history));
    
    OLED_Init();
    OLED_Clear();
    OLED_WriteString(0, "ADPS-100 v1.1");
    OLED_WriteString(1, "DETECTION MODE");
    OLED_WriteString(2, "Sensitivity: mW");
    
    HAL_Delay(1500);
    
    // Auto-tune
    OLED_Clear();
    OLED_WriteString(0, "AUTO-TUNING...");
    OLED_WriteString(1, "Sweeping freq");
    AutoTune();
    
    OLED_WriteString(2, "LOCKED!");
    HAL_Delay(500);
    OLED_Clear();
    
    // Main loop
    while (1) {
        // Read with averaging for stability
        uint16_t raw_adc = ReadPeakADC();
        
        // Add to history
        adc_history[history_index] = raw_adc;
        history_index = (history_index + 1) % 20;
        
        // Calculate averaged reading
        uint16_t avg_adc = ReadAveragedADC();
        
        // Convert to power
        float power_mw = ADCToMilliwatts(avg_adc);
        float power_w = power_mw / 1000.0f;
        
        // Update energy total (mWh)
        // Each 500ms loop = 1/7200 hour
        total_mwh_harvested += (uint32_t)(power_mw / 7200.0f);
        
        // Update LEDs
        UpdateLEDs(avg_adc);
        
        // Update display based on mode
        if (display_mode == MODE_DETECTION) {
            UpdateOLED_Detection(power_mw, raw_adc, current_tune_value);
        } else {
            UpdateOLED_Normal((uint16_t)power_w, current_tune_value, total_mwh_harvested / 1000);
        }
        
        // Periodic re-tune check
        uint32_t now = HAL_GetTick();
        if (now - last_tune_time > RETUNE_INTERVAL_MS) {
            // Quick adjustment
            uint16_t original = current_tune_value;
            uint16_t best = original;
            uint16_t best_reading = avg_adc;
            
            // Check lower
            if (current_tune_value > TUNE_STEP * 2) {
                SetTuneVoltage(current_tune_value - TUNE_STEP);
                HAL_Delay(TUNE_SETTLE_MS);
                uint16_t reading = ReadPeakADC();
                if (reading > best_reading) {
                    best = current_tune_value - TUNE_STEP;
                    best_reading = reading;
                }
            }
            
            // Check higher
            if (current_tune_value < TUNE_MAX_VOLTAGE - TUNE_STEP * 2) {
                SetTuneVoltage(original + TUNE_STEP);
                HAL_Delay(TUNE_SETTLE_MS);
                uint16_t reading = ReadPeakADC();
                if (reading > best_reading) {
                    best = original + TUNE_STEP;
                }
            }
            
            SetTuneVoltage(best);
            current_tune_value = best;
            last_tune_time = now;
        }
        
        HAL_Delay(500);
    }
}

/*
 * Read averaged ADC from history buffer
 */
uint16_t ReadAveragedADC(void) {
    uint32_t sum = 0;
    for (int i = 0; i < 20; i++) {
        sum += adc_history[i];
    }
    return (uint16_t)(sum / 20);
}

/*
 * Convert ADC to milliwatts - CALIBRATION CRITICAL
 * 
 * ADC range: 0-4095 (12-bit)
 * Assumed power range: 0-50W = 0-50000mW
 * 
 * Sensitivity: 1 ADC count ≈ 12mW
 * Minimum detectable: ~12mW (1 ADC count above noise)
 * 
 * ADJUST THIS MULTIPLIER based on actual measurements!
 */
float ADCToMilliwatts(uint16_t adc_value) {
    // Subtract noise floor (typically 2-5 counts)
    if (adc_value < 3) return 0.0f;
    
    uint16_t corrected = adc_value - 3;
    
    // Linear: 4092 counts = 50000mW (50W)
    // Each count = 12.2 mW
    return (float)corrected * 12.2f;
}

/*
 * Detection Mode Display - HIGH SENSITIVITY
 * Shows milliwatts, raw ADC, and visual bar graph
 */
void UpdateOLED_Detection(float power_mw, uint16_t raw_adc, uint16_t tune_value) {
    char line[24];
    
    // Line 0: Power in milliwatts or watts
    if (power_mw < 1000) {
        snprintf(line, sizeof(line), "%.1f mW", power_mw);
    } else {
        snprintf(line, sizeof(line), "%.2f W", power_mw / 1000.0f);
    }
    OLED_WriteString(0, line);
    
    // Line 1: Visual bar graph (0-100% scale, logarithmic for sensitivity)
    // Use log scale so small values are visible
    float log_power = 0;
    if (power_mw > 0.1f) {
        log_power = log10f(power_mw + 1) / log10f(50001);  // 0-1 range
    }
    OLED_DrawBarGraph(1, log_power, 1.0f);
    
    // Line 2: Raw ADC and tune value (for debugging)
    snprintf(line, sizeof(line), "ADC:%4d T:%4d", raw_adc, tune_value);
    OLED_WriteString(2, line);
    
    // Line 3: Status message
    if (power_mw < 1) {
        OLED_WriteString(3, "NO SIGNAL");
    } else if (power_mw < 100) {
        OLED_WriteString(3, "DETECTING!");
    } else if (power_mw < 1000) {
        OLED_WriteString(3, "LOW HARVEST");
    } else if (power_mw < 5000) {
        OLED_WriteString(3, "BASIC HARVEST");
    } else if (power_mw < 15000) {
        OLED_WriteString(3, "GOOD HARVEST");
    } else {
        OLED_WriteString(3, "EXCELLENT!");
    }
}

/*
 * Normal Mode Display
 */
void UpdateOLED_Normal(uint16_t power_watts, uint16_t tune_value, uint32_t total_wh) {
    char line[24];
    
    snprintf(line, sizeof(line), "POWER: %dW", power_watts);
    OLED_WriteString(0, line);
    
    float freq_mhz = 2.0f + (tune_value / 4095.0f) * 3.0f;
    snprintf(line, sizeof(line), "FREQ: %.2fMHz", freq_mhz);
    OLED_WriteString(1, line);
    
    snprintf(line, sizeof(line), "TOTAL: %luWh", total_wh);
    OLED_WriteString(2, line);
    
    OLED_WriteString(3, "");
}

/*
 * Auto-Tune with progress display
 */
void AutoTune(void) {
    uint16_t best_value = 0;
    uint16_t best_reading = 0;
    uint16_t step_count = 0;
    uint16_t total_steps = (TUNE_MAX_VOLTAGE - TUNE_MIN_VOLTAGE) / TUNE_STEP;
    
    char line[24];
    
    for (uint16_t tune = TUNE_MIN_VOLTAGE; tune <= TUNE_MAX_VOLTAGE; tune += TUNE_STEP) {
        SetTuneVoltage(tune);
        HAL_Delay(TUNE_SETTLE_MS);
        
        uint16_t reading = ReadPeakADC();
        
        if (reading > best_reading) {
            best_reading = reading;
            best_value = tune;
        }
        
        // Update progress
        step_count++;
        if (step_count % 16 == 0) {
            uint8_t pct = (step_count * 100) / total_steps;
            snprintf(line, sizeof(line), "Progress: %d%%", pct);
            OLED_WriteString(1, line);
            
            snprintf(line, sizeof(line), "Peak: %d", best_reading);
            OLED_WriteString(2, line);
        }
        
        HAL_GPIO_TogglePin(LED_BLUE_PORT, LED_BLUE_PIN);
    }
    
    SetTuneVoltage(best_value);
    current_tune_value = best_value;
    best_tune_value = best_value;
    last_tune_time = HAL_GetTick();
    
    // Show final result
    snprintf(line, sizeof(line), "Best: %d @ %d", best_reading, best_value);
    OLED_WriteString(1, line);
    
    HAL_GPIO_WritePin(LED_BLUE_PORT, LED_BLUE_PIN, GPIO_PIN_SET);
}

/*
 * Update LED indicators
 */
void UpdateLEDs(uint16_t adc_level) {
    if (adc_level >= THRESHOLD_EXCELLENT) {
        HAL_GPIO_WritePin(LED_GREEN_PORT, LED_GREEN_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_BLUE_PORT, LED_BLUE_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_ORANGE_PORT, LED_ORANGE_PIN, GPIO_PIN_SET);
    } else if (adc_level >= THRESHOLD_GOOD) {
        HAL_GPIO_WritePin(LED_GREEN_PORT, LED_GREEN_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_BLUE_PORT, LED_BLUE_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_ORANGE_PORT, LED_ORANGE_PIN, GPIO_PIN_RESET);
    } else if (adc_level >= THRESHOLD_BASIC) {
        HAL_GPIO_WritePin(LED_GREEN_PORT, LED_GREEN_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_BLUE_PORT, LED_BLUE_PIN, GPIO_PIN_RESET);
        HAL_GPIO_WritePin(LED_ORANGE_PORT, LED_ORANGE_PIN, GPIO_PIN_RESET);
    } else if (adc_level >= THRESHOLD_DETECT) {
        // DETECTION: Blink green slowly to show something is there!
        static uint8_t blink = 0;
        blink = !blink;
        HAL_GPIO_WritePin(LED_GREEN_PORT, LED_GREEN_PIN, blink ? GPIO_PIN_SET : GPIO_PIN_RESET);
        HAL_GPIO_WritePin(LED_BLUE_PORT, LED_BLUE_PIN, GPIO_PIN_RESET);
        HAL_GPIO_WritePin(LED_ORANGE_PORT, LED_ORANGE_PIN, GPIO_PIN_RESET);
    } else {
        // Nothing detected
        HAL_GPIO_WritePin(LED_GREEN_PORT, LED_GREEN_PIN, GPIO_PIN_RESET);
        HAL_GPIO_WritePin(LED_BLUE_PORT, LED_BLUE_PIN, GPIO_PIN_RESET);
        HAL_GPIO_WritePin(LED_ORANGE_PORT, LED_ORANGE_PIN, GPIO_PIN_RESET);
    }
}

/*
 * Read ADC
 */
uint16_t ReadPeakADC(void) {
    HAL_ADC_Start(&hadc1);
    HAL_ADC_PollForConversion(&hadc1, 10);
    uint16_t value = HAL_ADC_GetValue(&hadc1);
    HAL_ADC_Stop(&hadc1);
    return value;
}

/*
 * Set DAC for varactor tuning
 */
void SetTuneVoltage(uint16_t value) {
    if (value > 4095) value = 4095;
    HAL_DAC_SetValue(&hdac, DAC_CHANNEL_1, DAC_ALIGN_12B_R, value);
}

// ============================================
// PERIPHERAL INIT (same as before)
// ============================================

void GPIO_Init(void) {
    __HAL_RCC_GPIOA_CLK_ENABLE();
    __HAL_RCC_GPIOB_CLK_ENABLE();
    
    GPIO_InitTypeDef GPIO_InitStruct = {0};
    GPIO_InitStruct.Pin = LED_GREEN_PIN | LED_BLUE_PIN | LED_ORANGE_PIN;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
}

void ADC_Init(void) {
    __HAL_RCC_ADC1_CLK_ENABLE();
    
    hadc1.Instance = ADC1;
    hadc1.Init.ScanConvMode = ADC_SCAN_DISABLE;
    hadc1.Init.ContinuousConvMode = DISABLE;
    hadc1.Init.DiscontinuousConvMode = DISABLE;
    hadc1.Init.ExternalTrigConv = ADC_SOFTWARE_START;
    hadc1.Init.DataAlign = ADC_DATAALIGN_RIGHT;
    hadc1.Init.NbrOfConversion = 1;
    HAL_ADC_Init(&hadc1);
    
    ADC_ChannelConfTypeDef sConfig = {0};
    sConfig.Channel = ADC_CHANNEL_0;
    sConfig.Rank = ADC_REGULAR_RANK_1;
    sConfig.SamplingTime = ADC_SAMPLETIME_239CYCLES_5;  // Slow for accuracy
    HAL_ADC_ConfigChannel(&hadc1, &sConfig);
    
    HAL_ADCEx_Calibration_Start(&hadc1);
}

void DAC_Init(void) {
    __HAL_RCC_DAC_CLK_ENABLE();
    
    hdac.Instance = DAC;
    HAL_DAC_Init(&hdac);
    
    DAC_ChannelConfTypeDef sConfig = {0};
    sConfig.DAC_Trigger = DAC_TRIGGER_NONE;
    sConfig.DAC_OutputBuffer = DAC_OUTPUTBUFFER_ENABLE;
    HAL_DAC_ConfigChannel(&hdac, &sConfig, DAC_CHANNEL_1);
    
    HAL_DAC_Start(&hdac, DAC_CHANNEL_1);
}

void I2C_Init(void) {
    __HAL_RCC_I2C1_CLK_ENABLE();
    
    hi2c1.Instance = I2C1;
    hi2c1.Init.ClockSpeed = 400000;
    hi2c1.Init.DutyCycle = I2C_DUTYCYCLE_2;
    hi2c1.Init.OwnAddress1 = 0;
    hi2c1.Init.AddressingMode = I2C_ADDRESSINGMODE_7BIT;
    hi2c1.Init.DualAddressMode = I2C_DUALADDRESS_DISABLE;
    hi2c1.Init.GeneralCallMode = I2C_GENERALCALL_DISABLE;
    hi2c1.Init.NoStretchMode = I2C_NOSTRETCH_DISABLE;
    HAL_I2C_Init(&hi2c1);
}

void SystemClock_Config(void) {
    RCC_OscInitTypeDef RCC_OscInitStruct = {0};
    RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
    
    RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
    RCC_OscInitStruct.HSEState = RCC_HSE_ON;
    RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
    RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
    RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
    RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
    HAL_RCC_OscConfig(&RCC_OscInitStruct);
    
    RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                                 |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
    RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
    RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
    RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
    RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;
    HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2);
}

// ============================================
// OLED DRIVER
// ============================================

#define SSD1306_CMD     0x00
#define SSD1306_DATA    0x40

void OLED_SendCommand(uint8_t cmd) {
    uint8_t data[2] = {SSD1306_CMD, cmd};
    HAL_I2C_Master_Transmit(&hi2c1, OLED_I2C_ADDR << 1, data, 2, 100);
}

void OLED_Init(void) {
    HAL_Delay(100);
    OLED_SendCommand(0xAE);
    OLED_SendCommand(0xD5);
    OLED_SendCommand(0x80);
    OLED_SendCommand(0xA8);
    OLED_SendCommand(0x1F);
    OLED_SendCommand(0xD3);
    OLED_SendCommand(0x00);
    OLED_SendCommand(0x40);
    OLED_SendCommand(0x8D);
    OLED_SendCommand(0x14);
    OLED_SendCommand(0x20);
    OLED_SendCommand(0x00);
    OLED_SendCommand(0xA1);
    OLED_SendCommand(0xC8);
    OLED_SendCommand(0xDA);
    OLED_SendCommand(0x02);
    OLED_SendCommand(0x81);
    OLED_SendCommand(0x8F);
    OLED_SendCommand(0xD9);
    OLED_SendCommand(0xF1);
    OLED_SendCommand(0xDB);
    OLED_SendCommand(0x40);
    OLED_SendCommand(0xA4);
    OLED_SendCommand(0xA6);
    OLED_SendCommand(0xAF);
}

void OLED_Clear(void) {
    for (uint8_t page = 0; page < 4; page++) {
        OLED_SendCommand(0xB0 + page);
        OLED_SendCommand(0x00);
        OLED_SendCommand(0x10);
        
        uint8_t data[129];
        data[0] = SSD1306_DATA;
        memset(&data[1], 0, 128);
        HAL_I2C_Master_Transmit(&hi2c1, OLED_I2C_ADDR << 1, data, 129, 100);
    }
}

void OLED_WriteString(uint8_t row, const char* str) {
    if (row > 3) return;
    
    OLED_SendCommand(0xB0 + row);
    OLED_SendCommand(0x00);
    OLED_SendCommand(0x10);
    
    // Simplified: send placeholder pattern
    // Full font rendering would be implemented in production
    uint8_t data[129];
    data[0] = SSD1306_DATA;
    
    uint8_t len = strlen(str);
    for (int i = 0; i < 128; i++) {
        if (i/6 < len) {
            data[1+i] = 0x7E;  // Simple bar pattern to show text position
        } else {
            data[1+i] = 0x00;
        }
    }
    
    HAL_I2C_Master_Transmit(&hi2c1, OLED_I2C_ADDR << 1, data, 129, 100);
}

/*
 * Draw horizontal bar graph
 * Row: 0-3
 * Value: current value
 * MaxValue: full scale value
 */
void OLED_DrawBarGraph(uint8_t row, float value, float max_value) {
    if (row > 3) return;
    
    OLED_SendCommand(0xB0 + row);
    OLED_SendCommand(0x00);
    OLED_SendCommand(0x10);
    
    uint8_t data[129];
    data[0] = SSD1306_DATA;
    
    // Calculate filled pixels (0-120, leave 8 for border)
    float ratio = value / max_value;
    if (ratio > 1.0f) ratio = 1.0f;
    if (ratio < 0.0f) ratio = 0.0f;
    
    uint8_t filled = (uint8_t)(ratio * 120);
    
    // Draw bar with border
    data[1] = 0xFF;  // Left border
    data[2] = 0x81;
    
    for (int i = 3; i < 125; i++) {
        if (i - 3 < filled) {
            data[i] = 0xBD;  // Filled segment
        } else {
            data[i] = 0x81;  // Empty segment (just top/bottom lines)
        }
    }
    
    data[125] = 0x81;
    data[126] = 0xFF;  // Right border
    data[127] = 0x00;
    data[128] = 0x00;
    
    HAL_I2C_Master_Transmit(&hi2c1, OLED_I2C_ADDR << 1, data, 129, 100);
}
