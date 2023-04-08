include <BOSL2/std.scad>

// Copy of
// https://www.printables.com/model/163200-openscad-parameterized-honeycomb-storage-wall/files

// OpenSCAD Paramaterized Honeycomb Storage Wall
// Inspired by: https://www.printables.com/model/152592-honeycomb-storage-wall

/* [Size of the wall] */

// Number of hexagons to make in the X axis
numx = 6;

// Number of hexagons to make in the Y axis
numy = 7;

/* [Shape of the hexes - you probably don't want to mess with these]  */
// thickness of the thinner wall
wall = 1.8;  //[:0.01]

// Height of the hexagon
height = 20;

module cell(height, wall) {
  union() {
    tube(od = 2 / sqrt(3) * (height + wall * 2), id = 2 / sqrt(3) * height,
         h = 5, $fn = 6, anchor = BOTTOM);
    up(5) tube(od = 2 / sqrt(3) * (height + wall * 2),
               id1 = 2 / sqrt(3) * height, id2 = 2 / sqrt(3) * (height + wall),
               h = 1, $fn = 6, anchor = BOTTOM);
    up(6) tube(od = 2 / sqrt(3) * (height + wall * 2),
               id = 2 / sqrt(3) * (height + wall), h = 2, $fn = 6,
               anchor = BOTTOM);
  }
}

union() {
  grid2d(n = [ numx * 2, numy ], spacing = sqrt(3) / 2 * (height + wall * 4),
         stagger = true) zrot(30) cell(height, wall);
}

// %cube([170, 170, 2], center=true);
