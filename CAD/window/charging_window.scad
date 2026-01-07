// ADPS-100 Acrylic Charging Window
// Clear window for Qi wireless charging
// Material: Cast acrylic, clear, 1/4" (6.35mm) thick
// Units: millimeters

// Design Parameters
window_dia = 152.4;         // 6 inches diameter
window_thickness = 6.35;    // 1/4 inch

// Engraving (for laser engraver)
engraving_depth = 0.5;

// Alignment circle (engraved)
align_circle_dia = 80;      // Phone placement guide

// Resolution
$fn = 120;

module charging_window() {
    difference() {
        // Main disc
        color("lightblue", 0.5)
            cylinder(d=window_dia, h=window_thickness);
        
        // Alignment circle engraving (top surface)
        translate([0, 0, window_thickness - engraving_depth])
            difference() {
                cylinder(d=align_circle_dia + 2, h=engraving_depth + 1);
                translate([0, 0, -1])
                    cylinder(d=align_circle_dia - 2, h=engraving_depth + 3);
            }
        
        // Center dot
        translate([0, 0, window_thickness - engraving_depth])
            cylinder(d=5, h=engraving_depth + 1);
    }
}

// Text engraving positions (for laser engraver reference)
module engraving_text() {
    color("gray")
    translate([0, 55, window_thickness])
        linear_extrude(0.3)
            text("OPTIMAL", size=6, halign="center", font="Arial:style=Bold");
    
    translate([0, 47, window_thickness])
        linear_extrude(0.3)
            text("CHARGING ZONE", size=5, halign="center", font="Arial:style=Bold");
    
    translate([0, -55, window_thickness])
        linear_extrude(0.3)
            text("ADPS-100", size=4, halign="center", font="Arial");
}

// Render
charging_window();
engraving_text();

// Export notes:
// MANUFACTURING:
// 1. Laser cut from 1/4" clear cast acrylic sheet
// 2. Fire-polish edges for optical clarity
// 3. Laser engrave alignment circle and text
// 4. Clean with plastic polish before assembly
//
// ASSEMBLY:
// 1. Apply silicone sealant around edge
// 2. Press into copper collector plate center cutout
// 3. Qi transmitter coil mounts underneath (on enclosure side)
// 4. Allow silicone to cure 24 hours before use
//
// CRITICAL:
// - Use CAST acrylic (not extruded) - better optical clarity
// - Engraving should be on TOP surface (phone-facing side)
// - Keep protective film on during shipping
