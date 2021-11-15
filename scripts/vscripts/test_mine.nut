//=============================================================================//
//
// Purpose: Simple land mine, to be used on props
// Think function: MineThink
//
//=============================================================================//

//-----------------------------------------------------------------------------
const TRIGGER_RADIUS = 100.0;
const FUSE_TIME = 5.0;
const EXPLOSION_MAGNITUDE = 500;
const EXPLOSION_RADIUS = 500;
const BEEP_SOUND_NAME = "Blitz.TimerBeep";

// Ignore players?
const bNPCOnly = false;

//-----------------------------------------------------------------------------
bPrimed <- false;
bDetonated <- false;
explosionTime <- 0.0;
nextBeepTime <- 0.0;

//-----------------------------------------------------------------------------
// Called after the entity is spawned
//-----------------------------------------------------------------------------
function OnPostSpawn()
{
	self.PrecacheSoundScript(BEEP_SOUND_NAME);
}

//-----------------------------------------------------------------------------
function MineThink()
{
	if (bPrimed)
	{
		if (explosionTime <= Time())
		{
			Detonate();
			return;
		}
		
		if (nextBeepTime <= Time())
		{
			EmitSoundOn(BEEP_SOUND_NAME, self);
			nextBeepTime = Time() + 0.20;
		}
		
		return;
	}

	local ent = null;
	while (ent = Entities.FindInSphere(ent, self.GetOrigin(), TRIGGER_RADIUS))
	{
		// Prime on players and npcs
		if (ent.IsNPC() || (!bNPCOnly && ent.IsPlayer()))
		{
			bPrimed = true;
			
			explosionTime = Time() + FUSE_TIME;
		}
	}
}

//-----------------------------------------------------------------------------
function Detonate()
{
	if (bDetonated)
		return;
	
	local envExplosion = Entities.CreateByClassname("env_explosion");
	envExplosion.SetOrigin(self.GetOrigin());
	envExplosion.__KeyValueFromInt("iMagnitude", EXPLOSION_MAGNITUDE);
	envExplosion.__KeyValueFromInt("iRadiusOverride", EXPLOSION_RADIUS);
	
	envExplosion.AcceptInput("Explode", "", null, null);
	envExplosion.AcceptInput("Kill", "", null, null);
	
	self.AcceptInput("Kill", "", null, null);
	
	// Prevent from detonating again while being removed
	bDetonated = true;
}
