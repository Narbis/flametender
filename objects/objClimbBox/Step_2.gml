var ledge_id = instance_place(x, y, objLedge);
if (ledge_id != noone && objPlayer.state == player_states.fall)
{
	// Check if player is facing towards the ledge and in correct vertical speed range
	
	if ((objPlayer.v_speed > -0.1 && objPlayer.v_speed < 6) && ((objPlayer.face_right && ledge_id.object_index == objLedgeLeft) || (!objPlayer.face_right && ledge_id.object_index == objLedgeRight)))
	{
		objPlayer.state = player_states.hang;
		objPlayer.reset_animation = true;
		objPlayer.frame_counter = 0;

		objPlayer.ledge = ledge_id;
	}
}