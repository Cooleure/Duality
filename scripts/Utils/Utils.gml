// Approach
// Approche _a de _b d'un certain montant sans dépasser la valeur
// Fonctionne dans les deux sens
// _a		Valeur à approcher
// _b		Valeur Max ou Min à ne pas dépasser
// _amount	Montant
function Approach(_a, _b, _amount)
{
	if (_a < _b) return min(_a + _amount, _b); 
	else return max(_a - _amount, _b);
}

// Vérifie que _x est entre _a et _b
function Between(_x, _a, _b)
{
	var _left = min(_a, _b);
	var _right = max(_a, _b);

	return (_left <= _x and _x <= _right);
}
