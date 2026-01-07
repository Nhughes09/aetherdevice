// ADPS-100 Bottom Plate
// Aluminum base with ventilation and feet mounts
// Material: 6061 Aluminum, Black Anodize finish
// Units: millimeters

// Design Parameters
plate_od = 254;         // 10 inches - matches body
plate_thickness = 6.35; // 1/4 inch thick
recess_depth = 4;       // Recess for body to sit in
recess_dia = 248.1;     // Slightly larger than body ID

// Ventilation slots
vent_slot_length = 76;  // 3 inches
vent_slot_width = 6;
vent_slot_count = 8;
vent_slot_radius = 80;  // From center

// Feet mounting holes
feet_mount_radius = 100;
feet_mount_count = 4;
feet_mount_dia = 6;     // M6 threaded insert

// Standoff mounting holes for internal shelves
standoff_radius = 95;
standoff_count = 6;
standoff_dia = 4;       // M4 clearance

// Access panel (removable section)
access_panel_width = 60;
access_panel_length = 80;

// Resolution
$fn = 120;

module bottom_plate() {
    difference() {
        union() {
            // Main plate
            cylinder(d=plate_od, h=plate_thickness);
            
            // Raised lip for body alignment
            translate([0, 0, plate_thickness])
                difference() {
                    cylinder(d=recess_dia, h=recess_depth);
                    translate([0, 0, -1])
                        cylinder(d=recess_dia - 8, h=recess_depth + 2);
                }
        }
        
        // Ventilation slots (radial pattern)
        for (i = [0:vent_slot_count-1]) {
            angle = i * (360 / vent_slot_count);
            rotate([0, 0, angle])
                translate([vent_slot_radius - vent_slot_length/2, -vent_slot_width/2, -1])
                    cube([vent_slot_length, vent_slot_width, plate_thickness + 2]);
        }
        
        // Feet mounting holes (threaded inserts)
        for (i = [0:feet_mount_count-1]) {
            angle = i * (360 / feet_mount_count) + 45;
            rotate([0, 0, angle])
                translate([feet_mount_radius, 0, -1])
                    cylinder(d=feet_mount_dia, h=plate_thickness + 2);
        }
        
        // Standoff mounting holes
        for (i = [0:standoff_count-1]) {
            angle = i * (360 / standoff_count);
            rotate([0, 0, angle])
                translate([standoff_radius, 0, -1]) {
                    // Through hole
                    cylinder(d=standoff_dia, h=plate_thickness + recess_depth + 2);
                    // Counterbore for bolt head
                    cylinder(d=8, h=3);
                }
        }
        
        // Center hole for wiring passthrough
        translate([0, 0, -1])
            cylinder(d=20, h=plate_thickness + 2);
        
        // Access panel cutout (rectangular)
        translate([-access_panel_width/2, 40, -1])
            cube([access_panel_width, access_panel_length, plate_thickness + 2]);
        
        // Access panel screw holes (4 corners)
        for (x = [-access_panel_width/2 + 5, access_panel_width/2 - 5]) {
            for (y = [45, 40 + access_panel_length - 5]) {
                translate([x, y, -1])
                    cylinder(d=3, h=plate_thickness + 2);
            }
        }
    }
}

module access_panel() {
    // Removable panel
    difference() {
        translate([-access_panel_width/2 + 1, 41, 0])
            cube([access_panel_width - 2, access_panel_length - 2, plate_thickness - 1]);
        
        // Screw holes
        for (x = [-access_panel_width/2 + 5, access_panel_width/2 - 5]) {
            for (y = [45, 40 + access_panel_length - 5]) {
                translate([x, y, -1])
                    cylinder(d=3.2, h=plate_thickness + 2);
            }
        }
    }
}

// Render
bottom_plate();
color("gray", 0.5)
    translate([0, 0, 0.5])
        access_panel();

// Export notes:
// 1. CNC machine from 1/4" aluminum plate
// 2. Tap M6 holes for rubber feet inserts
// 3. Drill and tap M4 holes for standoffs
// 4. Access panel is separate piece, attaches with M3 screws
// 5. Black anodize after machining
