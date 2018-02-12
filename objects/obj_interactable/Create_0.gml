/// @description Create verification lists

trueConditions = ds_list_create();		// Contient les id des instances qui doivent être TRUE
falseConditions = ds_list_create();		// Contient les id des instances qui doivent être FALSE
playerConditions = ds_list_create();	// Contient les noms des flags à réunir

trueOverride = ds_list_create();		// Contient les id des instances qui doivent être TRUE pour override
falseOverride = ds_list_create();		// Contient les id des instances qui doivent être FALSE pour override
playerOverride = ds_list_create();		// Contient les noms des flags à réunir pour override
