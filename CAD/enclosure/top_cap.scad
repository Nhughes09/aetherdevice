// ADPS-100 Top Cap Assembly
// Aluminum ring with copper collector plate mount
// Material: 6061 Aluminum + 99.9% Copper
// Units: millimeters

// Design Parameters
cap_od = 254;           // 10 inches - matches body OD
cap_id = 247.6;         // Matches body ID for fit
cap_height = 12;        // Total cap height
lip_height = 8;         // Lip that fits inside body

// Copper plate mounting
copper_plate_od = 254;  // Full diameter copper plate
acrylic_window_od = 152.4;  // 6 inch acrylic window opening

// Mounting holes
mount_hole_count = 8;
mount_hole_dia = 3.2;   // M3 clearance
mount_hole_radius = 120; // Radius from center

// Resolution
$fn = 120;

module top_cap_aluminum() {
    difference() {
        union() {
            // Main cap disc
            cylinder(d=cap_od, h=cap_height - lip_height);
            
            // Lip that fits inside body
            translate([0, 0, cap_height - lip_height])
                cylinder(d=cap_id - 0.5, h=lip_height); // 0.5mm clearance
        }
        
        // Center opening for copper plate/window
        translate([0, 0, -1])
            cylinder(d=acrylic_window_od + 4, h=cap_height + 2);
        
        // Mounting holes for copper plate
        for (i = [0:mount_hole_count-1]) {
            angle = i * (360 / mount_hole_count);
            rotate([0, 0, angle])
                translate([mount_hole_radius, 0, -1])
                    cylinder(d=mount_hole_dia, h=cap_height + 2);
        }
        
        // Countersink for screws (top side)
        for (i = [0:mount_hole_count-1]) {
            angle = i * (360 / mount_hole_count);
            rotate([0, 0, angle])
                translate([mount_hole_radius, 0, cap_height - lip_height - 2])
                    cylinder(d=6, h=3);
        }
    }
}

module copper_collector_plate() {
    // Shown for reference - separate manufacturing
    color("orange")
    difference() {
        cylinder(d=copper_plate_od, h=1.6); // 14 gauge
        
        // Center cutout for acrylic window
        translate([0, 0, -1])
            cylinder(d=acrylic_window_od, h=4);
        
        // Mounting holes
        for (i = [0:mount_hole_count-1]) {
            angle = i * (360 / mount_hole_count);
            rotate([0, 0, angle])
                translate([mount_hole_radius, 0, -1])
                    cylinder(d=mount_hole_dia, h=4);
        }
    }
}

// Show assembly
top_cap_aluminum();
translate([0, 0, -2])
    copper_collector_plate();

// Export notes:
// 1. Aluminum cap: CNC from 10" disc, 1/2" stock
// 2. Copper plate: Laser cut or waterjet from 14ga sheet
// 3. Assembly: Copper plate attaches to bottom of aluminum cap
// 4. Seal acrylic window with silicone after assembly
