include <./lib.scad>
include <BOSL2/std.scad>
$fn = 64;

module pliers_holder() { inset_hexagon(anchor = BOTTOM + FWD); }

pliers_holder();
