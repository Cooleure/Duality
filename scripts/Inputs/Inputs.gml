///// INPUTS

/// EVENTS FUNCTIONS
function InputsUpdate()
{
	enum INPUTS {
		GAMEPAD,
		KEYBOARD
	}

	SetDeviceType();
	GetInputs();
}

function InputsDraw()
{
	DebugInputs();
}


/// DEVICE
function SetDeviceType()
{
	if (gamepad_is_connected(deviceGamepad))	deviceType = INPUTS.GAMEPAD;
	else										deviceType = INPUTS.KEYBOARD;
}

function IsDeviceType(_deviceType)
{
	// L'appelant doit avoir une variable "inputsID" déjà set
	return (inputsID.deviceType == _deviceType);
}


/// GET INPUTS
function GetInputs()
{
	if		(IsDeviceType(INPUTS.GAMEPAD))	Gamepad();
	else if (IsDeviceType(INPUTS.KEYBOARD)) Keyboard();
}

function Gamepad()
{
	gamepad_set_axis_deadzone(0, 0.3);
	
	stickH		= gamepad_axis_value(deviceGamepad, gp_axislh);
	stickV		= gamepad_axis_value(deviceGamepad, gp_axislv);
	
	keyShortA	= gamepad_button_check_pressed(deviceGamepad, gp_face1);
	keyShortB	= gamepad_button_check_pressed(deviceGamepad, gp_face2);
	keyShortX	= gamepad_button_check_pressed(deviceGamepad, gp_face3);
	keyShortY	= gamepad_button_check_pressed(deviceGamepad, gp_face4);
	
	keyLongA	= gamepad_button_check(deviceGamepad, gp_face1);
	keyLongB	= gamepad_button_check(deviceGamepad, gp_face2);
	keyLongX	= gamepad_button_check(deviceGamepad, gp_face3);
	keyLongY	= gamepad_button_check(deviceGamepad, gp_face4);
	
	keyStart	= gamepad_button_check_pressed(deviceGamepad, gp_start);
	keySelect	= gamepad_button_check_pressed(deviceGamepad, gp_select);
}

function Keyboard()
{
	keyLeft		= keyboard_check(ord("Q"));
	keyRight	= keyboard_check(ord("D"));
	keyUp		= keyboard_check(ord("Z"));
	keyDown		= keyboard_check(ord("S"));
	
	keyShortA	= keyboard_check_pressed(vk_down);
	keyShortB	= keyboard_check_pressed(vk_right);
	keyShortX	= keyboard_check_pressed(vk_left);
	keyShortY	= keyboard_check_pressed(vk_up);
	
	keyLongA	= keyboard_check(vk_down);
	keyLongB	= keyboard_check(vk_right);
	keyLongX	= keyboard_check(vk_left);
	keyLongY	= keyboard_check(vk_up);
	
	keyStart	= keyboard_check_pressed(ord("E"));
	keySelect	= keyboard_check_pressed(ord("A"));
}


/// ACCESSORS (l'appelant doit avoir une variable "inputsID" déjà set)
function KeyLeft()		{ return inputsID.keyLeft; }
function KeyRight()		{ return inputsID.keyRight; }
function KeyUp()		{ return inputsID.keyUp; }
function KeyDown()		{ return inputsID.keyDown; }

function StickH()		{ return inputsID.stickH; }
function StickV()		{ return inputsID.stickV; }

function KeyShortA()	{ return inputsID.keyShortA; }
function KeyShortB()	{ return inputsID.keyShortB; }
function KeyShortX()	{ return inputsID.keyShortX; }
function KeyShortY()	{ return inputsID.keyShortY; }

function KeyLongA()		{ return inputsID.keyLongA; }
function KeyLongB()		{ return inputsID.keyLongB; }
function KeyLongX()		{ return inputsID.keyLongX; }
function KeyLongY()		{ return inputsID.keyLongY; }

function KeyStart()		{ return inputsID.keyStart; }
function KeySelect()	{ return inputsID.keySelect; }


/// DIRECTION
function DirLeft()
{
	if		(IsDeviceType(INPUTS.GAMEPAD))	if (StickH() < 0) return StickH() else return 0;
	else if (IsDeviceType(INPUTS.KEYBOARD)) return (-KeyLeft());
}

function DirRight()
{
	if		(IsDeviceType(INPUTS.GAMEPAD))	if (StickH() > 0) return StickH() else return 0;
	else if (IsDeviceType(INPUTS.KEYBOARD)) return (KeyRight());
}

function DirUp()
{
	if		(IsDeviceType(INPUTS.GAMEPAD))	if (StickV() < 0) return StickV() else return 0;
	else if (IsDeviceType(INPUTS.KEYBOARD)) return (-KeyUp());
}

function DirDown()
{
	if		(IsDeviceType(INPUTS.GAMEPAD))	if (StickV() > 0) return StickV() else return 0;
	else if (IsDeviceType(INPUTS.KEYBOARD)) return (KeyDown());
}


/// DEBUG
function DebugInputs()
{
	// Gamepad
	if (IsDeviceType(INPUTS.GAMEPAD))
	{
		draw_text(x, 10, "GAMEPAD (DEVICE : " + string(gamepad_get_description(deviceGamepad)) + ")"); 
		
		draw_text(x, 50, "StickH :" + string(StickH()));
		draw_text(x, 70, "StickV :" + string(StickV()));
		
		draw_text(x, 110, "KeyShortA :" + string(KeyShortA()));
		draw_text(x, 130, "KeyShortB :" + string(KeyShortB()));
		draw_text(x, 150, "KeyShortX :" + string(KeyShortX()));
		draw_text(x, 170, "KeyShortY :" + string(KeyShortY()));
		
		draw_text(x, 210, "KeyLongA :" + string(KeyLongA()));
		draw_text(x, 230, "KeyLongB :" + string(KeyLongB()));
		draw_text(x, 250, "KeyLongX :" + string(KeyLongX()));
		draw_text(x, 270, "KeyLongY :" + string(KeyLongY()));
			
		draw_text(x, 310, "KeyStart :"	+ string(KeyStart()));
		draw_text(x, 330, "KeySelect :" + string(KeySelect()));
	}
	
	//Keyboard
	else if (IsDeviceType(INPUTS.KEYBOARD))
	{
		draw_text(x, 10, "KEYBOARD");
		
		draw_text(x, 50, "KeyLeft :"	+ string(KeyLeft()));
		draw_text(x, 70, "KeyRight :"	+ string(KeyRight()));
		draw_text(x, 90, "KeyUp :"		+ string(KeyUp()));
		draw_text(x, 110, "KeyDown :"	+ string(KeyDown()));

		draw_text(x, 150, "KeyShortA :" + string(KeyShortA()));
		draw_text(x, 170, "KeyShortB :" + string(KeyShortB()));
		draw_text(x, 190, "KeyShortX :" + string(KeyShortX()));
		draw_text(x, 210, "KeyShortY :" + string(KeyShortY()));
		
		draw_text(x, 250, "KeyLongA :" + string(KeyLongA()));
		draw_text(x, 270, "KeyLongB :" + string(KeyLongB()));
		draw_text(x, 290, "KeyLongX :" + string(KeyLongX()));
		draw_text(x, 310, "KeyLongY :" + string(KeyLongY()));
		
		draw_text(x, 350, "KeyStart :"	+ string(KeyStart()));
		draw_text(x, 370, "KeySelect :" + string(KeySelect()));

	}
}