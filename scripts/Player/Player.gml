///// PLAYER

/// EVENTS FUNCTIONS
function PlayerInit()
{
	// States
	enum PLAYER_STATE
	{
		GROUND,
		SKY_UP,
		SKY_UP_REDUCTED,
		SKY_DOWN
	}
	
	tilemap = layer_tilemap_get_id("TilesCollide");

	SetState(PLAYER_STATE.GROUND);
	stateArray[0] = PlayerGround;
	stateArray[1] = PlayerSkyUp;
	stateArray[2] = PlayerSkyUpReduced;
	stateArray[3] = PlayerSkyDown;
}

function PlayerUpdate()
{
	//Gravity
	PlayerState();
	
	// Distance ground
	distGround = DistanceToGround();
	
	// State Update
	script_execute(stateArray[state]);
	
	// Jump
	PlayerJump();
	
	// X Moove
	Friction();
	
	// Applicate moove
	PlayerMoveX(xSpd, OnCollideWall);
	PlayerMoveY(ySpd, OnCollideFlat);
}


/// STATE
function PlayerState()
{
	if CollideAtY(1)
	{
		SetState(PLAYER_STATE.GROUND);
	}
	else
	{
		if (ySpd < 0)	SetState(PLAYER_STATE.SKY_UP);
		else			SetState(PLAYER_STATE.SKY_DOWN);
	}
}


/// PHYSICS
function PlayerGround()
{
	ResetJump();
}


function PlayerSkyUp()
{
	JumpReduction();
	Gravity();
}

function PlayerSkyUpReduced()
{
	Gravity();
}

function PlayerSkyDown()
{
	PreshotJump();
	Gravity();
}
