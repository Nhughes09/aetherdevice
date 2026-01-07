// ADPS-100 Ground Plane (Bottom Copper Plate)
// Internal ground reference for aetheric circuit
// Material: 99.9% Pure Copper, 16 gauge (1.3mm)
// Finish: Bare copper (no polish required)
// Units: millimeters

// Design Parameters
plate_od = 241.3;           // 9.5 inches - fits inside enclosure
plate_thickness = 1.3;      // 16 gauge

// Central mounting hole
center_hole_dia = 20;       // For wire bundle passthrough

// Mounting holes (4 corners, square pattern)
mount_hole_dia = 4;         // M4 clearance
mount_hole_spacing = 200;   // Square pattern, corner to corner

// Wire terminal hole
terminal_hole_dia = 4;
terminal_hole_radius = 90;

// Ventilation/weight reduction holes
vent_hole_dia = 15;
vent_hole_count = 6;
vent_hole_radius = 70;

// Resolution
$fn = 120;

module ground_plane() {
    difference() {
        // Main disc
        cylinder(d=plate_od, h=plate_thickness);
        
        // Center passthrough hole
        translate([0, 0, -1])
            cylinder(d=center_hole_dia, h=plate_thickness + 2);
        
        // Mounting holes (square pattern)
        for (x = [-mount_hole_spacing/2, mount_hole_spacing/2]) {
            for (y = [-mount_hole_spacing/2, mount_hole_spacing/2]) {
                translate([x, y, -1])
                    cylinder(d=mount_hole_dia, h=plate_thickness + 2);
            }
        }
        
        // Wire terminal hole
        translate([terminal_hole_radius, 0, -1])
            cylinder(d=terminal_hole_dia, h=plate_thickness + 2);
        
        // Ventilation/weight reduction holes
        for (i = [0:vent_hole_count-1]) {
            angle = i * (360 / vent_hole_count);
            rotate([0, 0, angle])
                translate([vent_hole_radius, 0, -1])
                    cylinder(d=vent_hole_dia, h=plate_thickness + 2);
        }
    }
}

// Render
color("orange", 0.8)
    ground_plane();

// Export notes:
// MANUFACTURING PROCESS:
// 1. Start with 99.9% pure copper sheet, 16 gauge (1.3mm thick)
// 2. Laser cut or waterjet the disc shape
// 3. Drill all holes after cutting
// 4. Light deburr only (no polish needed)
// 5. Clean with isopropyl alcohol before assembly
// 6. Attach ring terminal at terminal hole position
//
// PLACEMENT:
// This plate sits on the lower internal shelf
// Creates potential difference with top collector plate
// Connected to circuit ground (negative terminal)
