if (objControls.action == input.activate)
{
	other.transition_room = linked_room;
	other.transition_x = linked_room_x;
	other.transition_y = linked_room_y;
	
	objUI.frame_counter = 0;
	objUI.state = ui_states.fade_in;
	
	objControls.action = input.none;
	objControls.buffer = false;
	objControls.buffer_counter = 0;
}