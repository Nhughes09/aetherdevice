// ADPS-100 Full Assembly View
// Complete device assembly for visualization
// This file imports all components to show full device
// Units: millimeters

// Include all component files
use <../enclosure/enclosure_body.scad>
use <../enclosure/top_cap.scad>
use <../enclosure/bottom_plate.scad>
use <../enclosure/front_panel.scad>
use <../collector/collector_plate.scad>
use <../collector/ground_plane.scad>
use <../internal/shelf_lower.scad>
use <../internal/shelf_upper.scad>
use <../internal/coil_mounts.scad>
use <../window/charging_window.scad>

// Assembly parameters
body_height = 152.4;        // 6 inches
bottom_plate_thickness = 6.35;
shelf_lower_height = 38;    // From bottom plate
shelf_upper_height = 100;   // From bottom plate
top_cap_height = 12;

// Colors for visualization
aluminum_color = [0.3, 0.3, 0.35];
copper_color = [0.8, 0.5, 0.2];
acrylic_color = [0.7, 0.9, 1.0, 0.4];

$fn = 60;

// ============================================
// ENCLOSURE COMPONENTS
// ============================================

// Bottom plate
color(aluminum_color)
    bottom_plate();

// Main body cylinder
color(aluminum_color)
translate([0, 0, bottom_plate_thickness])
    enclosure_body();

// Top cap (aluminum part)
color(aluminum_color)
translate([0, 0, bottom_plate_thickness + body_height])
    top_cap_aluminum();

// Front panel
color(aluminum_color)
translate([254/2 - 3.2, -40, bottom_plate_thickness + 25])
    rotate([0, -90, 0])
        front_panel();

// ============================================
// COPPER COMPONENTS
// ============================================

// Ground plane (on lower shelf)
color(copper_color)
translate([0, 0, bottom_plate_thickness + shelf_lower_height + 5])
    ground_plane();

// Collector plate (on top)
color(copper_color)
translate([0, 0, bottom_plate_thickness + body_height - 5])
    collector_plate();

// ============================================
// INTERNAL STRUCTURE
// ============================================

// Lower shelf
color([0.5, 0.5, 0.5])
translate([0, 0, bottom_plate_thickness + shelf_lower_height])
    shelf_lower();

// Upper shelf
color([0.5, 0.5, 0.5])
translate([0, 0, bottom_plate_thickness + shelf_upper_height])
    shelf_upper();

// Coil mount ring
color([0.4, 0.4, 0.45])
translate([0, 0, bottom_plate_thickness + shelf_upper_height + 3.2])
    bifilar_mount_ring();

// ============================================
// ACRYLIC WINDOW
// ============================================

color(acrylic_color)
translate([0, 0, bottom_plate_thickness + body_height + 2])
    charging_window();

// ============================================
// REPRESENTATIVE COMPONENTS (for visualization)
// ============================================

// Bifilar coil (representative)
color([0.6, 0.3, 0.1])
translate([0, 0, bottom_plate_thickness + shelf_upper_height + 15])
    difference() {
        cylinder(d=61, h=50);
        translate([0, 0, -1])
            cylinder(d=35, h=52);
    }

// Secondary coil on rod (representative)
color([0.5, 0.3, 0.2])
translate([60, -80, bottom_plate_thickness + shelf_upper_height + 10])
    rotate([-90, 0, 0])
        cylinder(d=25, h=160);

// Power board PCB (representative)
color([0.1, 0.5, 0.1])
translate([-35, -25, bottom_plate_thickness + shelf_lower_height + 5])
    cube([70, 50, 1.6]);

// Control board PCB (representative)
color([0.1, 0.4, 0.5])
translate([-110, -10, bottom_plate_thickness + shelf_lower_height + 5])
    cube([50, 50, 1.6]);

// Storage capacitors (representative)
color([0.2, 0.2, 0.3])
for (i = [0:3]) {
    translate([20 + i*15, 0, bottom_plate_thickness + shelf_lower_height + 7])
        cylinder(d=12, h=35);
}

// ============================================
// EXPORT NOTES
// ============================================

// This file is for VISUALIZATION ONLY
// Do not export this file for manufacturing
// Export individual component files instead:
//
// ALUMINUM PARTS (CNC):
// - enclosure_body.scad
// - top_cap.scad
// - bottom_plate.scad
// - front_panel.scad
// - shelf_lower.scad
// - shelf_upper.scad
//
// COPPER PARTS (Waterjet/Laser):
// - collector_plate.scad
// - ground_plane.scad
//
// ACRYLIC PARTS (Laser):
// - charging_window.scad
//
// 3D PRINTED PARTS:
// - coil_mounts.scad
