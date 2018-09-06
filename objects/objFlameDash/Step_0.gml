if(instance_exists(follow))
{
	x = follow.x;
	y = follow.y;
}
death_counter += 1;
if (death_counter > follow.flamedash_frames)
{
	instance_destroy();
}