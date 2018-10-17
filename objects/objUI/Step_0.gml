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
	
		if (frame_counter == 1)
		{
			objControls.has_control = true;
		}
	
	break;
	
	case ui_states.fade_in:
	
		if (frame_counter == 1)
		{
			objControls.has_control = false;
		}

	break;
	
	case ui_states.fade_out:

		if (frame_counter == 1)
		{
			scrChangeRoom(transition_room, transition_x, transition_y);
		}
	
	break;
}