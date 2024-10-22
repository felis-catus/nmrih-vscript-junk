foreach (name, value in getroottable())
{
	if (typeof(value) == "instance")
	{
		printl(name + " " + value);
	}
}
