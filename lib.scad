include <BOSL2/std.scad>

inset_hexagon_width = 13.4;
inset_hexagon_diameter = 15.47;
inset_hexagon_length = 10;

// This value depends on your printer and its calibration,
// This is the value the worked for my Prusa Mini+ with a 0.6mm nozzle.
inset_hexagon_tolerance = 0.1;

module inset_hexagon(anchor = CENTER, spin = 0, orient = UP) {
  // attachable(anchor, spin, orient, d = inset_hexagon_diameter,
  //            l = inset_hexagon_length, axis = [ 0, 1, 0 ]) {
  attachable(anchor, spin, orient, size = [
    inset_hexagon_diameter, inset_hexagon_length,
    inset_hexagon_width
  ]) {
    rotate([ 90, 0, 0 ]) linear_extrude(inset_hexagon_length, center = true)
        hexagon(d = inset_hexagon_diameter);
    children();
  }
}
