//=============================================================================//
//
// Purpose: Custom spawner for nms_drugstore
//
//=============================================================================//

//-----------------------------------------------------------------------------
// Frequency of random spawning
const THINK_TIME_MIN = 40;
const THINK_TIME_MAX = 120;

const THINK_TIME_DEFAULT = 1.0;

// Amount of point_templates
const POINT_TEMPLATE_COUNT = 4;

//-----------------------------------------------------------------------------
waveController <- null;
currentWave <- 0;
zombiesSpawned <- 0;
initialSpawnTime <- 0.0;

pointTemplates <- [];
for (local i = 0; i < POINT_TEMPLATE_COUNT; i++)
	pointTemplates.append(0);

//-----------------------------------------------------------------------------
// Called after the entity is spawned
//-----------------------------------------------------------------------------
function OnPostSpawn()
{
	// Find the wave controller
	waveController = Entities.FindByClassname(null, "overlord_wave_controller");

	if (!waveController)
	{
		Warning("script error, no wave controller!\n");
		return;
	}
	
	// Connect outputs
	if (waveController.ValidateScriptScope())
	{
		waveController.GetScriptScope().scrDrugstoreSpawner <- self;
		waveController.GetScriptScope().fnOnNewWave <- function()
		{
			// We're in different scope now
			local scriptScope = scrDrugstoreSpawner.GetScriptScope();
			scriptScope.currentWave <- scriptScope.waveController.GetWaveNumber();
			scriptScope.zombiesSpawned <- 0;
			scriptScope.SetInitialSpawnDelay();
		}

		waveController.ConnectOutput("OnNewWave", "fnOnNewWave");
	}

	// Add point_templates to array
	for (local i = 1; i <= POINT_TEMPLATE_COUNT; i++)
	{
		local targetName = format("runners%dtemplate", i);

		local entTemplate = Entities.FindByName(null, targetName);
		if (!entTemplate)
			continue;

		pointTemplates[i - 1] = entTemplate;
	}
	
	SetInitialSpawnDelay();
}

//-----------------------------------------------------------------------------
function SpawnerThink()
{
	if (!waveController || initialSpawnTime > Time())
		return THINK_TIME_DEFAULT;
	
	// Can fire as many times as the current wave
	if (zombiesSpawned >= currentWave)
		return THINK_TIME_DEFAULT;
	
	// Don't fire during low zombie count
	local NPCsSpawned = waveController.GetNPCsSpawned();
	local NPCsKilled = waveController.GetNPCsKilled();
	local zombiesLeft = NPCsSpawned - NPCsKilled;
	
	if (zombiesLeft <= 5)
		return THINK_TIME_DEFAULT;
	
	// Choose random template to spawn from
	local spawnIndex = RandomInt(0, POINT_TEMPLATE_COUNT - 1);
	local entTemplate = pointTemplates[spawnIndex];
	DoEntFire(entTemplate.GetName(), "ForceSpawn", "0", 0, entTemplate, entTemplate);

	zombiesSpawned++;
	
	local nextThinkTime = RandomInt(THINK_TIME_MIN, THINK_TIME_MAX);
	return nextThinkTime;
}

//-----------------------------------------------------------------------------
function SetInitialSpawnDelay()
{
	initialSpawnTime = Time() + RandomInt(THINK_TIME_MIN, THINK_TIME_MAX);
}
