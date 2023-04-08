include <./lib.scad>

rounding = 5;
wall_thickness = 2;
epsilon = 0.1;
screw_hole_diameter = m4_screw_hole_diameter;
screwdriver_hole_diameter = 9;
screw_hole_center_distance_from_top = hexagon_height / 2;

// If true, adds a spacer at the bottom so it's aligned
include_spacer = true;
spacer_height = 10;

bin_size = [
  // width:
  3 * hexagon_diameter,

  // depth:
  40,

  // height:
  3 * hexagon_height,
];

module bin() {
  difference() {
    base_bin();

    if (bin_size.x < horizontal_hexagon_center_distance) {
      hole_mask();
    } else {
      left(horizontal_hexagon_center_distance / 2) hole_mask();
      right(horizontal_hexagon_center_distance / 2) hole_mask();
    }
  }

  if (include_spacer) {
    spacer();
  }
}

module spacer() {
  cuboid([ bin_size.x, hexagon_insert_outer_depth, spacer_height ],
         anchor = BOTTOM + FWD);
}

module hole_mask() {
  up(bin_size.z - screw_hole_center_distance_from_top) {
    // screw hole
    back(epsilon) rotate([ 90, 0, 0 ])
        cylinder(d = screw_hole_diameter, l = wall_thickness + epsilon * 2);

    // screwdriver hole (so you can reach the screws on the back).
    fwd(bin_size.y - wall_thickness - epsilon) rotate([ 90, 0, 0 ]) cylinder(
        d = screwdriver_hole_diameter, l = wall_thickness + epsilon * 2);
  }
}

// The bin itself, without the holes.
module base_bin() {
  r = [ 0, 0, rounding, rounding ];

  fwd(bin_size.y / 2) {
    // floor
    linear_extrude(wall_thickness) rect(bin_size, rounding = r);

    // walls
    linear_extrude(bin_size.z) difference() {
      rect(bin_size, rounding = r);
      rect(add_scalar(bin_size, -wall_thickness * 2), rounding = r);
    }
  }
}

bin();
