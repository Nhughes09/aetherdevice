# ADPS-100 Technical Drawings

## Manufacturing Specifications for CNC Shop

---

# PART 1: ENCLOSURE BODY

```
                    ┌─────────────────────────────────────┐
                    │         TOP VIEW                    │
                    │                                     │
                    │           ┌───────────┐             │
                    │          ╱             ╲            │
                    │         │               │           │
                    │         │   ø254mm      │           │
                    │         │   (10.00")    │           │
                    │         │               │           │
                    │          ╲             ╱            │
                    │           └───────────┘             │
                    │                                     │
                    │         Wall: 3.2mm (0.126")        │
                    │         ID: ø247.6mm                │
                    │                                     │
                    └─────────────────────────────────────┘

                    ┌─────────────────────────────────────┐
                    │         SIDE VIEW                   │
                    │                                     │
                    │    ┌───────────────────────────┐    │
                    │    │                           │    │
                    │    │      152.4mm              │    │
                    │    │      (6.00")              │    │
                    │    │                           │    │
                    │    │  ┌─────────┐              │    │
                    │    │  │ FRONT   │ 50mm × 80mm  │    │
                    │    │  │ PANEL   │ cutout       │    │
                    │    │  │ CUTOUT  │              │    │
                    │    │  └─────────┘              │    │
                    │    │       ↑ 25mm from bottom  │    │
                    │    └───────────────────────────┘    │
                    │                                     │
                    │    Material: 6061 Aluminum          │
                    │    Finish: Black Anodize            │
                    └─────────────────────────────────────┘
```

**Specifications:**

- OD: 254.0mm ± 0.5mm
- ID: 247.6mm ± 0.5mm
- Height: 152.4mm ± 0.5mm
- Wall: 3.2mm
- Front panel cutout: 80mm W × 50mm H, centered, 25mm from bottom edge
- 8× ventilation slots: 6mm W × 40mm H, evenly spaced around top

---

# PART 2: BOTTOM PLATE

```
                    ┌─────────────────────────────────────┐
                    │         TOP VIEW                    │
                    │                                     │
                    │              ○ ○                    │
                    │           ○       ○                 │
                    │         ┌───────────┐               │
                    │        ○│           │○              │
                    │         │   ø20mm   │               │
                    │         │  center   │               │
                    │        ○│   hole    │○              │
                    │         └───────────┘               │
                    │           ○       ○                 │
                    │              ○ ○                    │
                    │                                     │
                    │         ø254mm plate                │
                    │         6.35mm thick                │
                    └─────────────────────────────────────┘

                    ○ = M4 standoff holes (6 total) at R=95mm
                    □ = M6 threaded inserts for feet (4 total) at R=100mm
```

**Specifications:**

