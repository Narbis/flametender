if (objControls.action == input.activate && objPlayer.state == player_states.idle)
{
	objUI.state = ui_states.fade_in;
	objUI.frame_counter = 0;
	objUI.transition_room = linked_room;
	objUI.transition_x = linked_room_x;
	objUI.transition_y = linked_room_y;
	objControls.action = input.none;
}