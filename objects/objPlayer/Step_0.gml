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
		
		// Reset image index and break if necessary
		
		if (state != player_states.idle)
		{
			image_index = 0;
			break;
		}
		
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
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: WALK
	//
	// The character is moving horizontally on the ground at a slow pace
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.walk:
		
		// Change player to appropriate state

		if (!place_meeting(x, y + 1, objWall))
		{
			state = player_states.fall;
			jump_buffer = 5;
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
		
		// Reset image index and break if necessary
		
		if (state != player_states.walk)
		{
			image_index = 0;
			break;
		}
		
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
		
		if (floor(image_index) == 0)
		{
			if (reset_run_animation == true)
			{
				reset_run_animation = false;
				state = player_states.run;
			}
		}
		else
		{
			reset_run_animation = true;
		}
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: RUN
	//
	// The character is moving horizontally on the ground at a fast pace
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.run:
		
		// Change player to appropriate state
		
		if (!place_meeting(x, y + 1, objWall))
		{
			state = player_states.fall;
			jump_buffer = 5;
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
		else if (controls.input_x != 0)
		{
			if (abs(controls.input_x) <= run_threshold)
			{				
				state = player_states.walk;
			}
			else if (sign(controls.input_x) == -sign(h_speed))
			{
				state = player_states.dash;
			}
		}
		else
		{
			state = player_states.stop;
		}
		
		// Reset image index and break if necessary
		
		if (state != player_states.run && state != player_states.dash)
		{
			image_index = 0;
			reset_run_animation = false;
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
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: STOP
	//
	// The character is transitioning into the idle state
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.stop:
		
		// Change player to appropriate state
		
		if (controls.action = input.attack)
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
		else if (controls.input_x != 0  && !place_meeting(x + sign(controls.input_x), y, objWall))
		{
			if (abs(controls.input_x) <= run_threshold)
			{				
				state = player_states.walk;
			}
			else
			{
				state = player_states.dash;
			}
		}
		else
		{
			state = player_states.stop;
		}
		
		// Reset image index and break if necessary
		
		if (state != player_states.stop)
		{
			image_index = 0;
			break;
		}
		
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
		
		// If animation finishes, enter idle state
		
		if (image_index > image_number - 1)
		{
			state = player_states.idle;
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
	
		// Change player to appropriate state
		
		if (controls.action == input.dash)
		{
			//state = player_states.flamedash;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (jump_buffer > 0 && controls.action == input.jump)
		{
			state = player_states.jump;
		}
		else if (v_speed >= 0 && place_meeting(x, y + 1, objWall))
		{
			if (controls.input_x == 0)
			{
				state = player_states.land;
			}
			else
			{
				state = player_states.run;
			}
		}
		else
		{
			state = player_states.fall;
		}
		
		// Reset image index and break if necessary
		
		if (state != player_states.fall)
		{
			image_index = 0;
			jump_buffer = 0;
			break;
		}
	
		// Decrement jump buffer
		
		jump_buffer -= 1;
		
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
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: LAND
	//
	// The character is transitioning out of the fall state on the ground
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.land:
	
		// Change player to appropriate state
		
		if (controls.action = input.attack)
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
		else if (controls.input_x != 0)
		{
			if (abs(controls.input_x) <= run_threshold)
			{				
				state = player_states.walk;
			}
			else
			{
				state = player_states.dash;
			}
		}
		else
		{
			state = player_states.land;
		}
		
		// Reset image index and break if necessary
		
		if (state != player_states.land)
		{
			image_index = 0;
			break;
		}
		
		// Calculate movement
		
		h_speed = 0;
		v_speed = 0;
		
		// Animations
		
		sprite_index = sprPlayerLand;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// If animation finishes, enter idle state
		
		if (image_index > image_number - 1)
		{
			state = player_states.idle;
		}
		
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