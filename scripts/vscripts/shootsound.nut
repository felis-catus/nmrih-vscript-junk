local player = GetPlayerByIndex(1);
local weapon = player.GetActiveWeapon();

if (!weapon)
	printl("oops");
	
weapon.SetShootSoundOverride("single_shot", "voice/command/default/taunt4.wav");
