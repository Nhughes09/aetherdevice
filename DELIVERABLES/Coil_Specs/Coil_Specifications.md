# ADPS-100 Coil Winding Specifications

## Complete Instructions for Coil Winding Service

---

# COIL 1: BIFILAR TOROIDAL PRIMARY

## Overview

This is the main resonance coil. Two wires wound together on stacked ferrite toroids.

## Materials Required

| Item             | Specification                           | Source         |
| ---------------- | --------------------------------------- | -------------- |
| Ferrite Cores    | FT-240-43 (Fair-Rite)                   | LCSC or Mouser |
| Quantity         | 4 pieces (stacked)                      |                |
| Core OD          | 61.0mm                                  |                |
| Core ID          | 35.6mm                                  |                |
| Core Height      | 12.7mm each                             |                |
| **Stack Height** | **50.8mm total**                        |                |
| Wire             | 22 AWG magnet wire, polyurethane enamel |                |
| Wire Length      | 2 × 137 meters (450 ft each)            |                |
| Turns            | 369 turns                               |                |

## Core Preparation

1. Stack 4 toroids with flat faces aligned
2. Apply thin epoxy between cores
3. Clamp and cure 2 hours
4. Total height: 50.8mm

```
    ┌─────────────────────────────┐
    │     ╭─────────────────╮     │
    │     │                 │     │  ← Core 4
    │     ╰─────────────────╯     │
    ├─────────────────────────────┤
    │     ╭─────────────────╮     │
    │     │                 │     │  ← Core 3
    │     ╰─────────────────╯     │
    ├─────────────────────────────┤
    │     ╭─────────────────╮     │
    │     │                 │     │  ← Core 2
    │     ╰─────────────────╯     │
    ├─────────────────────────────┤
    │     ╭─────────────────╮     │
    │     │                 │     │  ← Core 1
    │     ╰─────────────────╯     │
    └─────────────────────────────┘

    Stack with epoxy between layers
    总高度 50.8mm
```

## Winding Method: BIFILAR

**CRITICAL: Two wires wound TOGETHER as pair**

```
    Wire A (mark with RED) ────┐
                               ├──── Wind together
    Wire B (mark with BLUE) ───┘
```

1. Cut two wires: 137m each
2. Mark Wire A ends with red tape
3. Mark Wire B ends with blue tape
4. Hold both wires together, parallel
5. Wind through toroid center, around outside
6. Complete 369 turns (both wires count as 1 turn)

## Terminal Configuration

```
    ┌─────────────────────────────────────────────┐
    │                                             │
    │   START-A (RED) ───────► TO COLLECTOR       │
    │   线圈A起点             连接到收集板         │
    │                                             │
    │   START-B (BLUE) ──────► TO GROUND PLANE    │
    │   线圈B起点             连接到接地板         │
    │                                             │
    │   END-A + END-B ───────► CENTER TAP         │
    │   A终点 + B终点          扭在一起，中心抽头   │
    │   (Twist together)      连接到次级线圈       │
    │                                             │
    └─────────────────────────────────────────────┘
```

**4 terminals total:**

- Terminal 1: Wire A START → Ring connector 4mm
- Terminal 2: Wire B START → Ring connector 4mm
- Terminal 3: Center tap (A-END + B-END twisted, soldered) → Ring connector 4mm

## Quality Requirements

| Test              | Spec    | Method     |
| ----------------- | ------- | ---------- |
| Wire A resistance | 2-4Ω    | Multimeter |
| Wire B resistance | 2-4Ω    | Multimeter |
| A-B isolation     | >10MΩ   | Multimeter |
| Turn count        | 369 ±2  | Count      |
| Varnish           | 3 coats | Visual     |

## Finish

- Apply 3 coats polyurethane varnish
- Dry 4 hours between coats
- Final cure 24 hours

---

# COIL 2: SECONDARY ROD COIL

## Overview

Step-up transformer coil wound on ferrite rod.

