function SayHook(cmd, arg1)
{
	printl(arg1);
	
	// call parent
	return true;
}

Convars.RegisterCommand("say", SayHook, "", FCVAR_GAMEDLL);
