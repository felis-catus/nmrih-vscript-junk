local ent = null;
while (ent = Entities.FindByClassname(ent, "overlord_zombie_helper"))
{
	ent.DisableSpawning();
	break;
}

printl("overlord spawns disabled.");
