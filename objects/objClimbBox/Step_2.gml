var ledge_id = instance_place(x, y, objLedge);
if (ledge_id != noone && (objPlayer.state != player_states.climb && objPlayer.state != player_states.flamedash))
{
	// Check if player is facing towards the ledge
	
	if ((objPlayer.face_right && ledge_id.object_index == objLedgeLeft) || (!objPlayer.face_right && ledge_id.object_index == objLedgeRight))
	{
		objPlayer.state = player_states.climb;
		objPlayer.reset_animation = true;
		objPlayer.frame_counter = 0;

		objPlayer.ledge = ledge_id;
	}
}