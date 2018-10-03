if (place_meeting(x, y, objPlayer) && objControls.input_y < -0.5)
{
	room_goto(target_room);
	objPlayer.x = target_room_x;
	objPlayer.y = target_room_y;
}