// Increment frame counter

frame_counter += 1;

switch (state)
{
	
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: IDLE
	//
	// The spearman is standing still
	//-----------------------------------------------------------------------------------------------------------------
	#region 
	case spearman_states.idle:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = 0;
		
		// Animations
		
		sprite_index = sprSpearmanIdle;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// After 3 seconds, change to patrol state
		
		if (frame_counter >= 180)
		{
			state = spearman_states.patrol;
			if (irandom_range(0, 1) == 0 )
			{
				face_right = true;
			}
			else
			{
				face_right = false;
			}
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != spearman_states.idle)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: PATROL
	//
	// The spearman is moving horizontally on the ground at a slow pace
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case spearman_states.patrol:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		if (face_right)
		{
			h_speed = move_speed / 2;
		}
		else
		{
			h_speed = -move_speed / 2;
		}
		
		// Horizontal collisions

		if (place_meeting(x + h_speed, y, objWall))
		{
			var h_move = 0;
			while (!place_meeting(x + h_move + sign(h_speed), y, objWall))
			{
				h_move += sign(h_speed);
			}
			h_speed = h_move;
		}
		x = x + h_speed;
		
		// Animations
		
		sprite_index = sprSpearmanWalk;
			
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// After 3 seconds, change to idle state
		
		if (frame_counter >= 180 || (place_meeting(x + h_speed, y, objWall) || place_meeting(x, y + 1, objLedge)))
		{
			state = spearman_states.idle;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != spearman_states.patrol)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
}