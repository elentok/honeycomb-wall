include <./lib.scad>

rounding = 5;
wall_thickness = 2;
epsilon = 0.1;
screw_hole_diameter = m4_screw_hole_diameter;
screwdriver_hole_diameter = 9;
screw_hole_center_distance_from_top = hexagon_height / 2;

// The amount of separators along the X axis.
separators_x = 1;

// The amount of separators along the Y axis.
separators_y = 1;

separator_thickness = 1.2;

// If true, adds a spacer at the bottom so it's aligned
include_spacer = true;
spacer_height = 10;

outer_size = [
  // width:
  3 * hexagon_diameter,

  // depth:
  40,

  // height:
  3 * hexagon_height,
];

inner_size = [
  outer_size.x - wall_thickness * 2,
  outer_size.y - wall_thickness * 2,
  outer_size.z - wall_thickness,
];

cell_size = [
  // x:
  (inner_size.x - separators_x * separator_thickness) / (separators_x + 1),

  // y:
  (inner_size.y - separators_y * separator_thickness) / (separators_y + 1),
];

echo("========================================");
echo("CELL SIZE:", cell_size);
echo("========================================");

module bin() {
  difference() {
    union() {
      base_bin();
      separators();
    }

    if (outer_size.x < horizontal_hexagon_center_distance) {
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

module separators() {
  for (ix = [1:separators_x]) {
    right(ix * cell_size.x + (ix - 1) * separator_thickness)
        left(inner_size.x / 2) separator_x();
  }

  for (iy = [1:separators_y]) {
    fwd(iy * cell_size.y + (iy - 1) * separator_thickness) separator_y();
  }
}

module separator_x() {
  cuboid(
      [
        separator_thickness,
        outer_size.y,
        outer_size.z,
      ],
      anchor = BOTTOM + BACK + LEFT);
}

module separator_y() {
  fwd(wall_thickness) cuboid(
      [
        outer_size.x,
        separator_thickness,
        outer_size.z,
      ],
      anchor = BOTTOM + BACK);
}

module spacer() {
  cuboid([ outer_size.x, hexagon_insert_outer_depth, spacer_height ],
         anchor = BOTTOM + FWD);
}

module hole_mask() {
  up(outer_size.z - screw_hole_center_distance_from_top) {
    // screw hole
    back(epsilon) rotate([ 90, 0, 0 ])
        cylinder(d = screw_hole_diameter, l = wall_thickness + epsilon * 2);

    // screwdriver hole (so you can reach the screws on the back).
    fwd(wall_thickness + epsilon) rotate([ 90, 0, 0 ])
        cylinder(d = screwdriver_hole_diameter, l = outer_size.y);
  }
}

// The bin itself, without the holes.
module base_bin() {
  r = [ 0, 0, rounding, rounding ];

  fwd(outer_size.y / 2) {
    // floor
    linear_extrude(wall_thickness) rect(outer_size, rounding = r);

    // walls
    linear_extrude(outer_size.z) difference() {
      rect(outer_size, rounding = r);
      rect(inner_size, rounding = r);
    }
  }
}

bin();
