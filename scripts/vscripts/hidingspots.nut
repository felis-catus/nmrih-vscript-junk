local area = NavMesh.GetNearestNavArea(GetPlayerByIndex(1).GetOrigin(), 500, false, false);

local spots = {};
area.GetHidingSpots(spots);

foreach (name, hidingSpot in spots)
{
	printl("pos " + hidingSpot.position);
	printl("id " + hidingSpot.id);
	printl("area " + hidingSpot.area);
	printl("flags " + hidingSpot.flags);
	
	if (hidingSpot.flags & HidingSpot.IN_COVER)
	{
		printl("IN_COVER");
	}
	if (hidingSpot.flags & HidingSpot.GOOD_SNIPER_SPOT)
	{
		printl("GOOD_SNIPER_SPOT");
	}
	if (hidingSpot.flags & HidingSpot.IDEAL_SNIPER_SPOT)
	{
		printl("IDEAL_SNIPER_SPOT");
	}
	if (hidingSpot.flags & HidingSpot.EXPOSED)
	{
		printl("EXPOSED");
	}
}
