local items = {};
GetPlayerByIndex(1).GetCarriedItems(uh);
foreach (name, value in items)
{
	printl(name + " " + value);
}
