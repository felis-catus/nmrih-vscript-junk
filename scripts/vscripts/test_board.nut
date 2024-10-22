local count = 0;
local used = 0;
local blocked = 0;
local ent = null;
while (ent = Entities.FindByClassname(ent, "nmrih_barricade"))
{
	if (ent.IsInUse())
	{
		used++;
		continue;
	}
	
	if (ent.IsBlocked())
	{
		blocked++;
		continue;
	}
	
	ent.DoBarricade();
	count++;
}

printl(count + " barricades placed! " + used + " in use! " + blocked + " blocked! ");
