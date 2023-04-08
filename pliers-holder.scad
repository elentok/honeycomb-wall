include <./lib.scad>
include <BOSL2/std.scad>
$fn = 64;

plier_thickness = 16;
plier_width = 45;
amount_of_pliers = 2;
wall_thickness = 3;
rounding = 3;

size = [
  plier_width + wall_thickness * 2,
  plier_thickness* amount_of_pliers + wall_thickness*(amount_of_pliers + 1),
  inset_hexagon_width
];

plier_hole_size = [ plier_width, plier_thickness ];

echo("Size:", size);

module pliers_holder() {
  inset_hexagon(anchor = BOTTOM + FWD);

  linear_extrude(size.z) difference() {
    rect(size, anchor = BACK, rounding = rounding);
    for (plier_index = [1:amount_of_pliers]) {
      y = wall_thickness * plier_index + plier_thickness * (plier_index - 1);
      fwd(y) rect(plier_hole_size, anchor = BACK);
    }
  }
}

pliers_holder();
