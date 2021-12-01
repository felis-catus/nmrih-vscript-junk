//=============================================================================//
//
// Purpose: Evil logic_ruleset hacking to force a random runner spawn!
// Usage: script_execute runnerhack
//
//=============================================================================//

//-----------------------------------------------------------------------------
const RUNNER_COUNT = 5; // How many runners to spawn?

//-----------------------------------------------------------------------------
funcZombieSpawns <- [];
spawnCount <- 0;

//-----------------------------------------------------------------------------
function SpawnRunners(count)
{
	if (spawnCount == 0)
	{
		Warning("script error: no zombie spawns\n");
		return;
	}
	
	// Choose random spawn
	local idx = RandomInt(0, spawnCount - 1);
	local entSpawn = funcZombieSpawns[idx];
	if (!entSpawn)
		return;
		
	entSpawn.AcceptInput("InputInstantSpawn", format("%d", count), null, null);
}

//-----------------------------------------------------------------------------
function ForceRunnerChanceByRuleset(entRuleset, chance)
{
	local version = Convars.GetStr("nmrih_version");
	if (version.find("1.12.1"))
		entRuleset.AcceptInput("ApplyCvars", format("ov_runner_chance %f", chance), null, null);
	else
		RulesetManager.ApplyCvars(format("ov_runner_chance %f", chance));
}

//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------
local entZombieSpawn = null;
while (entZombieSpawn = Entities.FindByClassname(entZombieSpawn, "func_zombie_spawn"))
{
	funcZombieSpawns.append(entZombieSpawn);
	spawnCount++;
}

local savedRunnerChance = Convars.GetFloat("ov_runner_chance");
local logicRuleset = Entities.CreateByClassname("logic_ruleset");

ForceRunnerChanceByRuleset(logicRuleset, 1.0);

SpawnRunners(RUNNER_COUNT);

// Reset on same frame to prevent excess runners
ForceRunnerChanceByRuleset(logicRuleset, savedRunnerChance);