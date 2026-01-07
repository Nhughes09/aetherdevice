# Bill of Materials Summary - ADPS-100

## Cost Breakdown by Category

| Category            | Cost (USD)  |
| ------------------- | ----------- |
| Collection System   | $34.00      |
| Resonator System    | $84.50      |
| Power Electronics   | $51.40      |
| Control System      | $10.40      |
| Enclosure           | $80.80      |
| Wiring & Connectors | $37.00      |
| PCB Fabrication     | $17.50      |
| Miscellaneous       | $13.00      |
| **TOTAL PARTS**     | **$328.60** |

---

## Supplier Distribution

| Supplier          | Items | Total Value |
| ----------------- | ----- | ----------- |
| AliExpress        | 35    | $218.00     |
| LCSC Electronics  | 15    | $50.60      |
| JLCPCB            | 2     | $17.50      |
| Local (Anodizing) | 1     | $10.00      |

---

## Critical Components

### Must Be Exact Specification:

1. **FT-240-43 Ferrite Toroids** - Fair-Rite 43-mix material (μ = 850)
2. **BB833 Varactor Diodes** - Infineon, 1-30pF range
3. **22 AWG Magnet Wire** - Polyurethane enamel insulation
4. **99.9% Pure Copper** - For collector plate (conductivity critical)

### Acceptable Substitutions:

- STM32F103C8T6 → STM32F103CBT6 (more flash)
- XL6009 → LM2596 (lower efficiency but cheaper)
- 0.91" OLED → 0.96" OLED (adjust panel cutout)

---

## Order Notes for Chinese Factory

### Minimum Order Quantities (MOQ):

- Copper sheets: Usually sold by kg (order extra for cutting waste)
- Ferrite toroids: Often 5-piece minimum
- Magnet wire: 500g spool minimum

### Lead Times:

- Standard components from LCSC: 2-5 days
- Copper/aluminum stock: 3-7 days
- PCB fabrication: 5-7 days (standard), 24hr (express)
- Ferrite toroids: 7-14 days (may need to source from Fair-Rite distributor)

### Quality Notes:

- Inspect copper purity - reject if oxidized or <99% pure
- Test ferrite toroids with LCR meter before winding
- Verify varactor capacitance range with LCR meter

---

## Full BOM File

See `BOM_complete.csv` for complete part list with supplier links.
