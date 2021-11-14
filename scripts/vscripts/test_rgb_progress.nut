//=============================================================================//
//
// Purpose: RGB progress bar, to be used on logic_progress
//
//=============================================================================//

//-----------------------------------------------------------------------------
const SATURATION = 0.85;
const BRIGHTNESS = 1.0;

//-----------------------------------------------------------------------------
function HSVtoRGB(hsv)
{         
	if ( hsv.y == 0.0 )
	{
		return Vector(hsv.z, hsv.z, hsv.z);
	}

	local hue = hsv.x;
	if (hue == 360.0)
	{	
		hue = 0.0;
	}
	
	hue /= 60.0;
	local i = hue.tointeger();	// integer part
	local f = hue - i;			// fractional part
	local p = hsv.z * (1.0 - hsv.y);
	local q = hsv.z * (1.0 - hsv.y * f);
	local t = hsv.z * (1.0 - hsv.y * (1.0 - f));
	
	local r, g, b;
	switch (i)
	{
		case 0: r = hsv.z; g = t; b = p; break;
		case 1: r = q; g = hsv.z; b = p; break;
		case 2: r = p; g = hsv.z; b = t; break;
		case 3: r = p; g = q; b = hsv.z; break;
		case 4: r = t; g = p; b = hsv.z; break;
		case 5: r = hsv.z; g = p; b = q; break;
	}
	
	return Vector(r * 255.0, g * 255.0, b * 255.0);
}

//-----------------------------------------------------------------------------
// Called after the entity is spawned
//-----------------------------------------------------------------------------
function OnPostSpawn()
{
	// initialize because it appears in default color for split second
	// TODO: nvm it's broekn in code hud element
	//local rgb = HSVtoRGB(Vector(128, SATURATION, BRIGHTNESS));
	//self.AcceptInput("SetColor", format("%d %d %d", rgb.x, rgb.y, rgb.z), null, null);
}

//-----------------------------------------------------------------------------
function ProgressThink()
{
	local hue = SimpleSplineRemapValClamped(self.GetHealth(), 0, 100, 0, 128);
	local hsv = Vector(hue, SATURATION, BRIGHTNESS);
	local rgb = HSVtoRGB(hsv);
	self.AcceptInput("SetColor", format("%d %d %d", rgb.x, rgb.y, rgb.z), null, null);
}