## Materials Required

| Item        | Specification                           |
| ----------- | --------------------------------------- |
| Ferrite Rod | 12.7mm dia × 152mm length               |
| Wire        | 26 AWG magnet wire, polyurethane enamel |
| Wire Length | 61 meters (200 ft)                      |
| Turns       | 500 turns (2 layers)                    |

## Winding Method

```
    ┌─────────────────────────────────────────────────────────────┐
    │                                                             │
    │  ◄─ 13mm ─►                                      ◄─ 13mm ─► │
    │  (unwound)                                       (unwound)  │
    │                                                             │
    │  ┌──┐═══════════════════════════════════════════════┌──┐   │
    │  │  │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│  │   │
    │  └──┘═══════════════════════════════════════════════└──┘   │
    │                                                             │
    │       ◄────────── 127mm winding area ──────────────►        │
    │                                                             │
    │  Total rod length: 152mm                                    │
    │  总棒长度：152mm                                             │
    │                                                             │
    └─────────────────────────────────────────────────────────────┘
```

## Layer Details

**Layer 1:**

- Start 13mm from one end
- Wind 250 turns, tight and even
- Direction: LEFT to RIGHT
- Apply thin varnish after every 50 turns

**Layer 2:**

- Wind over layer 1
- 250 more turns
- Direction: RIGHT to LEFT (reverse)
- Both terminals exit same end

## Terminal Configuration

```
    ┌─────────────────────────────────────────────┐
    │                                             │
    │   START ───────────► TO BIFILAR CENTER TAP  │
    │   起点                连接到双线圈中心抽头    │
    │                                             │
    │   END ─────────────► TO RECTIFIER INPUT     │
    │   终点                连接到整流器输入        │
    │                                             │
    └─────────────────────────────────────────────┘
```

**2 terminals total:**

- Terminal 1: START → Ring connector 4mm (red heat shrink)
- Terminal 2: END → Ring connector 4mm (black heat shrink)

## Quality Requirements

| Test          | Spec    | Method     |
| ------------- | ------- | ---------- |
| DC Resistance | 15-25Ω  | Multimeter |
| Turn count    | 500 ±5  | Count      |
| Winding area  | 127mm   | Measure    |
| Varnish       | 3 coats | Visual     |

## Finish

- Heavy varnish coat over entire winding
- Rotate rod while drying to prevent drips
- 3 total coats, cure 24 hours

---

# SUMMARY - ORDER SPECIFICATION

## COIL ORDER FORM

**Part 1: Bifilar Toroidal Coil**

- Core: 4× FT-240-43 ferrite toroids, stacked with epoxy
- Wire: 22 AWG × 2 wires × 137m each = 274m total
- Turns: 369 bifilar turns
- Terminals: 3× ring connectors (4mm hole)
- Finish: 3-coat polyurethane varnish
- Quantity: **\_** pieces

**Part 2: Secondary Rod Coil**

- Core: Ferrite rod 12.7mm × 152mm
- Wire: 26 AWG × 61m
- Turns: 500 (2 layers of 250)
- Terminals: 2× ring connectors (4mm hole)
- Finish: 3-coat polyurethane varnish
- Quantity: **\_** pieces

**Quantity per device: 1 of each coil**

---

## 中文规格 / Chinese Specifications

### 线圈 1：双线环形线圈

- 磁芯：4 个 FT-240-43 铁氧体环，堆叠粘合
- 导线：22 AWG 漆包线 × 2 根 × 137 米
- 匝数：369 匝（双线同时绑扎）
- 端子：3 个 4mm 孔环形端子
- 涂层：3 层聚氨酯清漆

### 线圈 2：次级棒形线圈

- 磁芯：铁氧体棒 12.7mm × 152mm
- 导线：26 AWG 漆包线 × 61 米
- 匝数：500 匝（2 层）
- 端子：2 个 4mm 孔环形端子
- 涂层：3 层聚氨酯清漆
