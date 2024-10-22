local items = {};
GetPlayerByIndex(1).GetCarriedItems(items);
foreach (name, value in items)
{
	printl(name + " " + value);
}
