# ADPS-100 Factory Test Procedure

## Quick QC Checklist

---

## Pre-Power Tests (No Power)

| #   | Test                 | Method                                  | Pass   | Fail         |
| --- | -------------------- | --------------------------------------- | ------ | ------------ |
| 1   | Coil A resistance    | Multimeter across START-A to END-A      | 2-4Ω   | <1Ω or >6Ω   |
| 2   | Coil B resistance    | Multimeter across START-B to END-B      | 2-4Ω   | <1Ω or >6Ω   |
| 3   | A-B isolation        | Multimeter A to B                       | >10MΩ  | <1MΩ         |
| 4   | Secondary resistance | Multimeter start to end                 | 15-25Ω | <10Ω or >35Ω |
| 5   | Ground continuity    | Multimeter ground plane to circuit GND  | <1Ω    | >5Ω          |
| 6   | Collector continuity | Multimeter collector to bifilar START-A | <1Ω    | >5Ω          |
| 7   | No shorts            | Multimeter +20V to GND                  | >1MΩ   | <10kΩ        |

---

## Power-On Tests

| #   | Test                | Expected             | Action if Fail           |
| --- | ------------------- | -------------------- | ------------------------ |
| 1   | OLED lights up      | "ADPS-100 v1.1" text | Check I2C wiring         |
| 2   | Auto-tune starts    | Blue LED blinks      | Check DAC/varactor       |
| 3   | Auto-tune completes | "LOCKED" message     | Recheck coil connections |
| 4   | Display shows mW    | Number visible       | Check ADC input          |
| 5   | USB-C outputs 5V    | 5.0V ±0.25V          | Check power board        |
| 6   | USB-A outputs 5V    | 5.0V ±0.25V          | Check USB module         |

---

## Functionality Tests

### LED Test

1. Short ADC input to 3.3V briefly
2. All 3 LEDs should light
3. Remove short - LEDs should turn off

### Qi Test

1. Measure voltage at Qi module input: should be 12V
2. Place Qi test coil on window
3. Should detect power transfer

### Resonance Test

1. Watch OLED during auto-tune
2. "Peak" value should be >10 (non-zero)
3. If peak stays at 0, coil problem

---

## Final Inspection

- [ ] All screws tight
- [ ] No loose wires visible
- [ ] Rubber feet attached
- [ ] Acrylic window clean
- [ ] Display readable
- [ ] LEDs visible through panel
- [ ] USB ports accessible

---

## Serial Number Format

**ADPS-YY-MM-####**

Example: ADPS-26-01-0001

- YY = Year (26 = 2026)
- MM = Month (01 = January)
- #### = Sequential unit number

Write on bottom plate with permanent marker or label.
