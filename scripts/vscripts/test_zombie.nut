//=============================================================================//
//
// Purpose: Zombies become runners! (excl. crawlers and armored)
//
// Usage: script_execute test_zombie
// Warning: Only works in version 1.12.2+
//
//=============================================================================//

//-----------------------------------------------------------------------------
local count = 0;
local runners = 0;
local turned = 0;
local crawlers = 0;
local armored = 0;

local zombie = null;
while (zombie = Entities.FindByClassname(zombie, "npc_nmrih_shamblerzombie"))
{
	// Zombies with shambler classname can still become runners,
	// via inputs, scripts (like this one!), or when ignited
	if (zombie.IsRunner())
	{
		runners++;
		continue;
	}
		
	// Players turned zombies always run
	if (zombie.IsTurned())
	{
		turned++;
		continue;
	}
		
	// While crawlers can become runners, this is for testing the binding
	if (zombie.IsCrawler())
	{
		crawlers++;
		continue;
	}
		
	// Ditto here for armored
	if (zombie.HasArmor())
	{
		armored++;
		continue;
	}

	// Tap into their scope to add loot drops on death
	if (zombie.ValidateScriptScope())
	{
		zombie.GetScriptScope().OnDeath <- function()
		{
			// Drop some loot
			self.SpawnLootWeapon("fa_m92fs");
			self.SpawnLootWeapon("exp_tnt");
			self.SpawnLootAmmo("ammobox_9mm");
			
			// Allow to die
			return true;
		}
	}
	
	// Turn into Hunters!
	zombie.SetModelOverride("models/nmr_zombie/hunter_infected.mdl");

	// Coming to get ya
	zombie.BecomeRunner();
	
	count++;
}

printl(count + " zombies became runners!");

if (runners != 0)
	printl(runners + " were already runners.");

if (turned != 0)
	printl(turned + " were turned.");

if (crawlers != 0)
	printl(crawlers + " were crawlers.");
	
if (armored != 0)
	printl(armored + " were armored.");
