///@description Movement

var ox = x;
var oy = y;

MovePlayer();

ProcessCollisions(x - ox, y - oy, 5, 5, -5, 15);
// BBox defined by the last 4 arguments : right, left, top, bottom