- Diameter: 254.0mm ± 0.5mm
- Thickness: 6.35mm (1/4")
- Center hole: ø20mm (wire passthrough)
- 6× M4 tapped holes at radius 95mm (60° spacing)
- 4× M6 tapped holes at radius 100mm (90° spacing, 45° offset)
- 8× ventilation slots: 76mm L × 6mm W, radial pattern at R=80mm
- Material: 6061 Aluminum
- Finish: Black Anodize

---

# PART 3: TOP CAP

```
                    ┌─────────────────────────────────────┐
                    │         SECTION VIEW                │
                    │                                     │
                    │    ├──────── ø254mm ────────┤       │
                    │    ┌─────────────────────────┐      │
                    │    │  4mm                    │      │
                    │    ├─────────────────────────┤      │
                    │    │░░░░░░░░░░░░░░░░░░░░░░░░░│ 8mm  │
                    │    │░░░░░│           │░░░░░░│ lip  │
                    │    └─────┘           └──────┘      │
                    │         │ ø156mm    │               │
                    │         │ cutout    │               │
                    │         └───────────┘               │
                    │                                     │
                    │    Lip fits inside body cylinder    │
                    │    Center cutout for copper plate   │
                    └─────────────────────────────────────┘
```

**Specifications:**

- OD: 254.0mm ± 0.5mm
- Lip diameter: 247.0mm (0.6mm clearance from body ID)
- Lip height: 8mm
- Top thickness: 4mm
- Center cutout: ø156mm
- 8× M3 mounting holes at R=120mm
- Material: 6061 Aluminum
- Finish: Black Anodize

---

# PART 4: COPPER COLLECTOR PLATE

```
                    ┌─────────────────────────────────────┐
                    │         TOP VIEW                    │
                    │                                     │
                    │              ╲ │ ╱                  │
                    │            ╲  │  ╱                  │
                    │         ┌────┼────┐                 │
                    │       ──┼────●────┼──               │
                    │         └────┼────┘                 │
                    │            ╱  │  ╲                  │
                    │              ╱ │ ╲                  │
                    │                                     │
                    │    8 radial spokes (9.5mm wide)     │
                    │    Center hub ø30mm                 │
                    │    Window cutout ø152.4mm           │
                    │    Outer edge ø254mm                │
                    │                                     │
                    │    24× brass sphere mounting holes  │
                    │    at R=120mm (ø3.2mm holes)        │
                    └─────────────────────────────────────┘
```

**Specifications:**

- OD: 254.0mm ± 0.5mm
- Thickness: 1.6mm (14 gauge)
- Center cutout: ø152.4mm
- 8× radial spokes: 9.5mm wide
- Center hub: ø30mm
- 24× holes at R=120mm for brass spheres: ø3.2mm
- 8× mounting holes at R=120mm: ø3.2mm (M3)
- Material: 99.9% Pure Copper
- Finish: Mirror polish TOP surface only

---

# PART 5: COPPER GROUND PLANE

```
                    ┌─────────────────────────────────────┐
                    │         TOP VIEW                    │
                    │                                     │
                    │           ┌───────────┐             │
                    │          ╱             ╲            │
                    │         │     ○         │           │
                    │         │   ┌───┐       │           │
                    │         │   │ ○ │       │           │
                    │         │   └───┘       │           │
                    │         │               │           │
                    │          ╲     ○       ╱            │
                    │           └───────────┘             │
                    │                                     │
                    │         ø241.3mm (9.5")             │
                    │         1.3mm thick (16ga)          │
                    │         Center hole ø20mm           │
                    │         4× mounting holes M4        │
                    │         6× vent holes ø15mm         │
                    └─────────────────────────────────────┘
```

**Specifications:**

- Diameter: 241.3mm ± 0.5mm
- Thickness: 1.3mm (16 gauge)
- Center hole: ø20mm
- 4× M4 holes at 200mm square pattern
- 6× ventilation holes ø15mm at R=70mm
- 1× wire terminal hole ø4mm at R=90mm
- Material: 99.9% Pure Copper
- Finish: Bare (no polish required)

---

# PART 6: FRONT PANEL

```
                    ┌─────────────────────────────────────┐
                    │                                     │
                    │    ○ ○ ○                            │
                    │   G B O    ← LEDs (ø5.2mm holes)    │
                    │                                     │
                    │   ┌─────────┐                       │
                    │   │  OLED   │  ← 25mm × 14mm        │
                    │   └─────────┘                       │
                    │                                     │
                    │           ┌───────────┐             │
                    │           │  USB-A 1  │  13×5.5mm   │
                    │           ├───────────┤             │
                    │           │  USB-A 2  │  13×5.5mm   │
                    │           ├───────────┤             │
                    │           │  USB-C    │  9×3.5mm    │
                    │           └───────────┘             │
                    │                                     │
                    │    80mm W × 50mm H × 2mm thick      │
                    └─────────────────────────────────────┘
```

**Specifications:**

- Dimensions: 80mm × 50mm × 2mm
- 3× LED holes: ø5.2mm, 12mm spacing, row at Y=38mm
- OLED window: 25mm × 14mm rectangle at Y=28mm
- USB-C cutout: 9mm × 3.5mm rounded ends
- USB-A cutouts: 2× 13mm × 5.5mm rectangles
- 4× corner mounting holes: ø2.5mm (M2.5) at 4mm inset
- Material: 6061 Aluminum
- Finish: Black Anodize

---

# PART 7: INTERNAL SHELVES (×2)

```
    LOWER SHELF                    UPPER SHELF
    Height: 38mm                   Height: 100mm

       ○     ○                        ○     ○
         ┌─┐                            ┌─┐
    ○    │ │    ○                  ○    │●│    ○
         │ │                            └─┘
         └─┘                     ═══════════════
    ○     ○                        ○     ○

    PCB mounting holes             Coil mounting holes
    9" diameter                    Center: bifilar coil
                                   Side slot: secondary rod
```

**Specifications (both shelves):**

- Diameter: 228.6mm (9")
- Thickness: 3.2mm (1/8")
- 6× standoff holes at R=95mm: ø4mm (M4)
- Material: 6061 Aluminum
- Finish: None (internal part)

**Lower shelf additions:**

- PCB mounting holes: 4× ø3mm at 70×50mm pattern, 4× ø3mm at 50×50mm pattern

**Upper shelf additions:**

- Center coil cutout: ø55mm
- 3× coil mount holes at R=40mm: ø3mm
- Rod slot: 14mm × 160mm rectangle

---

# PART 8: ACRYLIC WINDOW

**Specifications:**

- Diameter: 152.4mm (6")
- Thickness: 6.35mm (1/4")
- Material: Clear Cast Acrylic
- Laser engrave on top surface:
  - "OPTIMAL CHARGING ZONE" (6pt font, centered, Y=+50mm)
  - Circle: ø80mm, 0.5mm deep engrave
  - Center dot: ø5mm, 0.5mm deep

---

## SUMMARY - PARTS LIST

| Part            | Material     | Qty | Notes               |
| --------------- | ------------ | --- | ------------------- |
| Enclosure Body  | 6061 Al      | 1   | CNC turn from tube  |
| Bottom Plate    | 6061 Al      | 1   | CNC mill            |
| Top Cap         | 6061 Al      | 1   | CNC mill            |
| Front Panel     | 6061 Al      | 1   | Laser cut + CNC     |
| Shelf Lower     | 6061 Al      | 1   | Laser cut           |
| Shelf Upper     | 6061 Al      | 1   | Laser cut           |
| Collector Plate | 99.9% Cu     | 1   | Waterjet + polish   |
| Ground Plane    | 99.9% Cu     | 1   | Laser cut           |
| Acrylic Window  | Cast Acrylic | 1   | Laser cut + engrave |

**All aluminum parts: Black anodize finish**
**Copper collector: Mirror polish top only**
