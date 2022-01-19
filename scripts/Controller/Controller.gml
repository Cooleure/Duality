///// CONTROLLER

/// EVENTS FUNCTIONS
function ControllerInit()
{
	// Create Inputs
	inputsList = ds_list_create();
	ds_list_add(inputsList, instance_create_depth(10, y, 0, oInputs));
	ds_list_add(inputsList, instance_create_depth(900, y, 0, oInputs));

	inputsList[| 0].deviceGamepad = 0;
	inputsList[| 1].deviceGamepad = 1;


	// Create players
	playerList = ds_list_create();
	ds_list_add(playerList, instance_create_depth(336, 112, 100, oPlayer));
	ds_list_add(playerList, instance_create_depth(976, 112, 100, oPlayer));

	with (playerList[| 0])
	{
		playerNO = 0;
		inputsID = other.inputsList[| 0];
		sprite_index = sPlayer1;
	}

	with (playerList[| 1])
	{
		playerNO = 1;
		inputsID = other.inputsList[| 1];
		sprite_index = sPlayer2;
	}
}