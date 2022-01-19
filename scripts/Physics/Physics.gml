///// PHYSICS

/// MACROS PHYSICS
#macro GRAVITY 1.2
#macro GRAVITY_MAX 20
#macro GROUND_FRICTION 2.5
#macro AIR_FRICTION 3
#macro COYOTE_TIME 5
#macro JUMP -20
#macro REDUCTION_JUMP 0.5
#macro PRESHOT_JUMP_DISTANCE 35


// PlayerMoveX
// Effectue le déplacement en X
// _move		Valeur de la vitesse
// _onCollide	Action à la collision (OPTIONNEL)
function PlayerMoveX(_move)
{
	_move = round(_move);
	
	if (_move != 0)
	{
		var _sign = sign(_move);
		
		while (_move != 0)
		{				
			if (!CollideAtX(_sign))
			{
				x += _sign;
				_move -= _sign;
			}
			else
			{
				if (argument_count > 1)
				{
					script_execute(argument[1]);
				}
				break;
			}
		}
	}
}


// PlayerMoveY
// Effectue le déplacement en Y
// _move		Valeur de la vitesse
// _onCollide	Action à la collision
function PlayerMoveY(_move)
{
	_move = round(_move);
				
	if (_move != 0)
	{
		var _sign = sign(_move);
		
		while (_move != 0)
		{				
			if (!CollideAtY(_sign))
			{
				y += _sign;
				_move -= _sign;
			}
			else
			{
				if (argument_count > 1)
				{
					script_execute(argument[1]);
				}
				break;
			}
		}
	}
}


// CollideAtX
// Vérifie la collision avec le tilemap en X
// _sign	Direction à vérifier (gauche ou droite)
function CollideAtX(_sign)
{
	if (_sign > 0)
	{
		if !(tilemap_get_at_pixel(tilemap, round(bbox_right + _sign), bbox_bottom) == 0
		  && tilemap_get_at_pixel(tilemap, round(bbox_right + _sign), bbox_top) == 0)
		{
			return true;
		}
		
		return false;
	}
	else
	{
		if !(tilemap_get_at_pixel(tilemap, round(bbox_left  + _sign), bbox_bottom) == 0
		  && tilemap_get_at_pixel(tilemap, round(bbox_left  + _sign), bbox_top)	== 0)
		{
			return true;
		}
		
		return false;
	}
}


// CollideAtY
// Vérifie la collision avec le tilemap en Y
// _sign	Direction à vérifier (haut ou bas)
function CollideAtY(_sign)
{
	if (_sign > 0)
	{
		if !(tilemap_get_at_pixel(tilemap, bbox_right, round(bbox_bottom + _sign)) == 0
		  && tilemap_get_at_pixel(tilemap, bbox_left,  round(bbox_bottom + _sign)) == 0)
		{
			return true;
		}
		
		return false;
	}
	else
	{
		if !(tilemap_get_at_pixel(tilemap, bbox_right, round(bbox_top + _sign)) == 0
		  && tilemap_get_at_pixel(tilemap, bbox_left,  round(bbox_top + _sign)) == 0)
		{
			return true;
		}
		
		return false;
	}
}


// Gravity
// Applique la gravité
function Gravity()
{
	ySpd = Approach(ySpd, GRAVITY_MAX, GRAVITY);
}


// PlayerJump
// Applique le saut du joueur
function PlayerJump()
{
	if !(canJump) then exit;

	//JUMP
	if (CoyoteTime())
	{
		if (KeyShortA() or (preshotJump))
		{
			ySpd = JUMP;
			
			canJump = false;
			preshotJump = false;
		}
	}
}


// OnCollideWall
// Stoppe le mouvement à la rencontre d'un mur
function OnCollideWall()
{
	xSpd = 0;
}


// OnCollideFlat
// Stoppe le mouvement à l'arrivée sur du sol
function OnCollideFlat()
{
	ySpd = 0;
}


// DistanceToGround
// Calcule la distance jusqu'au sol
function DistanceToGround()
{
	var _dist = 0;
	 
	while (tilemap_get_at_pixel(tilemap, bbox_right, round(bbox_bottom + _dist)) == 0
		&& tilemap_get_at_pixel(tilemap, bbox_left,  round(bbox_bottom + _dist)) == 0)
	{
		_dist++;
	}
	
	return _dist;
}


// ResetJump
// Rend le saut possible
function ResetJump()
{
	canJump = true;
}


// JumpReduction
// Réduit le saut au relâchement de la barre espace
function JumpReduction()
{
	if !(KeyLongA())
	{
		ySpd *= REDUCTION_JUMP;
		SetState(PLAYER_STATE.SKY_UP_REDUCTED);
	}
}


// CoyoteTime
// Calcule le CoyoteTime
function CoyoteTime()
{
	if (IsState(PLAYER_STATE.GROUND))
	{
		lastGround = current_time;
		return true;
	}
	
	var _coyoteTimeMilli = round((COYOTE_TIME / room_speed) * 1000);
	return (current_time - lastGround < _coyoteTimeMilli);
}


// PreshotJump
// Permet le saut avant l'arrivée sur le sol
function PreshotJump()
{
	if (distGround <= PRESHOT_JUMP_DISTANCE)
	{
		if (KeyShortA()) then preshotJump = true;
	}
	else
	{
		preshotJump = false;
	}
}


// Friction
// Applique une résistance en X
function Friction()
{
	var _dir = (DirRight() + DirLeft());
	var _maxSpd = moveSpd * _dir;
	var _frict = GROUND_FRICTION;
	
	if (!IsState(PLAYER_STATE.GROUND)) _frict = AIR_FRICTION;
	
	xSpd = Approach(xSpd, _maxSpd, _frict);
	
	/////// ANIMATION /////
	//if (_dir != 0) image_xscale = _dir;
}
