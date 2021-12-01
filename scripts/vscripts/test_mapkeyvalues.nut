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
// KeyValues for scores
g_KvScores <- null;
	
//-----------------------------------------------------------------------------
// The event callback has a table as input (can be called anything, 'event' here)
// It contains all event values named accordingly
//-----------------------------------------------------------------------------
function OnNPCKilled(event)
{
	// Who was it?
	local player = GetPlayerByIndex(event.killeridx);
	if (!player)
		return;
		
	// That's one down
	local kv = g_KvScores.FindKey(player.GetNetworkIDString());
	if (!kv)
		return;
	
	// Increment kills and save to keyvalues
	local kills = kv.GetInt();
	kills++;
	kv.SetInt(kills);
	WriteMapKeyValues(g_KvScores);
	
	// Announce to the world
	local name = player.GetPlayerName();
	printl(name + " has killed total of " + kills + " zombies!");
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

// Listen to zombie kills
ListenToGameEvent("npc_killed", OnNPCKilled, "ContextNPCKills");
