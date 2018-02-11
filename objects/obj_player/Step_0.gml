///@description Movement

var ox = x;
var oy = y;

MovePlayer();

ProcessCollisions(x - ox, y - oy, 4, 5, -6, 15);
// BBox defined by the last 4 arguments : right, left, top, bottom