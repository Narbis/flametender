if (open)
{
	if (ystart - y < 32)
	{
		y--;
	}
}
else if (torch1 != noone)
{
	if (torch2 != noone)
	{
		if (torch3 != noone)
		{
			if (torch1.lit && (torch2.lit && torch3.lit))
			{
				open = true;
				objPlayer.puzzles[puzzle_num] = true;
			}
		}
		else
		{
			if (torch1.lit && torch2.lit)
			{
				open = true;
				objPlayer.puzzles[puzzle_num] = true;
			}
		}
	}
	else
	{
		if (torch1.lit)
		{
			open = true;
			objPlayer.puzzles[puzzle_num] = true;
		}
	}
}
else
{
	open = true;
	objPlayer.puzzles[puzzle_num] = true;
}