//-----------------------------------------------------------------------------------------------------------------
// PLAYER OBJECT STATE MACHINE
//
// Action performed by player depends on the current state; each state handles user input, character movement,
// sounds, and sprites/animations for that state
//-----------------------------------------------------------------------------------------------------------------

switch (state)
{
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: IDLE
	//
	// The character is standing still
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.idle:
		
		// Calculate movement
		
		h_speed = 0;
		v_speed = 0;
		
		// Animations
		
		sprite_index = sprPlayerIdle;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Change player to appropriate state
		
		if (controls.action == input.attack)
		{
			//state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.dash)
		{
			//state = player_states.flamedash;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.jump)
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.input_x != 0 && !place_meeting(x + sign(controls.input_x), y, objWall))
		{
			if (abs(controls.input_x) > 0.4)
			{
				state = player_states.dash;
			}
			else
			{
				state = player_states.walk;
			}
		}
		else
		{
			state = player_states.idle;
		}
		
		// Reset image index if necessary
		
		if (state != player_states.idle)
		{
			image_index = 0;
		}
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: WALK
	//
	// The character is moving horizontally on the ground at a slow pace
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.walk:
		
		// Calculate movement
		
		h_speed = sign(controls.input_x) * move_speed / 2;
		v_speed = 0;
		
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
		
		sprite_index = sprPlayerWalk;
			
		// Moving left and right flips the sprite to face the appropriate direction
		
		if (h_speed != 0)
		{
			if (h_speed > 0)
			{
				face_right = true;
			}
			else
			{
				face_right = false;
			}
		}
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Change player to appropriate state

		if (!place_meeting(x, y + 1, objWall))
		{
			state = player_states.fall;
		}
		else if (controls.action == input.attack)
		{
			//state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.dash)
		{
			//state = player_states.flamedash;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.jump)
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.input_x != 0 && !place_meeting(x + sign(controls.input_x), y, objWall))
		{
			if (abs(controls.input_x) > run_threshold)
			{
				state = player_states.dash;
			}
			else
			{
				state = player_states.walk;
			}
		}
		else
		{
			state = player_states.idle;
		}
		
		// Reset image index if necessary
		
		if (state != player_states.walk)
		{
			image_index = 0;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DASH
	//
	// The character is transitioning into the run state; this is a special case of the run state
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.dash:
		
		// Animations
		
		sprite_index = sprPlayerDash;
		
		// If animation finishes, enter run state
		
		if (image_index > image_number - 1)
		{
			state = player_states.run;
		}
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: RUN
	//
	// The character is moving horizontally on the ground at a fast pace
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.run:
	
		// Check for run stop (this is a special state-change)
		
		if (h_speed != 0 && sign(controls.input_x) != sign(h_speed))
		{
			state = player_states.stop;
			image_index = 0;
			break;
		}	
		
		// Calculate movement
		
		h_speed = sign(controls.input_x) * move_speed;
		v_speed = 0;
		
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
		
		if (state != player_states.dash)
		{
			sprite_index = sprPlayerRun;
		}
			
		// Moving left and right flips the sprite to face the appropriate direction
		
		if (h_speed != 0)
		{
			if (h_speed > 0)
			{
				face_right = true;
			}
			else
			{
				face_right = false;
			}
		}
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Change player to appropriate state
		
		if (!place_meeting(x, y + 1, objWall))
		{
			state = player_states.fall;
		}
		else if (controls.action = input.attack)
		{
			//state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action = input.dash)
		{
			//state = player_states.flamedash;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action = input.jump)
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (h_speed != 0)
		{
			if (abs(controls.input_x) > run_threshold)
			{
				if (state != player_states.dash)
				{
					state = player_states.run;
				}
				else
				{
					state = player_states.dash;
				}
				
				walk_counter = 0;
			}
			else
			{
				walk_counter += 1;
				if (walk_counter == 5)
				{
					state = player_states.walk;
					walk_counter = 0;
				}
			}
		}
		else
		{
			state = player_states.stop;
		}
		
		// Reset image index if necessary
		
		if (state != player_states.run && state != player_states.dash)
		{
			image_index = 0;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: STOP
	//
	// The character is transitioning into the idle or turnaround state
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.stop:
		
		// Calculate movement
		
		h_speed = 0;
		v_speed = 0;
		
		// Animations
		
		sprite_index = sprPlayerStop;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Change state if action is interrupted
		
		if (controls.action == input.jump)
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (!place_meeting(x + sign(controls.input_x), y, objWall) && ((!face_right && controls.input_x < 0) || (face_right && controls.input_x > 0)))
		{
			state = player_states.run;
		}
		
		// If animation finishes, enter idle or turnaround state
		
		if (image_index > image_number - 1)
		{
			
			if ((face_right && controls.input_x < 0) || (!face_right && controls.input_x > 0))
			{
				state = player_states.turnaround;
			}
			else
			{
				state = player_states.idle;
			}
		}
		
		// Reset image index if necessary
		
		if (state != player_states.stop)
		{
			image_index = 0;
		}
		
		break;	
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: TURNAROUND
	//
	// The character is transitioning into moving in the opposite direction
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.turnaround:
	
		// Calculate movement
		
		h_speed = 0;
		v_speed = 0;
		
		// Animations
		
		sprite_index = sprPlayerTurn;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Change state if action is interrupted
		
		if (controls.action == input.jump)
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		
		// Enter run state if animation finishes
		
		if (image_index > image_number - 1)
		{
			state = player_states.run;
		}
		
		// Reset image index if necessary
		
		if (state != player_states.turnaround)
		{
			image_index = 0;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: JUMP
	//
	// The character is transitioning into a fall after gaining some initial vertical speed
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.jump:
	
		// Add initial vertical speed
		
		v_speed = -5;
		
		// Enter fall state
		
		state = player_states.fall;
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: FALL
	//
	// The character is moving vertically and potentially horizontally and not touching the ground
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.fall:
	
		// Calculate movement
		
		var target_speed = controls.input_x * move_speed;
		if (h_speed < target_speed)
		{
			h_speed = min(target_speed, h_speed + (move_speed / 8));
		}
		else
		{
			h_speed = max(target_speed, h_speed - (move_speed / 8));
		}
		
		v_speed = v_speed + v_gravity;
		if (v_speed >= 0 && controls.input_y > fast_fall_threshold)
		{
			v_speed = v_speed + v_gravity;
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
		
		// Vertical collisions
		
		if (place_meeting(x, y + v_speed, objWall))
		{
			var v_move = 0;
			while (!place_meeting(x, y + v_move + sign(v_speed), objWall))
			{
				v_move += sign(v_speed);
			}
			v_speed = v_move;
		}
		y = y + v_speed;
		
		// Animations
		
		if (v_speed < -jump_speed)
		{
			sprite_index = sprPlayerFallUp1;
		}
		else if (v_speed < -(jump_speed / 2))
		{
			sprite_index = sprPlayerFallUp2;
		}
		else if (v_speed < 0)
		{
			sprite_index = sprPlayerFallUp3;
		}
		else if (v_speed < (jump_speed / 2))
		{
			sprite_index = sprPlayerFallDown0;
		}
		else if (v_speed < jump_speed)
		{
			sprite_index = sprPlayerFallDown1;
		}
		else if (v_speed < (jump_speed * 1.5))
		{
			sprite_index = sprPlayerFallDown2;
		}
		else
		{
			sprite_index = sprPlayerFallDown3;
		}
			
		// Moving left and right flips the sprite to face the appropriate direction
		
		if (h_speed > 0)
		{
			face_right = true;
		}
		if (h_speed < 0)
		{
			face_right = false;
		}
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Change player to appropriate state
		
		if (controls.action = input.dash)
		{
			//state = player_states.flamedash;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (place_meeting(x, y + 1, objWall))
		{
			state = player_states.run;
		}
		else
		{
			state = player_states.fall;
		}
		
		// Reset image index if necessary
		
		if (state != player_states.fall)
		{
			image_index = 0;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: LAND
	//
	// The character is transitioning out of the fall state on the ground
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.land:
	
		//Do things
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: CLIMB
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.climb:
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ATTACK
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.attack:
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: FLAMEDASH
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.flamedash:
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.dead:
		break;
}