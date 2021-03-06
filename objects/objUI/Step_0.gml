// Increment frame counter

frame_counter += 1;

switch(state)
{
	case ui_states.title:
	
		if (frame_counter == 1)
		{
			objControls.has_control = true;
		}
	
	break;
	
	case ui_states.menu:
	
	break;
	
	case ui_states.game:
	
		if (!game_over && frame_counter == 1)
		{
			objControls.has_control = true;
		}
	
	break;
	
	case ui_states.fade_in:
	
		if (frame_counter == 1)
		{
			objControls.has_control = false;
			objControls.input_x = 0;
			objControls.input_y = 0;
			objControls.action = input.none;
			objControls.buffer = false;
			objControls.buffer_counter = 0;
			
			if (objPlayer.transition_room == roomEnd)
			{
				game_over = true;
			}
		}

	break;
	
	case ui_states.fade_out:

		if (frame_counter == 1)
		{
			with (objPlayer)
			{
				scrChangeRoom(transition_room, transition_x, transition_y);
			}
		}
	
	break;
}