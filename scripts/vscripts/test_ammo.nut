//=============================================================================//
//
// Purpose: Fills all ammo boxes in the map with random types
//
// Usage: script_execute test_ammo
// Warning: Only works in version 1.12.2+
//
//=============================================================================//

//-----------------------------------------------------------------------------
ammoTypes <- [
	"ammobox_9mm",
	"ammobox_45acp",
	"ammobox_357",
	"ammobox_12gauge",
	"ammobox_22lr",
	"ammobox_308",
	"ammobox_556",
	"ammobox_762mm",
	"ammobox_arrow",
	"ammobox_fuel",
	"ammobox_flare"
];

//-----------------------------------------------------------------------------
local count = 0;
local ent = null;
while (ent = Entities.FindByClassname(ent, "item_ammo_box"))
{
	local idx = RandomInt(0, ammoTypes.len() - 1);
	
	// CItem_AmmoBox bindings
	ent.SetAmmoType(ammoTypes[idx]);
	ent.SetAmmoCount(ent.GetMaxAmmo());
	
	count++;
}

printl(count + " ammo boxes randomized!");
