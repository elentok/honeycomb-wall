// Pliers/Cutters holder where the head of the plier points up.
include <./lib.scad>
include <BOSL2/std.scad>
$fn = 64;

epsilon = 0.01;
rounding = 2;
rod_triangle_bottom_width = 9;
rod_triangle_height = 9;
rod_depth = 15;
stopper_triangle_bottom_width = 18;
stopper_triangle_height = 15;
stopper_depth = 4;

module rounded_isosceles_triangle(bottom_width, height, radius) {
  hull() {
    back(radius) {
      left(bottom_width / 2 - radius) circle(r = radius);
      right(bottom_width / 2 - radius) circle(r = radius);
    }
    back(height - radius) circle(r = radius);
  }
}

module pliers_holder() {
  fwd(epsilon) hexagon_plug(anchor = BOTTOM + FWD);

  rotate([ 90, 0, 0 ]) linear_extrude(rod_depth, convexity = 4)
      rounded_isosceles_triangle(rod_triangle_bottom_width, rod_triangle_height,
                                 rounding);

  fwd(rod_depth - epsilon) rotate([ 90, 0, 0 ])
      linear_extrude(stopper_depth, convexity = 4) rounded_isosceles_triangle(
          stopper_triangle_bottom_width, stopper_triangle_height, rounding);
}

// rect([ rod_triangle_bottom_width, rod_triangle_height ], anchor = FWD);

pliers_holder();
