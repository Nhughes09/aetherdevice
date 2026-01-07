# Bifilar Primary Coil Winding Specification

## ADPS-100 Aetheric Resonator System

---

## Overview

The bifilar primary coil is the heart of the aetheric resonance system. It consists of two parallel wires wound together on a stacked ferrite toroid core. This canceling-field configuration creates the conditions for scalar/longitudinal wave coupling.

---

## Materials Required

| Item                 | Specification                | Quantity      |
| -------------------- | ---------------------------- | ------------- |
| Ferrite Toroids      | FT-240-43 (Fair-Rite 43-mix) | 4 pcs         |
| Magnet Wire A        | 22 AWG polyurethane enamel   | 450 ft (137m) |
| Magnet Wire B        | 22 AWG polyurethane enamel   | 450 ft (137m) |
| Epoxy Adhesive       | 2-part, 5-min cure           | 20ml          |
| Polyurethane Varnish | Clear, air-dry               | 100ml         |
| Ring Terminals       | 4mm hole, crimp type         | 4 pcs         |

---

## Core Dimensions (Stacked Assembly)

```
┌─────────────────────────────────────┐
│          TOROID STACK               │
│                                     │
│    ┌───────────────────────────┐    │
│    │    ╭─────────────────╮    │    │
│    │    │                 │    │    │  ← Toroid 4 (top)
│    │    ╰─────────────────╯    │    │
│    ├───────────────────────────┤    │
│    │    ╭─────────────────╮    │    │
│    │    │                 │    │    │  ← Toroid 3
│    │    ╰─────────────────╯    │    │
│    ├───────────────────────────┤    │
│    │    ╭─────────────────╮    │    │
│    │    │                 │    │    │  ← Toroid 2
│    │    ╰─────────────────╯    │    │
│    ├───────────────────────────┤    │
│    │    ╭─────────────────╮    │    │
│    │    │                 │    │    │  ← Toroid 1 (bottom)
│    │    ╰─────────────────╯    │    │
│    └───────────────────────────┘    │
│                                     │
│    OD: 61.0 mm (2.4 inches)        │
│    ID: 35.6 mm (1.4 inches)        │
│    H:  50.8 mm (2.0 inches total)  │
└─────────────────────────────────────┘
```

### Single Toroid (FT-240-43)

- Outer Diameter: 61.0 mm
- Inner Diameter: 35.6 mm
- Height: 12.7 mm
- Material: Fair-Rite 43-mix ferrite (μ = 850)

### Stacked Assembly

- Total Height: 50.8 mm (4 × 12.7 mm)
- Weight: ~280g total

---

## Core Assembly Procedure

1. **Clean cores** with isopropyl alcohol
2. **Stack 4 toroids** with flat faces aligned
3. **Apply thin epoxy layer** between each toroid
4. **Clamp together** with even pressure
5. **Cure 2 hours** before winding
6. **Wrap stack** with one layer electrical tape (optional, protects wire)

---

## Winding Procedure

### Preparation

1. Cut two lengths of 22 AWG magnet wire: 450 ft each
2. Label wires: **Wire A** (mark with red tape at both ends)
3. Label wires: **Wire B** (mark with blue tape at both ends)
4. Hold both wires together, parallel, throughout winding

### Bifilar Technique

```
Both wires wound SIMULTANEOUSLY as a pair:

     Wire A ────┐
                ├──── Both wires together
     Wire B ────┘

Feed through core center, wrap around outside, repeat.
```

### Winding Steps

**START POSITION:**

1. Leave 12" (30cm) tail on both wires
2. Tape tails together, label "START-A" and "START-B"
3. Feed both wires UP through center hole

**WINDING:** 4. Wind 369 complete turns (both wires together = 369 turns each) 5. Each turn:

- Up through center hole
- Across top of toroid
- Down outside edge
- Across bottom
- Repeat

6. Keep constant tension (firm but not tight)
7. Keep wires parallel, not twisted
8. Turns should be close but not overlapping

**COUNTING:**

- Use a tally counter (click every 10 turns)
- Mark every 50 turns with tape
- Total: 369 turns = approximately 900 ft of wire path

**END POSITION:** 9. Leave 12" tail on both wires 10. Tape ends together, label "END-A" and "END-B"

### Winding Time

- Expected: 1.5 - 2.5 hours
- Take breaks every 100 turns

---

## Termination

```
WIRE CONNECTIONS:

┌──────────────────────────────────────────────────────┐
│                                                      │
│   START-A ──────► TO TOP COLLECTOR PLATE            │
│   (Red tape)       (Ring terminal, solder)          │
│                                                      │
│   START-B ──────► TO BOTTOM GROUND PLANE            │
│   (Blue tape)      (Ring terminal, solder)          │
│                                                      │
│   END-A ────┬──► CENTER TAP (to secondary coil)     │
│             │    (Twist together, solder, insulate) │
│   END-B ────┘                                        │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### Terminal Preparation

1. Strip 1" (25mm) of enamel from each wire end
   - Use sandpaper (320 grit) or enamel stripper
   - Tin with solder immediately
2. Crimp ring terminals:
   - START-A: 4mm ring terminal (connects to collector)
   - START-B: 4mm ring terminal (connects to ground)
3. CENTER TAP:
   - Twist END-A and END-B together (stripped ends)
   - Solder junction thoroughly
   - Insulate with heat shrink tubing
   - Add ring terminal to combined wire

---

## Finishing

### Varnish Application

1. Apply thin coat of polyurethane varnish
2. Use brush, coat all visible wire
3. Let dry 4 hours
4. Apply second coat
5. Let dry 4 hours
6. Apply third coat (final)
7. Cure 24 hours before assembly

### Final Inspection

- Total resistance A start → A end: 2-4Ω
- Total resistance B start → B end: 2-4Ω
- Resistance A → B: OPEN (∞, no connection)
- No visible damage to enamel
- No loose turns

---

## Quality Control

| Test              | Expected     | Fail Condition              |
| ----------------- | ------------ | --------------------------- |
| Wire A resistance | 2-4Ω         | < 1Ω or > 6Ω                |
| Wire B resistance | 2-4Ω         | < 1Ω or > 6Ω                |
| A to B isolation  | > 10MΩ       | < 1MΩ (shorted)             |
| Visual inspection | No damage    | Exposed copper, loose turns |
| Ring terminals    | Secure crimp | Loose or corroded           |

---

## Wiring Diagram

```
                    TOP COLLECTOR PLATE (+)
                           │
                           │ HV Silicone Wire
                           │
                    ┌──────▼──────┐
                    │  START-A    │
                    │             │
                    │   BIFILAR   │
                    │   PRIMARY   │
                    │    COIL     │
                    │             │
                    │  START-B    │
                    └──────┬──────┘
                           │
                           │ HV Silicone Wire
                           │
                           ▼
                    BOTTOM GROUND PLANE (-)


                    CENTER TAP (END-A + END-B twisted)
                           │
                           │ Standard Wire
                           ▼
                    SECONDARY COIL INPUT
```

---

## Troubleshooting

| Problem                | Cause                    | Solution                       |
| ---------------------- | ------------------------ | ------------------------------ |
| Low resistance (< 1Ω)  | Too few turns            | Recount, add turns             |
| High resistance (> 6Ω) | Too many turns or damage | Recount, check connections     |
| A-B shorted            | Enamel damage            | Locate short, repair or rewind |
| Uneven winding         | Poor tension             | Careful rewinding              |

---

## Storage & Handling

- Store in antistatic bag
- Keep away from strong magnets
- Handle by edges only
- Do not drop (ferrite is brittle)
