if (objControls.action == input.activate)
{
	if (objPlayer.puzzles[puzzle_num])
	{
		objUI.state = ui_states.fade_in;
		objUI.frame_counter = 0;
		objUI.transition_room = linked_room;
		objUI.transition_x = linked_room_x;
		objUI.transition_y = linked_room_y;
	}
	else
	{
		if (objPlayer.key)
		{
			objPlayer.puzzles[puzzle_num] = true;
			scrPlaySound(sndSelect, x, y);
		}
	}
	objControls.action = input.none;
	objControls.buffer = false;
	objControls.buffer_counter = 0;
}