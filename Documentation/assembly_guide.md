# ADPS-100 Assembly Guide

## Quick Assembly Instructions for Manufacturer

---

## Overview

Build sequence: Bottom → Shelves → Electronics → Coils → Top → Test

**Estimated Time: 6-8 hours per unit**

---

## STEP 1: Bottom Plate Assembly

```
Parts needed:
- Bottom plate (aluminum)
- 6× M4x30mm brass standoffs
- 4× M6 threaded inserts (for rubber feet)
- 4× Rubber feet
```

1. Press M6 threaded inserts into feet holes (use arbor press)
2. Thread M4 standoffs into standoff holes (hand tight)
3. Attach rubber feet (screw in)

**Check: Plate sits flat, doesn't wobble**

---

## STEP 2: Ground Plane Installation

```
Parts needed:
- Copper ground plane disc
- 4× M3x6mm screws
- Wire with ring terminal (black, 18AWG, 30cm)
```

1. Solder ring terminal wire to ground plane terminal hole
2. Place ground plane on lower shelf position (will mount with shelf)
3. Route wire down through center hole

---

## STEP 3: Lower Shelf + Electronics

```
Parts needed:
- Lower shelf (aluminum)
- Power conditioning PCB (assembled)
- Control PCB (assembled)
- 8× M3x10mm standoffs
- 8× M3x6mm screws
```

**Mount PCBs first:**

1. Attach M3 standoffs to lower shelf
2. Mount power PCB (right side)
3. Mount control PCB (left side)
4. Connect inter-board wiring

**Attach shelf to standoffs:** 5. Slide shelf onto M4 standoffs (38mm from bottom) 6. Secure with M4 nuts below

---

## STEP 4: Upper Shelf + Coils

```
Parts needed:
- Upper shelf (aluminum)
- Bifilar coil mount ring
- Bifilar toroidal coil (wound)
- Secondary coil on rod (wound)
- Rod holder brackets (2×)
- Varactor tuning PCB
```

**Mount coils:**

1. Attach bifilar mount ring to upper shelf
2. Set bifilar coil into ring, secure with set screws
3. Install rod holder brackets in slot
4. Place secondary coil rod in holders
5. Mount varactor PCB near coil

**Connect coils:** 6. Wire A (red) from bifilar → route to top (collector) 7. Wire B (blue) from bifilar → connect to ground plane wire 8. Center tap → connect to secondary coil start 9. Secondary end → connect to power board HV input

**Attach shelf:** 10. Slide onto M4 standoffs (100mm from bottom) 11. Secure with M4 nuts

---

## STEP 5: Wiring Harness

```
CRITICAL CONNECTIONS:

┌─────────────────────────────────────────────────────────┐
│                                                         │
│  BIFILAR START-A ───────► TOP COLLECTOR (via HV wire)  │
│  (Red mark)                                             │
│                                                         │
│  BIFILAR START-B + ─────► GROUND PLANE                 │
│  GROUND PLANE WIRE                                      │
│                                                         │
│  BIFILAR CENTER TAP ────► SECONDARY START              │
│                                                         │
│  SECONDARY END ─────────► POWER BOARD HV INPUT         │
│                           (Terminal J_HV_IN)            │
│                                                         │
│  VARACTOR CATHODES ─────► CONTROL BOARD J_COIL         │
│  (all 6 together)                                       │
│                                                         │
│  POWER BOARD 20V OUT ───► CONTROL BOARD VIN            │
│                        ├► USB-C MODULE                  │
│                        ├► USB-A MODULE                  │
│                        └► QI TRANSMITTER (via 12V buck) │
│                                                         │
│  CONTROL BOARD LEDS ────► FRONT PANEL LEDs             │
│  CONTROL BOARD I2C ─────► OLED DISPLAY                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Wire routing:**

- Use cable ties every 50mm
- Keep HV wires away from control signals
- Leave slack for service access

---

## STEP 6: Enclosure Body

1. Prepare front panel:
   - Install LED bezels
   - Mount OLED display
   - Install USB modules
2. Install front panel in body cutout

3. Lower body cylinder over assembly:
   - Feed wires through carefully
   - Align ventilation slots with air gaps
4. Attach body to bottom plate (6× M4 bolts around perimeter)

---

## STEP 7: Top Assembly

```
Parts needed:
- Copper collector plate
- Acrylic window
- Qi transmitter coil
- Top cap (aluminum)
- Silicone sealant
```

1. Apply silicone around acrylic window edge
2. Press window into collector plate center cutout
3. Mount Qi coil underneath window (adhesive)
4. Wire Qi coil to buck converter output (12V)
5. Connect collector plate wire to bifilar START-A

6. Place top cap with collector plate on enclosure
7. Secure with M3 screws from inside

8. Let silicone cure 24 hours before testing water resistance

---

## STEP 8: Testing

### Power-On Sequence:

1. Device auto-starts (no power button)
2. OLED shows "ADPS-100 v1.1"
3. Auto-tune begins (~30 seconds)
4. Blue LED blinks during tuning
5. Blue LED solid = tuning locked
6. Display shows power reading

### Expected Readings:

- Display should show mW values
- If detecting ANY field: Green LED blinks
- If >5W: Green LED solid
- If >15W: Green + Blue solid
- If >25W: All three LEDs solid

### Test Points:

| Test                   | Expected       | Action if Fail        |
| ---------------------- | -------------- | --------------------- |
| OLED displays          | Text visible   | Check I2C wiring      |
| LEDs light during tune | Blue blinks    | Check LED connections |
| Auto-tune completes    | Shows "LOCKED" | Check DAC output      |
| USB-C outputs 5V       | 5V ±0.25V      | Check power board     |
| Qi coil gets 12V       | 12V at module  | Check buck converter  |

---

## Troubleshooting

| Symptom           | Likely Cause         | Fix                          |
| ----------------- | -------------------- | ---------------------------- |
| No display        | I2C wiring           | Check SDA/SCL connections    |
| No LEDs           | Reversed polarity    | Check LED orientation        |
| No USB output     | Power board fault    | Check HV input, caps         |
| Auto-tune fails   | Varactor wiring      | Check varactor connections   |
| Very low readings | Poor coil connection | Check ring terminal contacts |

---

## Packaging

1. Add foam padding inside box
2. Include:
   - Device
   - Instruction card
   - 1× USB-C to USB-C cable
3. External label:
   - "ADPS-100 Aetheric Power Station"
   - "FRAGILE - ELECTRONICS"
   - Serial number
