function AdminCheat(cmd, arg1)
{
	cmd.client.SetHealth(arg1.tointeger());
}

Convars.RegisterAdminCommand("admin_cheat", AdminCheat, "give urselve healthm", FCVAR_GAMEDLL);
