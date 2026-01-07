# ADPS-100 Assembly Manual

## Complete Assembly Instructions

---

## OVERVIEW

Build a complete ADPS-100 device from all components.

**Assembly Time:** 4-6 hours
**Skill Level:** Electronics assembly experience required

---

## STEP 1: BOTTOM PLATE ASSEMBLY

1. Install M6 threaded inserts in 4 feet holes
2. Screw in rubber feet (4×)
3. Install M4×30mm brass standoffs in 6 holes (screw from bottom)

---

## STEP 2: LOWER SHELF + ELECTRONICS

1. Mount power conditioning PCB to lower shelf (4× M3 screws + standoffs)
2. Mount control PCB to lower shelf (4× M3 screws + standoffs)
3. Connect inter-board power wires (20V out to control board VIN)
4. Attach shelf assembly to bottom plate standoffs (height: 38mm from bottom)
5. Secure with M4 nuts

---

## STEP 3: GROUND PLANE

1. Place copper ground plane on lower shelf
2. Connect blue wire from bifilar coil START-B terminal
3. Route wire through center hole

---

## STEP 4: UPPER SHELF + COILS

1. Attach upper shelf to standoffs (height: 100mm from bottom)
2. Install bifilar coil mount ring in center
3. Place bifilar toroidal coil in mount
4. Install rod holder brackets in slot
5. Place secondary coil rod in holders
6. Mount varactor tuning PCB near coil

---

## STEP 5: COIL WIRING

```
CONNECTIONS:

Bifilar START-A (red) ─────► Top Collector Plate
Bifilar START-B (blue) ────► Ground Plane
Bifilar CENTER TAP ────────► Secondary START
Secondary END ─────────────► Power Board HV Input (J_HV_IN)
Varactor cathodes ─────────► Control Board (via tuning wire)
```

---

## STEP 6: FRONT PANEL

1. Install 3× LED bezels (5mm chrome) - Green, Blue, Orange
2. Mount OLED display behind window (double-sided tape)
3. Install USB-C panel mount module
4. Install USB-A dual port module
5. Connect all wires to control/power boards

---

## STEP 7: ENCLOSURE BODY

1. Slide aluminum cylinder over internal assembly
2. Align front panel cutout with installed panel
3. Attach body to bottom plate with 6× M4 bolts around perimeter

---

## STEP 8: TOP ASSEMBLY

1. Mount Qi wireless transmitter coil under acrylic window (use adhesive)
2. Connect Qi coil to 12V output from buck converter
3. Apply silicone sealant around acrylic window edge
4. Press acrylic window into copper collector plate center cutout
5. Solder brass spheres into 24 holes around collector plate edge
6. Connect collector plate to bifilar START-A terminal
7. Attach collector plate + window assembly to aluminum top cap
8. Place top cap on enclosure body
9. Secure with M3 screws from inside

---

## STEP 9: FINAL WIRING CHECK

Verify all connections before testing:

| Connection | From                   | To                    |
| ---------- | ---------------------- | --------------------- |
| HV Input   | Secondary coil END     | Power board J_HV_IN   |
| Collector  | Copper collector plate | Bifilar START-A       |
| Ground     | Ground plane           | Bifilar START-B       |
| Power      | Power board 20V out    | Control board VIN     |
| LEDs       | Control board PA5,6,7  | Front panel LEDs      |
| Display    | Control board PB6,7    | OLED SDA/SCL          |
| Varactor   | Control board PA4      | Varactor array anodes |

---

## STEP 10: TESTING

1. Device auto-powers when internal circuit complete
2. OLED should display "ADPS-100 v1.1"
3. Auto-tune sequence runs (~30 seconds)
4. Blue LED blinks during tuning
5. "LOCKED" message when tuning complete
6. Display shows power reading in milliwatts
7. Test USB-C port: should output 5V-20V depending on device
8. Test USB-A ports: should output 5V

---

## TROUBLESHOOTING

| Issue           | Check                            |
| --------------- | -------------------------------- |
| No display      | I2C wiring (SDA/SCL)             |
| No LED activity | LED connections, polarity        |
| Auto-tune fails | Varactor connections, DAC output |
| No USB power    | Power board, buck converter      |

---

## FINAL INSPECTION

- [ ] All screws tight
- [ ] No loose wires
- [ ] Display visible and working
- [ ] LEDs visible through panel
- [ ] USB ports accessible
- [ ] Rubber feet attached
- [ ] Acrylic window clean
- [ ] Top cap secure
