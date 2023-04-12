include <./lib.scad>
include <BOSL2/std.scad>
$fn = 64;

// The sizes of the tools themselves
tool_sizes = [ 24, 24, 24, 24, 24 ];
tool_hole_sizes = [ 12, 12, 12, 12, 12 ];
tool_spacing = 2;

rounding = 5;

holder_size = [
  // x:
  sum(tool_sizes),
  // y:
  max(tool_sizes),
  // z:
  hexagon_plug_width,
];

echo("HOLDER_SIZE", holder_size);

assert(
    len(tool_sizes) == len(tool_hole_sizes),
    "The tool sizes and the tool hole sizes array must have the same length");

module tool_holder() {
  left(horizontal_hexagon_center_distance / 2)
      hexagon_plug(anchor = BOTTOM + FWD);
  right(horizontal_hexagon_center_distance / 2)
      hexagon_plug(anchor = BOTTOM + FWD);
  linear_extrude(holder_size.z, convexity = 4) tool_holder_2d();
}

module tool_holder_2d() {
  left(holder_size.x / 2) {
    for (i = [0:len(tool_sizes) - 1]) {
      tool_size = tool_sizes[i];
      hole_size = tool_hole_sizes[i];

      x = i == 0 ? 0 : sum(slice(tool_sizes, 0, i - 1));

      right(x + tool_size / 2) fwd(holder_size.y / 2) difference() {
        rounding = i == 0                     ? [ 0, 0, rounding, 0 ]
                   : i == len(tool_sizes) - 1 ? [ 0, 0, 0, rounding ]
                                              : 0;
        rect([ tool_size, holder_size.y ], rounding = rounding);
        circle(d = hole_size);
      }
    }
  }
}

tool_holder();
