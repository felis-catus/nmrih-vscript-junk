//=============================================================================//
//
// Purpose: Simple runners only script
//
//=============================================================================//

if ("g_bRunnersOnlyMutatorLoaded" in getroottable())
	return;

//-----------------------------------------------------------------------------
Convars.RegisterConvar("sv_runners_only", "1", "Enable runners only mutator.", FCVAR_GAMEDLL);

//-----------------------------------------------------------------------------
Hooks.Add(0, "OnEntitySpawned", function(entity)
{
	if (!Convars.GetBool("sv_runners_only"))
		return;

	if (!entity.IsNPC())
		return;

	if (entity.GetClassname().find("npc_nmrih_", 0) == null)
		return;

	entity.BecomeRunner();
}, "" );

//-----------------------------------------------------------------------------
Entities.EnableEntityListening();

::g_bRunnersOnlyMutatorLoaded <- true;
