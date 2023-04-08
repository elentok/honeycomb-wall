include <BOSL2/std.scad>

hexagon_diameter = 25.98;
hexagon_height = 22.5;

// The part of the hexagon insert that protrudes from the honeycomb wall.
hexagon_insert_outer_depth = 2.5;

// HEXAGON CENTER DISTANCES
//
// A group of 4 adjacent hexagons looks like this:
//
//     C
//   A   B
//     D
//
// Where C and D are actually touching but A and B are not.

// The vertical distance between the centers of hexagons C and D.
vertical_hexagon_center_distance = 23.6;

// The horizontal distance between the centers of hexagons A and B.
horizontal_hexagon_center_distance = 40.88;

m4_screw_hole_diameter = 4.2;

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
