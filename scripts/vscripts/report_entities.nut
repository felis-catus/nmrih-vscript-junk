// usage: script_execute report_entities

local totalEdicts = 0;
local totalServerOnly = 0;

class entListEntry_t 
{
	constructor(a, b, c)
	{
		ent = a;
		classname = b;
		bServerOnly = c;
	}
	
	ent = null;
	classname = "";
	bServerOnly = false;
	count = 0;
}

local entList = [];
local ent = Entities.First();
while (ent != null)
{
	local bDoPush = true;
	local classname = ent.GetClassname();
	foreach (idx, entry in entList)
	{
		if (entry.classname == classname)
		{
			entry.count++;
			
			bDoPush = false;
			break;
		}
	}
	
	if (bDoPush)
	{
		local bServerOnly = ent.GetEFlags() & EFL_SERVER_ONLY;
		local newEntry = entListEntry_t(ent, classname, bServerOnly);
		newEntry.count++;
		entList.push(newEntry);
	}
	
	ent = Entities.Next(ent);
}

entList.sort(@(a,b) a.classname <=> b.classname);

foreach (idx, entry in entList)
{
	if (!entry.ent)
		continue;
	
	if (entry.bServerOnly)
		totalServerOnly += entry.count;
	else
		totalEdicts += entry.count;

	if (entry.count != 0)
	{
		if (entry.bServerOnly)
			printl(format("Class: %s (%d) [server-only]", entry.classname, entry.count));
		else
			printl(format("Class: %s (%d)", entry.classname, entry.count));
	}
}

if (entList.len() != 0)
{
	// magic numbers here because i couldn't find constants for entity counts, too bad!
	printl(format("Total %d entities (%d/%d edicts, %d/%d server-only)\nNote: Server-only entities won't spend edicts.\n",
		totalEdicts + totalServerOnly, totalEdicts, 2048, totalServerOnly, 2048));
}
