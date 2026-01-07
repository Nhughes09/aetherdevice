// ADPS-100 Enclosure Body
// Aluminum cylindrical shell - CNC from tube stock
// Material: 6061 Aluminum, Black Anodize finish
// Units: millimeters

// Design Parameters
body_od = 254;          // 10 inches outer diameter
body_id = 247.6;        // Inner diameter (wall = 3.2mm / 1/8")
body_height = 152.4;    // 6 inches height
wall_thickness = 3.2;   // 1/8 inch wall

// Front panel cutout dimensions
panel_width = 80;
panel_height = 50;
panel_y_offset = 25;    // Distance from bottom

// Ventilation slots (sides)
vent_slot_width = 6;
vent_slot_height = 40;
vent_slot_count = 8;

// Resolution
$fn = 120;

module enclosure_body() {
    difference() {
        // Main cylinder
        cylinder(d=body_od, h=body_height);
        
        // Hollow interior
        translate([0, 0, -1])
            cylinder(d=body_id, h=body_height+2);
        
        // Front panel cutout
        translate([body_od/2 - wall_thickness - 1, -panel_width/2, panel_y_offset])
            cube([wall_thickness + 2, panel_width, panel_height]);
        
        // Ventilation slots (evenly distributed around circumference)
        for (i = [0:vent_slot_count-1]) {
            angle = i * (360 / vent_slot_count) + 22.5; // Offset to avoid front panel
            rotate([0, 0, angle])
                translate([body_od/2 - wall_thickness - 1, -vent_slot_width/2, body_height - vent_slot_height - 20])
                    cube([wall_thickness + 2, vent_slot_width, vent_slot_height]);
        }
    }
}

// Render
enclosure_body();

// Export notes:
// 1. Export as STL for CNC programming
// 2. Manufacturing: Turn from 10" aluminum tube stock
// 3. Cut ventilation slots with CNC mill
// 4. Cut front panel opening with CNC mill
// 5. Deburr all edges
// 6. Black anodize after machining
