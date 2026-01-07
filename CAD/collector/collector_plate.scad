// ADPS-100 Copper Collector Plate
// Top aetheric collection surface with radial spokes
// Material: 99.9% Pure Copper, 14 gauge (1.6mm)
// Finish: Mirror polished (electrolytic)
// Units: millimeters

// Design Parameters
plate_od = 254;             // 10 inches outer diameter
plate_thickness = 1.6;      // 14 gauge
center_cutout = 152.4;      // 6 inch center opening for acrylic

// Radial spoke design
spoke_count = 8;
spoke_width = 9.5;          // 3/8 inch
spoke_length = 50.8;        // ~2 inches (from center cutout edge outward)

// Collection points (brass spheres mount here)
collection_point_count = 24;
collection_point_dia = 3.2;  // Hole for brass sphere stem
collection_point_radius = 120; // Near outer edge

// Mounting holes (matches top cap)
mount_hole_count = 8;
mount_hole_dia = 3.2;        // M3 clearance
mount_hole_radius = 120;

// Wire terminal hole
terminal_hole_dia = 4;
terminal_hole_x = 60;
terminal_hole_y = 0;

// Resolution
$fn = 120;

module collector_plate() {
    difference() {
        union() {
            // Main ring plate
            difference() {
                cylinder(d=plate_od, h=plate_thickness);
                translate([0, 0, -1])
                    cylinder(d=center_cutout, h=plate_thickness + 2);
            }
            
            // Radial spokes (bridges across center cutout)
            for (i = [0:spoke_count-1]) {
                angle = i * (360 / spoke_count);
                rotate([0, 0, angle])
                    translate([-spoke_width/2, -center_cutout/2 + 5, 0])
                        cube([spoke_width, center_cutout - 10, plate_thickness]);
            }
            
            // Center hub (where spokes meet)
            cylinder(d=30, h=plate_thickness);
        }
        
        // Center hub hole (for secondary coil connection)
        translate([0, 0, -1])
            cylinder(d=8, h=plate_thickness + 2);
        
        // Collection point holes (for brass sphere mounting)
        for (i = [0:collection_point_count-1]) {
            angle = i * (360 / collection_point_count);
            rotate([0, 0, angle])
                translate([collection_point_radius, 0, -1])
                    cylinder(d=collection_point_dia, h=plate_thickness + 2);
        }
        
        // Mounting holes
        for (i = [0:mount_hole_count-1]) {
            angle = i * (360 / mount_hole_count);
            rotate([0, 0, angle])
                translate([mount_hole_radius, 0, -1])
                    cylinder(d=mount_hole_dia, h=plate_thickness + 2);
        }
        
        // Wire terminal hole
        translate([terminal_hole_x, terminal_hole_y, -1])
            cylinder(d=terminal_hole_dia, h=plate_thickness + 2);
    }
}

// Brass collection spheres (for visualization)
module brass_spheres() {
    color("gold")
    for (i = [0:collection_point_count-1]) {
        angle = i * (360 / collection_point_count);
        rotate([0, 0, angle])
            translate([collection_point_radius, 0, plate_thickness])
                sphere(d=3);
    }
}

// Render
color("orange")
    collector_plate();
brass_spheres();

// Export notes:
// MANUFACTURING PROCESS:
// 1. Start with 99.9% pure copper sheet, 14 gauge (1.6mm thick)
// 2. Waterjet or laser cut the spoke pattern (prefer waterjet for copper)
// 3. Drill collection point holes (3.2mm) after cutting
// 4. Drill mounting holes (3.2mm)
// 5. Mirror polish the top surface (electrolytic polishing recommended)
// 6. Solder brass spheres into collection point holes
// 7. Attach ring terminal for wire connection at terminal hole
//
// CRITICAL: Do not use plated copper or copper alloy
// Must be pure copper for conductivity
