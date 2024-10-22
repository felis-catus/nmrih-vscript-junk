local count = 0;
local depleted = 0;
local ent = null;
while (ent = Entities.FindByClassname(ent, "nmrih_health_station_location"))
{
	if (ent.IsFadingOut())
	{
		continue;
	}
	
	if (ent.IsActive())
	{
		ent.BecomeDepleted();
		
		depleted++;
		continue;
	}
	
	ent.BecomeActive();
	ent.SetStationHealth(420);
	count++;
}

printl(count + " health stations activated! " + depleted + " depleted!");
