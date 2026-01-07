# ADPS-100 Complete Wiring Diagram

## All Electrical Connections

---

## System Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ADPS-100 WIRING MAP                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                    ┌─────────────────────────────────┐                      │
│                    │      TOP COPPER COLLECTOR       │                      │
│                    │         (High Potential)        │                      │
│                    └───────────────┬─────────────────┘                      │
│                                    │                                        │
│                         RED HV WIRE (10kV rated)                            │
│                                    │                                        │
│                                    ▼                                        │
│   ┌────────────────────────────────────────────────────────────────────┐   │
│   │                    UPPER SHELF (100mm)                              │   │
│   │                                                                     │   │
│   │   ┌─────────────────────┐        ┌──────────────────────┐          │   │
│   │   │   BIFILAR TOROID    │        │   SECONDARY COIL     │          │   │
│   │   │                     │        │   (on ferrite rod)   │          │   │
│   │   │  START-A ──► RED    │        │                      │          │   │
│   │   │  START-B ──► BLUE   │        │   START ◄─┐          │          │   │
│   │   │  END-A+B ──► CENTER │───────►│          │          │          │   │
│   │   │             TAP     │        │   END ───┼──► To    │          │   │
│   │   └─────────────────────┘        │          │  Rectifier│          │   │
│   │            │                     └──────────┼───────────┘          │   │
│   │            │                                │                       │   │
│   │     ┌──────┴──────────────────────────────┐ │                       │   │
│   │     │            VARACTOR ARRAY           │ │                       │   │
│   │     │  6× BB833 in parallel               │ │                       │   │
│   │     │  Anodes ──► DAC output from MCU     │ │                       │   │
│   │     │  Cathodes ──► Bifilar center tap    │ │                       │   │
│   │     └─────────────────────────────────────┘ │                       │   │
│   │                                             │                       │   │
│   └─────────────────────────────────────────────┼───────────────────────┘   │
│                                                 │                           │
│                               HV OUTPUT AC (200-500V)                       │
│                                                 │                           │
│                                                 ▼                           │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                    LOWER SHELF (38mm)                               │   │
│   │                                                                     │   │
│   │   ┌───────────────────────────┐     ┌────────────────────────────┐ │   │
│   │   │      POWER BOARD          │     │      CONTROL BOARD         │ │   │
│   │   │                           │     │                            │ │   │
│   │   │  J_HV_IN ◄── Secondary    │     │  PA0 ◄── Peak Detector    │ │   │
│   │   │           coil END        │     │  PA4 ──► Varactor DAC     │ │   │
│   │   │                           │     │  PA5 ──► LED Green        │ │   │
│   │   │  [6-Stage Multiplier]     │     │  PA6 ──► LED Blue         │ │   │
│   │   │         │                 │     │  PA7 ──► LED Orange       │ │   │
│   │   │         ▼                 │     │  PB6 ──► OLED SCL         │ │   │
│   │   │  [Storage Caps 4×470µF]   │     │  PB7 ──► OLED SDA         │ │   │
│   │   │         │                 │     │                            │ │   │
│   │   │         ▼                 │     │  VIN ◄── 20V from Power   │ │   │
│   │   │  [Buck-Boost XL6009]      │     │  GND ◄── Common ground    │ │   │
│   │   │         │                 │     │                            │ │   │
│   │   │  J_20V_OUT ──────────────────►──┤                            │ │   │
│   │   │         │                 │     └────────────────────────────┘ │   │
│   │   │         ├──► USB-C PD     │                                    │   │
│   │   │         ├──► USB-A ×2     │                                    │   │
│   │   │         └──► 12V Buck ──► Qi Transmitter                       │   │
│   │   │                           │                                    │   │
│   │   └───────────────────────────┘                                    │   │
│   │                                                                     │   │
│   │   ┌───────────────────────────┐                                    │   │
│   │   │    COPPER GROUND PLANE    │                                    │   │
│   │   │     (Low Potential)       │                                    │   │
│   │   │           │               │                                    │   │
│   │   │    BLUE wire ◄────────────┼───── Bifilar START-B              │   │
│   │   └───────────┬───────────────┘                                    │   │
│   │               │                                                     │   │
│   │        COMMON GROUND BUS                                            │   │
│   │               │                                                     │   │
│   └───────────────┼─────────────────────────────────────────────────────┘   │
│                   │                                                         │
│                   └──► Bottom plate (chassis ground reference)              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Detailed Connection Tables

### BIFILAR COIL CONNECTIONS

| Terminal             | Wire Color | Connects To                              |
| -------------------- | ---------- | ---------------------------------------- |
| START-A              | Red tape   | Top collector plate (ring terminal)      |
| START-B              | Blue tape  | Ground plane (ring terminal)             |
| CENTER TAP (END-A+B) | Yellow     | Secondary coil START + Varactor cathodes |

### SECONDARY COIL CONNECTIONS

