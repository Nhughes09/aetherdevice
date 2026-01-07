// ADPS-100 Coil Mounting Brackets
// Holds bifilar toroidal coil and secondary rod coil
// Material: PETG (3D printed) or CNC aluminum
// Units: millimeters

// ============================================
// PART 1: BIFILAR COIL MOUNT RING
// ============================================
// Holds 4x stacked FT-240-43 toroids (61mm OD x 50.8mm H stack)

// Toroid dimensions
toroid_od = 61;             // FT-240-43 outer diameter
toroid_id = 35.6;           // FT-240-43 inner diameter
toroid_stack_height = 50.8; // 4 toroids x 12.7mm each

// Mount ring dimensions
ring_od = 75;
ring_id = toroid_od + 1;    // Slight clearance
ring_height = 15;
ring_lip = 3;               // Lip to hold coil

// Mounting tabs
tab_count = 3;
tab_width = 15;
tab_length = 12;
tab_hole_dia = 3;           // M3

$fn = 80;

module bifilar_mount_ring() {
    difference() {
        union() {
            // Main ring body
            cylinder(d=ring_od, h=ring_height);
            
            // Mounting tabs
            for (i = [0:tab_count-1]) {
                angle = i * (360 / tab_count);
                rotate([0, 0, angle])
                    translate([ring_od/2 - 2, -tab_width/2, 0])
                        cube([tab_length, tab_width, ring_height/2]);
            }
        }
        
        // Center bore (coil sits here)
        translate([0, 0, ring_lip])
            cylinder(d=ring_id, h=ring_height);
        
        // Bottom lip cutout (smaller diameter)
        translate([0, 0, -1])
            cylinder(d=ring_id - 6, h=ring_height + 2);
        
        // Wire exit slots (2 opposite sides)
        for (angle = [0, 180]) {
            rotate([0, 0, angle])
                translate([ring_od/2 - 5, -4, -1])
                    cube([10, 8, ring_height + 2]);
        }
        
        // Tab mounting holes
        for (i = [0:tab_count-1]) {
            angle = i * (360 / tab_count);
            rotate([0, 0, angle])
                translate([ring_od/2 + tab_length/2, 0, -1])
                    cylinder(d=tab_hole_dia, h=ring_height);
        }
    }
}

// ============================================
// PART 2: SECONDARY COIL ROD HOLDERS (pair)
// ============================================
// Holds 1/2" (12.7mm) diameter ferrite rod horizontally

rod_dia = 12.7;
holder_width = 20;
holder_height = 25;
holder_depth = 15;
clamp_gap = 2;              // Gap for rod insertion

module rod_holder() {
    difference() {
        // Main body
        cube([holder_width, holder_depth, holder_height]);
        
        // Rod channel (semicircle)
        translate([holder_width/2, -1, holder_height - rod_dia/2 - 3])
            rotate([-90, 0, 0])
                cylinder(d=rod_dia + 0.5, h=holder_depth + 2);
        
        // Clamp slot
        translate([holder_width/2 - clamp_gap/2, -1, holder_height - rod_dia/2 - 3])
            cube([clamp_gap, holder_depth + 2, rod_dia + 5]);
        
        // Mounting hole (bottom)
        translate([holder_width/2, holder_depth/2, -1])
            cylinder(d=3, h=10);
        
        // Clamping screw hole (side)
        translate([-1, holder_depth/2, holder_height - rod_dia/2 - 3])
            rotate([0, 90, 0])
                cylinder(d=2.5, h=holder_width + 2);
    }
}

// ============================================
// PART 3: VARACTOR ARRAY MOUNT
// ============================================
// Small bracket to hold varactor diode PCB near coil

varactor_pcb_width = 25;
varactor_pcb_length = 40;
bracket_height = 15;

module varactor_bracket() {
    difference() {
        union() {
            // Base plate
            cube([varactor_pcb_width + 6, varactor_pcb_length + 6, 2]);
            
            // Side walls
            cube([3, varactor_pcb_length + 6, bracket_height]);
            translate([varactor_pcb_width + 3, 0, 0])
                cube([3, varactor_pcb_length + 6, bracket_height]);
        }
        
        // PCB slot
        translate([3, 3, 1])
            cube([varactor_pcb_width, varactor_pcb_length, 2]);
        
        // Mounting holes
        translate([varactor_pcb_width/2 + 3, 3, -1])
            cylinder(d=2.5, h=4);
        translate([varactor_pcb_width/2 + 3, varactor_pcb_length + 3, -1])
            cylinder(d=2.5, h=4);
    }
}

// ============================================
// RENDER ALL PARTS
// ============================================

// Bifilar mount ring (main part)
bifilar_mount_ring();

// Rod holders (pair)
translate([100, 0, 0])
    rod_holder();
translate([130, 0, 0])
    rod_holder();

// Varactor bracket
translate([0, 100, 0])
    varactor_bracket();

// Export notes:
// MANUFACTURING:
// Option 1: 3D Print in PETG or ABS
//   - Layer height: 0.2mm
//   - Infill: 50%
//   - Walls: 3
//   - Supports: Yes for rod holders
//
// Option 2: CNC from Delrin/HDPE
//   - More durable for production
//   - Same dimensions
//
// ASSEMBLY:
// 1. Bifilar mount ring attaches to upper shelf with M3 screws
// 2. Rod holders mount to shelf slot, hold secondary coil rod
// 3. Varactor bracket mounts near coil, holds tuning circuit PCB
