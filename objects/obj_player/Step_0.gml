///@description Movement

var ox = x;
var oy = y;

MovePlayer();

ProcessCollisions(x - ox, y - oy, 5, 5, -5, 15);