| Terminal | Wire Color   | Connects To               |
| -------- | ------------ | ------------------------- |
| START    | Yellow       | Bifilar center tap        |
| END      | Orange/White | Power board J_HV_IN pin 1 |

### VARACTOR ARRAY CONNECTIONS

| Terminal                       | Connects To                                  |
| ------------------------------ | -------------------------------------------- |
| All 6 Anodes (tied together)   | Control board PA4 (DAC out) via 1kΩ resistor |
| All 6 Cathodes (tied together) | Bifilar center tap / Secondary START         |

### POWER BOARD CONNECTIONS

| Connector | Pin | Connects To        |
| --------- | --- | ------------------ |
| J_HV_IN   | 1   | Secondary coil END |
| J_HV_IN   | 2   | Ground plane       |
| J_20V_OUT | 1   | +20V distribution  |
| J_20V_OUT | 2   | Ground             |

### CONTROL BOARD CONNECTIONS

| Pin | Function   | Connects To                          |
| --- | ---------- | ------------------------------------ |
| PA0 | ADC Input  | Peak detector output (from HV stage) |
| PA4 | DAC Output | Varactor anodes (via 1kΩ)            |
| PA5 | GPIO Out   | LED Green (+) via 330Ω               |
| PA6 | GPIO Out   | LED Blue (+) via 330Ω                |
| PA7 | GPIO Out   | LED Orange (+) via 330Ω              |
| PB6 | I2C SCL    | OLED pin SCL                         |
| PB7 | I2C SDA    | OLED pin SDA                         |
| VIN | Power In   | +20V from power board                |
| GND | Ground     | Common ground                        |

### LED CONNECTIONS (Front Panel)

| LED    | Anode (+)    | Cathode (-) |
| ------ | ------------ | ----------- |
| Green  | PA5 via 330Ω | Ground      |
| Blue   | PA6 via 330Ω | Ground      |
| Orange | PA7 via 330Ω | Ground      |

### OLED DISPLAY CONNECTIONS

| OLED Pin | Connects To                          |
| -------- | ------------------------------------ |
| VCC      | +3.3V (from control board regulator) |
| GND      | Ground                               |
| SCL      | PB6                                  |
| SDA      | PB7                                  |

### OUTPUT MODULE CONNECTIONS

| Module         | Power Input      | Ground | Notes                           |
| -------------- | ---------------- | ------ | ------------------------------- |
| USB-C PD       | +20V             | GND    | IP2721 handles PD negotiation   |
| USB-A #1       | +20V             | GND    | Internal 5V buck converter      |
| USB-A #2       | +20V             | GND    | Internal 5V buck converter      |
| Qi Transmitter | +12V (from buck) | GND    | Separate 12V buck from 20V rail |

---

## Wire Specifications

| Connection               | Wire Gauge | Insulation    | Length    |
| ------------------------ | ---------- | ------------- | --------- |
| Collector to Bifilar     | 18 AWG     | Silicone 10kV | 15cm      |
| Ground plane to Bifilar  | 18 AWG     | Silicone      | 20cm      |
| Bifilar to Secondary     | 20 AWG     | Standard      | 10cm      |
| Secondary to Rectifier   | 18 AWG     | Silicone 10kV | 25cm      |
| 20V power distribution   | 18 AWG     | Silicone      | as needed |
| Signal wires (LEDs, I2C) | 22 AWG     | Stranded      | as needed |

---

## Grounding Scheme

```
ISOLATED GROUND SYSTEM:

                     ┌─────────────────────────┐
                     │    TOP COLLECTOR        │ ◄── High potential
                     │    (Floating)           │     (from aetheric field)
                     └─────────────────────────┘
                              │
                     ┌────────┴────────┐
                     │   RESONANT      │
                     │   CIRCUIT       │
                     └────────┬────────┘
                              │
                     ┌────────▼────────┐
                     │  GROUND PLANE   │ ◄── Low potential
                     │  (Internal)     │     (reference only)
                     └────────┬────────┘
                              │
                              │    NOT connected to
                              │    earth ground!
                              ▼
                     ┌─────────────────┐
                     │  CIRCUIT GND    │ ◄── Electronics ground
                     │  (Common 0V)    │     reference
                     └─────────────────┘

NOTE: This is a FLOATING system. The ground plane creates
internal potential difference with collector - no earth
ground connection required or used.
```

---

## Peak Detector Circuit (between Secondary and ADC)

```
From Secondary ──┬── D1 (1N5819) ──┬── To PA0 (ADC)
Coil END         │                 │
                 │            C1 ──┴── 100nF
                 │                 │
                GND               GND

D1: Schottky diode (fast, low Vf)
C1: Holds peak voltage for ADC to read
R1: 100kΩ bleeder (slow discharge, optional)

This converts AC from secondary coil to DC level
that STM32 ADC can read. Higher voltage = more power
being harvested.
```
