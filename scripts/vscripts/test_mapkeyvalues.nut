//=============================================================================//
//
// Purpose: Saves persistent total number of killed zombies on this map
//				(for each player, saves using SteamID)
//
// Usage: script_execute test_mapkeyvalues
//
//=============================================================================//

//-----------------------------------------------------------------------------
// TODO: Add MAX_PLAYERS constant in C++ :)
const NMRIH_MAX_PLAYERS = 9;

//-----------------------------------------------------------------------------
// Declare array for scores
g_ZombieKills <- []

// Init score array
for (local i = 0; i < NMRIH_MAX_PLAYERS; i++)
	g_ZombieKills.append(0);
	
// KeyValues for scores
g_KvScores <- null;
	
//-----------------------------------------------------------------------------
// The event callback has a table as input (can be called anything, 'event' here)
// It contains all event values named accordingly
//-----------------------------------------------------------------------------
function OnNPCKilled(event)
{
	// Who was it?
	local plrKiller = GetPlayerByIndex(event.killeridx);
	if (!plrKiller)
		return;
		
	// That's one down
	local index = plrKiller.entindex();
	g_ZombieKills[index]++;
	
	// Announce to the world
	local name = plrKiller.GetPlayerName();
	local kills = g_ZombieKills[index];
	printl(name + " has killed total of " + kills + " zombies!");
	
	// Save to keyvalues
	g_KvScores.SetKeyInt(plrKiller.GetNetworkIDString(), kills);
	WriteMapKeyValues(g_KvScores);
}

//-----------------------------------------------------------------------------
// Main function
//-----------------------------------------------------------------------------

// Don't try this in retail build yet!
local version = Convars.GetStr("nmrih_version");
if (version.find("1.12.1") != null)
{
	Warning("unsupported version\n");
	return;
}

// Try loading keyvalues for this map
g_KvScores = ReadMapKeyValues();
if (!g_KvScores)
{
	// Create new
	g_KvScores = CScriptKeyValues();
	g_KvScores.SetName("ZombieKills");
	WriteMapKeyValues(g_KvScores);
}

// Read keyvalues for each player in-game
for (local i = 0; i < NMRIH_MAX_PLAYERS; i++)
{
	local player = GetPlayerByIndex(i);
	if (!player)
		continue;
	
	local networkId = player.GetNetworkIDString();
	local kv = g_KvScores.FindKey(networkId);
	if (kv)
	{
		g_ZombieKills[i] = kv.GetInt();
	}
}

// Listen to zombie kills
ListenToGameEvent("npc_killed", OnNPCKilled, "ContextNPCKills");
