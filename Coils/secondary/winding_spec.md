# Secondary Coil Winding Specification

## ADPS-100 Aetheric Resonator System

---

## Overview

The secondary coil steps up voltage from the bifilar primary through transformer action with the aetheric medium. It's wound on a ferrite rod to maximize magnetic coupling.

---

## Materials Required

| Item                 | Specification                         | Quantity     |
| -------------------- | ------------------------------------- | ------------ |
| Ferrite Rod          | 12.7mm (1/2") dia × 152mm (6") length | 1 pc         |
| Magnet Wire          | 26 AWG polyurethane enamel            | 200 ft (61m) |
| Polyurethane Varnish | Clear, air-dry                        | 50ml         |
| Ring Terminals       | 4mm hole, crimp type                  | 2 pcs        |
| Heat Shrink          | 3mm diameter, red and black           | 2 pcs        |

---

## Rod Dimensions

```
┌────────────────────────────────────────────────────────────────┐
│                                                                │
│  ◄─────────────── 152 mm (6 inches) ──────────────────────►   │
│                                                                │
│  ┌──┐                                                    ┌──┐  │
│  │  │════════════════════════════════════════════════════│  │  │
│  └──┘                                                    └──┘  │
│                                                                │
│  ◄──►                                                    ◄──►  │
│  13mm                                                    13mm  │
│  (unwound)                                              (unwound)│
│                                                                │
│       ◄───────── 127 mm (5 inches) WINDING AREA ─────────►    │
│                                                                │
│  Diameter: 12.7 mm (1/2 inch)                                 │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

---

## Winding Procedure

### Preparation

1. Clean ferrite rod with isopropyl alcohol
2. Mark start position: 13mm from one end
3. Mark end position: 13mm from other end
4. Winding area: 127mm (5 inches)
5. Cut 200 ft of 26 AWG magnet wire

### Winding Steps

**LAYER 1 (Base Layer):**

1. Leave 8" (20cm) tail, tape to rod end
2. Wind tightly, turns touching
3. Start at one end, wind toward other
4. After 50 turns, apply thin varnish coat
5. Continue to 127mm mark (~250 turns in first layer)
6. Apply varnish, let dry 30 min

**LAYER 2:** 7. Reverse direction, wind back over layer 1 8. Keep tension even 9. After 50 turns, apply varnish 10. Continue to starting position (~250 more turns) 11. Apply varnish, let dry 30 min

**TOTAL: 500 turns (2 layers)**

### Winding Pattern

```
CROSS-SECTION VIEW:

              Layer 2 direction →
        ════════════════════════════════
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ← Layer 2
    ════════════════════════════════════════  ← Layer 1
        ← Layer 1 direction
    ────────────────────────────────────────  ← Ferrite Rod

START ─────────────────────────────────► END
        Layer 1 winds left to right
        Layer 2 winds right to left
        Both ends at same side
```

---

## Termination

```
WIRE CONNECTIONS:

┌──────────────────────────────────────────────────────┐
│                                                      │
│   START ────────► TO BIFILAR CENTER TAP             │
│   (inner layer)    (Ring terminal)                  │
│                                                      │
│   END ──────────► TO RECTIFIER INPUT                │
│   (outer layer)    (Ring terminal)                  │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### Terminal Preparation

1. Strip 1" of enamel from each end
2. Tin with solder immediately
3. Crimp ring terminals
4. Apply heat shrink:
   - START end: Red heat shrink
   - END: Black heat shrink

---

## Finishing

### Final Varnish

1. Apply heavy coat over entire winding
2. Rotate rod during drying (prevents drips)
3. Apply second heavy coat
4. Apply third coat
5. Cure 24 hours

### Final Appearance

- Smooth, glossy finish
- No visible wire gaps
- Uniform color

---

## Quality Control

| Test          | Expected          | Fail Condition       |
| ------------- | ----------------- | -------------------- |
| DC Resistance | 15-25Ω            | < 10Ω or > 35Ω       |
| Visual        | Uniform winding   | Gaps, bulges, damage |
| Varnish       | Complete coverage | Exposed wire         |
| Terminals     | Secure            | Loose                |

---

## Wiring Integration

```
┌─────────────────────┐
│   BIFILAR COIL      │
│                     │
│   END-A ──┬─ CENTER │
│   END-B ──┘   TAP   │
└─────────────┬───────┘
              │
              │ Connect here
              │
              ▼
┌─────────────────────────────────────────┐
│           SECONDARY COIL                │
│                                         │
│   START ◄─────────────────────► END     │
│   (from center tap)      (to rectifier) │
│                                         │
│   [════════════════════════════════]    │
│               Ferrite Rod               │
└─────────────────────────────────────────┘
              │
              │ High voltage AC output
              ▼
┌─────────────────────────────────────────┐
│   COCKCROFT-WALTON MULTIPLIER           │
│                                         │
│   Input from secondary coil END         │
└─────────────────────────────────────────┘
```

---

## Mounting

The secondary coil mounts horizontally on the upper shelf:

- Sits in rod holder brackets
- Positioned adjacent to bifilar coil
- Magnetic coupling through proximity
- No physical connection to bifilar (electrical connection only)

```
TOP VIEW:

        ┌─────────────────────────┐
        │                         │
        │   ┌───────────────┐     │
        │   │   BIFILAR     │     │
        │   │   PRIMARY     │     │
        │   └───────────────┘     │
        │                         │
        │   ═══════════════════   │ ← Secondary coil (horizontal)
        │   [  SECONDARY ROD  ]   │
        │                         │
        └─────────────────────────┘
```

---

## Troubleshooting

| Problem         | Cause          | Solution             |
| --------------- | -------------- | -------------------- |
| Low resistance  | Too few turns  | Add more turns       |
| High resistance | Damaged wire   | Check for breaks     |
| Uneven surface  | Poor tension   | Careful rewinding    |
| Cracked varnish | Too thick coat | Remove, reapply thin |
