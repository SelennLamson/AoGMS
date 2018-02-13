var cond = argument0;

var result = false;
var nextIsAnd = false;
var negateNext = false;
var currentCondition;

for (var i = 0; i < array_length_1d(cond); i++) {
	var arg = cond[i];
	if (typeof(arg) == "number") {
		currentCondition = negateNext xor global.states[? arg];
		negateNext = false;
		if (nextIsAnd)
			result = result && currentCondition;
		else
			result = result || currentCondition;
	} else if (typeof(arg) == "array") {
		currentCondition = negateNext xor ParseConditionArray(arg);
		negateNext = false;
		if (nextIsAnd)
			result = result && currentCondition;
		else
			result = result || currentCondition;
	}
	else if (typeof(arg) == "string")
		if (arg == "&&")
			nextIsAnd = true;
		else if (arg == "||")
			nextIsAnd = false;
		else if (arg == "!")
			negateNext = true;
		else {
			currentCondition = negateNext xor (ds_list_find_index(global.flags, arg) != -1);
			negateNext = false;
			if (nextIsAnd)
				result = result && currentCondition;
			else
				result = result || currentCondition;
		}
}

return result;