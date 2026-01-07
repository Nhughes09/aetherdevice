// ADPS-100 Internal Shelf - Upper Position
// Coil mounting shelf
// Material: 6061 Aluminum, 1/8" (3.2mm) thick
// Position: 100mm from bottom plate
// Units: millimeters

// Design Parameters
shelf_od = 228.6;           // 9 inches - clearance inside body
shelf_thickness = 3.2;      // 1/8 inch

// Standoff mounting holes (matches bottom plate)
standoff_radius = 95;
standoff_count = 6;
standoff_hole_dia = 4;      // M4 clearance

// Bifilar coil mounting (center position)
// FT-240-43 toroids stacked: 61mm OD
coil_mount_od = 70;         // Slightly larger for mounting ring
coil_mount_id = 55;         // Inner cutout for coil body

// Coil mounting screw holes (3-point)
coil_screw_radius = 40;
coil_screw_count = 3;
coil_screw_dia = 3;         // M3

// Secondary coil mount (horizontal rod holder)
rod_holder_x = 60;
rod_holder_y = 0;
rod_slot_width = 14;        // Slightly larger than 1/2" rod
rod_slot_length = 160;      // 6.3" to hold full rod

// Varactor array mounting holes
varactor_mount = [
    [30, 50], [50, 50], [70, 50]
];
varactor_hole_dia = 2.5;    // M2.5

// Wire passthrough holes
wire_hole_dia = 8;
wire_positions = [
    [-40, 40], [-40, -40], [85, 0]
];

// Resolution
$fn = 80;

module shelf_upper() {
    difference() {
        // Main disc
        cylinder(d=shelf_od, h=shelf_thickness);
        
        // Bifilar coil center cutout
        translate([0, 0, -1])
            cylinder(d=coil_mount_id, h=shelf_thickness + 2);
        
        // Standoff mounting holes
        for (i = [0:standoff_count-1]) {
            angle = i * (360 / standoff_count);
            rotate([0, 0, angle])
                translate([standoff_radius, 0, -1])
                    cylinder(d=standoff_hole_dia, h=shelf_thickness + 2);
        }
        
        // Coil mounting screw holes
        for (i = [0:coil_screw_count-1]) {
            angle = i * (360 / coil_screw_count);
            rotate([0, 0, angle])
                translate([coil_screw_radius, 0, -1])
                    cylinder(d=coil_screw_dia, h=shelf_thickness + 2);
        }
        
        // Secondary coil rod slot
        translate([rod_holder_x, -rod_slot_length/2, -1])
            cube([rod_slot_width, rod_slot_length, shelf_thickness + 2]);
        
        // Varactor mounting holes
        for (pos = varactor_mount) {
            translate([pos[0], pos[1], -1])
                cylinder(d=varactor_hole_dia, h=shelf_thickness + 2);
        }
        
        // Wire passthrough holes
        for (pos = wire_positions) {
            translate([pos[0], pos[1], -1])
                cylinder(d=wire_hole_dia, h=shelf_thickness + 2);
        }
    }
}

// Coil mounting ring (separate piece)
module coil_mount_ring() {
    difference() {
        cylinder(d=coil_mount_od, h=10);
        translate([0, 0, -1])
            cylinder(d=coil_mount_id - 5, h=12);
        
        // Screw holes
        for (i = [0:coil_screw_count-1]) {
            angle = i * (360 / coil_screw_count);
            rotate([0, 0, angle])
                translate([coil_screw_radius, 0, -1])
                    cylinder(d=coil_screw_dia, h=12);
        }
    }
}

// Render
shelf_upper();
color("gray", 0.5)
    translate([0, 0, shelf_thickness])
        coil_mount_ring();

// Export notes:
// MANUFACTURING:
// 1. Laser cut shelf from 1/8" aluminum sheet
// 2. Coil mount ring: 3D print (PETG) or machine from aluminum
// 3. All holes are through-holes
// 4. Deburr all edges
//
// ASSEMBLY:
// - Mounts on M4 standoffs from bottom plate
// - Height: 100mm from bottom plate surface
// - Bifilar coil sits in center with mount ring
// - Secondary coil rod fits in horizontal slot
// - Varactor array mounts on small PCB near coil
