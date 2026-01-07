// ADPS-100 Front Panel
// Aluminum panel with display, LED, and USB cutouts
// Material: 6061 Aluminum, Black Anodize finish
// Units: millimeters

// Design Parameters (must match enclosure_body cutout)
panel_width = 80;
panel_height = 50;
panel_thickness = 2;    // Thin panel, flush mount

// OLED display cutout (0.91" 128x32)
oled_width = 25;
oled_height = 14;
oled_x_offset = 10;     // From left edge
oled_y_offset = 28;     // From bottom

// LED holes (3x 5mm LEDs)
led_dia = 5.2;          // 5mm LED with bezel
led_spacing = 12;
led_y_offset = 38;      // From bottom
led_x_start = 10;       // First LED from left

// USB-C port cutout
usbc_width = 9;
usbc_height = 3.5;
usbc_x_offset = 50;
usbc_y_offset = 10;

// USB-A port cutouts (2x stacked)
usba_width = 13;
usba_height = 5.5;
usba_x_offset = 50;
usba_y_offset_1 = 20;
usba_y_offset_2 = 28;

// Mounting holes (4 corners)
mount_hole_dia = 2.5;   // M2.5
mount_inset = 4;

// Resolution
$fn = 60;

module front_panel() {
    difference() {
        // Main panel body
        cube([panel_width, panel_height, panel_thickness]);
        
        // OLED display window
        translate([oled_x_offset, oled_y_offset, -1])
            cube([oled_width, oled_height, panel_thickness + 2]);
        
        // LED holes (Green, Blue, Orange)
        for (i = [0:2]) {
            translate([led_x_start + i * led_spacing, led_y_offset, -1])
                cylinder(d=led_dia, h=panel_thickness + 2);
        }
        
        // USB-C port
        translate([usbc_x_offset, usbc_y_offset, -1])
            hull() {
                translate([usbc_height/2, 0, 0])
                    cylinder(d=usbc_height, h=panel_thickness + 2);
                translate([usbc_width - usbc_height/2, 0, 0])
                    cylinder(d=usbc_height, h=panel_thickness + 2);
            }
        
        // USB-A port 1
        translate([usba_x_offset, usba_y_offset_1, -1])
            cube([usba_width, usba_height, panel_thickness + 2]);
        
        // USB-A port 2
        translate([usba_x_offset, usba_y_offset_2, -1])
            cube([usba_width, usba_height, panel_thickness + 2]);
        
        // Corner mounting holes
        translate([mount_inset, mount_inset, -1])
            cylinder(d=mount_hole_dia, h=panel_thickness + 2);
        translate([panel_width - mount_inset, mount_inset, -1])
            cylinder(d=mount_hole_dia, h=panel_thickness + 2);
        translate([mount_inset, panel_height - mount_inset, -1])
            cylinder(d=mount_hole_dia, h=panel_thickness + 2);
        translate([panel_width - mount_inset, panel_height - mount_inset, -1])
            cylinder(d=mount_hole_dia, h=panel_thickness + 2);
    }
}

// Render with color coding for cutouts
front_panel();

// Labels (for reference only, not manufactured)
color("white") {
    translate([led_x_start, led_y_offset + 6, panel_thickness])
        linear_extrude(0.5)
            text("G", size=3, halign="center");
    translate([led_x_start + led_spacing, led_y_offset + 6, panel_thickness])
        linear_extrude(0.5)
            text("B", size=3, halign="center");
    translate([led_x_start + 2*led_spacing, led_y_offset + 6, panel_thickness])
        linear_extrude(0.5)
            text("O", size=3, halign="center");
}

// Export notes:
// 1. Laser cut from 2mm aluminum sheet OR CNC from flat stock
// 2. All cutouts are through-holes
// 3. Deburr all edges carefully
// 4. Black anodize to match enclosure
// 5. LEDs use press-fit bezels (5mm chrome bezels)
// 6. OLED mounts from behind with double-sided tape
// 7. USB ports are panel-mount modules with included flanges
