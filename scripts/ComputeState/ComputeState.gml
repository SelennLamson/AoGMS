var newState = ParseConditionArray(condition);

if (newState != state) {
	state = newState;
	global.states[? id] = newState;
	event_user(0);
}






