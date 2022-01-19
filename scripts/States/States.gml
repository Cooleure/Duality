/// STATES

// Set le state à la valeur donnée en paramètre
function SetState(_state)
{
	state = _state;
}

// Vérifie le state à la valeur donnée en paramètre
function IsState(_state)
{
	return (state == _state);
}

// Renvoie le state de l'instance donnée
function GetState(_object)
{
	return _object.state;
}