include <BOSL2/std.scad>

// This value depends on your printer and its calibration,
// This is the value the worked for my Prusa Mini+ with a 0.6mm nozzle.
inset_hexagon_tolerance = 0.7;

// HEXAGON DIMENSIONS

inset_hexagon_hole_diameter = 15.47;
inset_hexagon_diameter = inset_hexagon_hole_diameter - inset_hexagon_tolerance;
inset_hexagon_width = calc_hexagon_width(inset_hexagon_diameter);
inset_hexagon_length = 10;

module inset_hexagon(anchor = CENTER, spin = 0, orient = UP) {
  attachable(anchor, spin, orient, size = [
    inset_hexagon_diameter, inset_hexagon_length,
    inset_hexagon_width
  ]) {
    rotate([ 90, 0, 0 ]) linear_extrude(inset_hexagon_length, center = true)
        hexagon(d = inset_hexagon_diameter);
    children();
  }
}

// Using the pythagorean theorem:
//
//   (Width/2)^2 + (r/2)^2 = r^2
//
function calc_hexagon_width(diameter) = sqrt(3) * diameter / 2;
