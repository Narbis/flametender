if (open)
{
	if (ystart - y < 32)
	{
		y--;
	}
}
else if (place_meeting(x + 4, y, objPlayer) || place_meeting(x - 4, y, objPlayer))
{
	if (objPlayer.key && objControls.action == input.activate)
	{
		open = true;
		sprite_index = sprBarrier;
		scrPlaySound(sndSelect, x, y);
		objPlayer.key = false;
		objPlayer.puzzles[puzzle_num] = true;
	}
}
