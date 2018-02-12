var newState = true;

// Conditions normales
for (var i = 0; i < ds_list_size(trueConditions); i++)
	newState = newState & global.states[? trueConditions[| i]];
for (var i = 0; i < ds_list_size(falseConditions); i++)
	newState = newState & !global.states[? falseConditions[| i]];
for (var i = 0; i < ds_list_size(playerConditions); i++) {
	// TODO
}
	
// Override
for (var i = 0; i < ds_list_size(trueOverride); i++)
	newState = newState | global.states[? trueOverride[| i]];
for (var i = 0; i < ds_list_size(falseOverride); i++)
	newState = newState | !global.states[? falseOverride[| i]];
for (var i = 0; i < ds_list_size(playerOverride); i++) {
	// TODO
}

if (newState != state) {
	state = newState;
	global.states[? id] = newState;
	event_user(0);
}