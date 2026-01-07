// ADPS-100 Internal Shelf - Lower Position
// Electronics mounting shelf
// Material: 6061 Aluminum, 1/8" (3.2mm) thick
// Position: 38mm from bottom plate
// Units: millimeters

// Design Parameters
shelf_od = 228.6;           // 9 inches - clearance inside body
shelf_thickness = 3.2;      // 1/8 inch

// Standoff mounting holes (matches bottom plate)
standoff_radius = 95;
standoff_count = 6;
standoff_hole_dia = 4;      // M4 clearance

// PCB mounting holes
pcb_mount_pattern_1 = [     // Power board (80x60mm)
    [-35, 25], [35, 25], [-35, -25], [35, -25]
];
pcb_mount_pattern_2 = [     // Control board (50x50mm)
    [-60, 40], [-60, -10], [-110, 40], [-110, -10]
];
pcb_hole_dia = 3;           // M3 clearance

// Wire routing slots
slot_width = 10;
slot_length = 30;

// Center hole for vertical wire runs
center_hole_dia = 30;

// Ventilation pattern
vent_hole_dia = 8;
vent_positions = [
    [50, 60], [80, 30], [80, -30], [50, -60],
    [-20, 70], [-20, -70]
];

// Resolution
$fn = 80;

module shelf_lower() {
    difference() {
        // Main disc
        cylinder(d=shelf_od, h=shelf_thickness);
        
        // Center hole
        translate([0, 0, -1])
            cylinder(d=center_hole_dia, h=shelf_thickness + 2);
        
        // Standoff mounting holes
        for (i = [0:standoff_count-1]) {
            angle = i * (360 / standoff_count);
            rotate([0, 0, angle])
                translate([standoff_radius, 0, -1])
                    cylinder(d=standoff_hole_dia, h=shelf_thickness + 2);
        }
        
        // Power board mounting holes
        for (pos = pcb_mount_pattern_1) {
            translate([pos[0], pos[1], -1])
                cylinder(d=pcb_hole_dia, h=shelf_thickness + 2);
        }
        
        // Control board mounting holes
        for (pos = pcb_mount_pattern_2) {
            translate([pos[0], pos[1], -1])
                cylinder(d=pcb_hole_dia, h=shelf_thickness + 2);
        }
        
        // Wire routing slots
        translate([60, -slot_width/2, -1])
            cube([slot_length, slot_width, shelf_thickness + 2]);
        translate([-90, -slot_width/2, -1])
            cube([slot_length, slot_width, shelf_thickness + 2]);
        
        // Ventilation holes
        for (pos = vent_positions) {
            translate([pos[0], pos[1], -1])
                cylinder(d=vent_hole_dia, h=shelf_thickness + 2);
        }
    }
}

// Render
shelf_lower();

// Export notes:
// MANUFACTURING:
// 1. Laser cut from 1/8" aluminum sheet
// 2. All holes are through-holes
// 3. Deburr all edges
// 4. No surface finish required (internal part)
//
// ASSEMBLY:
// - Mounts on M4 standoffs from bottom plate
// - Height: 38mm from bottom plate surface
// - Power board mounts on right side (positive X)
// - Control board mounts on left side (negative X)
