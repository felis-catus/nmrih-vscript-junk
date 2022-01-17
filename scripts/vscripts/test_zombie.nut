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
local ent = null;
while (ent = Entities.FindByClassname(ent, "npc_nmrih_shamblerzombie"))
{
	// Zombies with shambler classname can still become runners,
	// via inputs, scripts (like this one!), or when ignited
	if (ent.IsRunner())
		continue;
		
	// Players turned zombies always run
	if (ent.IsTurned())
		continue;
		
	// While crawlers can become runners, this is for testing the binding
	if (ent.IsCrawler())
		continue;
		
	// Ditto here for armored
	if (ent.HasArmor())
		continue;

	// Coming to get ya
	ent.BecomeRunner();
	
	count++;
}

printl(count + " zombies became runners!");
