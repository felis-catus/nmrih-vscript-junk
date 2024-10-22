function NPC_TranslateActivity()
{
	printl("ACT: " + activity + " " + activity_id);
	
	return "ACT_RUN";
}

function NPC_TranslateSchedule()
{
	printl("SCHED: " + schedule + " " + schedule_id);
	
	return "SCHED_IDLE_STAND";
}
