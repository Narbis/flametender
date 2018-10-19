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
			if (place_meeting(x + 1, y, objWall))
			{
				face_right = false;
			}
			else if (place_meeting(x - 1, y, objWall))
			{
				face_right = true;
			} 
			else if (irandom_range(0, 1) == 0 )
			{
				face_right = true;
			}
			else
			{
				face_right = false;
			}
			
			state = spearman_states.patrol;
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
		
		// Flip directions when encountering a wall or ledge
		
		if (place_meeting(x + 1, y, objWall) || place_meeting(x, y + 1, objLedge))
		{
			face_right = !face_right;
		}
		
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
		
		if (frame_counter >= 180)
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
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ALERTED
	//
	// The spearman is transitioning into the pursuit state
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case spearman_states.alerted:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprSpearmanAlerted;
			
		// Set facing of sprite based on where the player is located
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// When animation finishes, enter pursuit state
		
		if (frame_counter >= 36)
		{
			state = spearman_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != spearman_states.alerted)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: PURSUIT
	//
	// The spearman is moving towards the player
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case spearman_states.pursuit:
		
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
		
		// Flip directions when encountering a wall or ledge
		
		if (place_meeting(x + 1, y, objWall) || place_meeting(x, y + 1, objLedge))
		{
			face_right = !face_right;
		}
		
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
		
		if (frame_counter >= 180)
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
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ATTACK
	//
	// The spearman is attacking the player
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case spearman_states.attack:
		
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
		
		// Flip directions when encountering a wall or ledge
		
		if (place_meeting(x + 1, y, objWall) || place_meeting(x, y + 1, objLedge))
		{
			face_right = !face_right;
		}
		
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
		
		if (frame_counter >= 180)
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