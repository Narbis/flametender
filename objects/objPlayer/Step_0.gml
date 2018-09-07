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
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
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
		
		// Change player to appropriate state
		
		if (controls.action == input.attack)
		{
			state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.dash)
		{
			state = player_states.flamedash;
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
		
		// Reset animation if necessary
		
		if (state != player_states.idle)
		{
			reset_animation = true;
		}
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: WALK
	//
	// The character is moving horizontally on the ground at a slow pace
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.walk:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
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
		
		// Change player to appropriate state

		if (!place_meeting(x, y + 1, objWall))
		{
			state = player_states.fall;
			jump_buffer = jump_buffer_frames;
		}
		else if (controls.action == input.attack)
		{
			state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.dash)
		{
			state = player_states.flamedash;
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
		}
		else
		{
			state = player_states.idle;
		}
		
		// Reset animation if necessary
		
		if (state != player_states.walk)
		{
			reset_animation = true;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DASH
	//
	// The character is transitioning into the run state; this is a special case of the run state
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.dash:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprPlayerDash;
		
		// If animation finishes, enter run state
		
		if (floor(image_index) == 0)
		{
			if (reset_animation == true)
			{
				reset_animation = false;
			}
		}
		else
		{
			reset_animation = true;
		}
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: RUN
	//
	// The character is moving horizontally on the ground at a fast pace
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.run:
		
		// Reset animation
		
		if (reset_animation == true && state == player_states.dash)
		{
			image_index = 0;
			reset_animation = false;
			state = player_states.run;
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
			jump_buffer = jump_buffer_frames;
		}
		else if (controls.action = input.attack)
		{
			state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action = input.dash)
		{
			state = player_states.flamedash;
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
				walk_transition_counter += 1;
				if (walk_transition_counter > walk_transition_frames)
				{
					state = player_states.walk;
				}
			}
			else
			{
				walk_transition_counter = 0;
			}
		}
		else
		{
			state = player_states.stop;
		}
		
		// Reset animation if necessary
		
		if (state != player_states.run && state != player_states.dash)
		{
			reset_animation = true;
			walk_transition_counter = 0;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: STOP
	//
	// The character is transitioning into the idle state
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.stop:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
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
		
		// Change player to appropriate state
		
		if (controls.action = input.attack)
		{
			state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action = input.dash)
		{
			state = player_states.flamedash;
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
		else if (image_index > image_number - 1)
		{
			state = player_states.idle;
		}	
		
		// Reset animation if necessary
		
		if (state != player_states.stop)
		{
			reset_animation = true;
		}
		
		break;	

	//-----------------------------------------------------------------------------------------------------------------
	// STATE: JUMP
	//
	// The character is transitioning into a fall after gaining some initial vertical speed
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.jump:
	
		// Add initial vertical speed
		
		v_speed = -jump_speed;
		
		// Play sounds
		
		audio_play_sound(sndJump, 5, false);
		
		// Enter fall state
		
		state = player_states.fall;
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: FALL
	//
	// The character is moving vertically and potentially horizontally and not touching the ground
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.fall:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
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
		
		var v_move = 0;
		if (place_meeting(x, y + v_speed, objWall))
		{
			while (!place_meeting(x, y + v_move + sign(v_speed), objWall))
			{
				v_move += sign(v_speed);
			}
			v_speed = v_move;
		}
		y = y + v_speed;
		
		// Animations
		if (v_move == 0)
		{
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
				fall = fall_states.light;
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
				fall = fall_states.heavy;
			}
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
		
		if (controls.action == input.dash)
		{
			state = player_states.flamedash;
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
			if (fall == fall_states.light)
			{
				if (controls.input_x != 0)
				{
					state = player_states.run;
				}
				else
				{
					state = player_states.lightland;
				}
			}
			else
			{
				state = player_states.heavyland;
			}
		}
		
		// Reset animation if necessary
		
		if (state != player_states.fall)
		{
			reset_animation = true;
			jump_buffer = 0;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: LIGHTLAND
	//
	// The character is transitioning out of the fall state on the ground with a short landing animation
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.lightland:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = 0;
		v_speed = 0;
		
		// Animations
		
		sprite_index = sprPlayerLightLand;
		
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
		
		if (controls.action = input.attack)
		{
			state = player_states.attack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action = input.dash)
		{
			state = player_states.flamedash;
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
		else if (image_index > image_number - 1)
		{
			state = player_states.idle;
		}
		
		// Reset animation if necessary
		
		if (state != player_states.lightland)
		{
			reset_animation = true;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HEAVYLAND
	//
	// The character is transitioning out of the fall state on the ground with a long landing animation
	//-----------------------------------------------------------------------------------------------------------------	
		
	case player_states.heavyland:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = 0;
		v_speed = 0;
		
		// Animations
		
		sprite_index = sprPlayerHeavyLand;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// When animation finishes, enter idle state
		
		if (image_index > image_number - 1)
		{
			state = player_states.idle;
			reset_animation = true;
		}
		
		break;
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: CLIMB
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.climb:
	
		//do things
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ATTACK
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.attack:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Facing and animations are set on frame 1
		
		if (attack_counter == 0)
		{

			if (controls.input_x > 0 || (controls.input_x == 0 && face_right == true))
			{
				// RIGHT
				
				// Movement speed
				h_speed = 0;
				v_speed = 0;
				
				// Set facing
				face_right = true;
				image_xscale = 1;
				
				// Animations
				sprite_index = sprPlayerAttack;
				
			}
			else
			{
				// LEFT
				
				// Movement speed
				h_speed = 0;
				v_speed = 0;
				
				// Set facing
				face_right = false;
				image_xscale = -1;
				
				// Animations
				sprite_index = sprPlayerAttack;
				
			}
			
		}
		
		// Sounds and projectile creation are done on frame 7
		
		if (attack_counter == 7)
		{
			if (face_right)
			{
				// Create fireball instance
				var fireball = instance_create_layer(x + 7, y + 2, "Player", objFireball);
			}
			else
			{
				// Create fireball instance
				var fireball = instance_create_layer(x - 7, y + 2, "Player", objFireball);
			}
			
			// Play sound
			audio_play_sound(sndFireballAttack, 10, false);
		}
		
		// Increment attack counter
		
		attack_counter += 1;
		
		// When state finishes, enter idle state
		
		if (attack_counter > attack_frames)
		{
			attack_counter = 0;
			state = player_states.idle;
			reset_animation = true;
		}
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: FLAMEDASH
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.flamedash:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Direction, movement speed, animations, and facing are all determined on frame 1
		
		if (flamedash_counter == 0)
		{
			
			// Determine dash direction
			
			dash_direction = point_direction(x, y, x + controls.input_x, y + controls.input_y);
			
			if (dash_direction > 22.5 && dash_direction < 67.5)
			{
				// UP-RIGHT
				
				// Movement speed
				h_speed = 0.707 * flamedash_speed;
				v_speed = 0.707 * -flamedash_speed;
				
				// Animations
				sprite_index = sprPlayerFlameDashDiagUp;
				
				// Facing
				face_right = true;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				trail.image_angle = 315;
				
			}
			else if (dash_direction >= 67.5 && dash_direction <= 112.5)
			{
				// UP
				
				// Movement speed
				h_speed = 0;
				v_speed = -flamedash_speed;
				
				// Animations
				sprite_index = sprPlayerFlameDashUp;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				
			}
			else if (dash_direction > 112.5 && dash_direction < 157.5)
			{
				// UP-LEFT
				
				// Movement speed
				h_speed = 0.707 * -flamedash_speed;
				v_speed = 0.707 * -flamedash_speed;
				
				// Animations
				sprite_index = sprPlayerFlameDashDiagUp;
				
				// Facing
				face_right = false;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				trail.image_angle = 45;
				
			}
			else if (dash_direction >= 157.5 && dash_direction <= 202.5)
			{
				// LEFT
				
				// Movement speed
				h_speed = -flamedash_speed;
				v_speed = 0;
				
				// Animations
				sprite_index = sprPlayerFlameDashSide;
				
				// Facing
				face_right = false;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				trail.image_angle = 90;
				
			}
			else if (dash_direction > 202.5 && dash_direction < 247.5)
			{
				// DOWN-LEFT
				
				// Movement speed
				h_speed = 0.707 * -flamedash_speed;
				v_speed = 0.707 * flamedash_speed;
				
				// Animations
				sprite_index = sprPlayerFlameDashDiagDown;
				
				// Facing
				face_right = false;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				trail.image_angle = 135;
				
			}
			else if (dash_direction >= 247.5 && dash_direction <= 292.5)
			{
				// DOWN
				
				// Movement speed
				h_speed = 0;
				v_speed = flamedash_speed;
				
				// Animations
				sprite_index = sprPlayerFallDown3;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				trail.image_angle = 180;
				
			}
			else if (dash_direction > 292.5 && dash_direction < 337.5)
			{
				// DOWN-RIGHT
				
				// Movement speed
				h_speed = 0.707 * flamedash_speed;
				v_speed = 0.707 * flamedash_speed;
				
				// Animations
				sprite_index = sprPlayerFlameDashDiagDown;
				
				// Facing
				face_right = true;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				trail.image_angle = 225;
				
			}
			else
			{
				// RIGHT
				
				// Movement speed
				h_speed = flamedash_speed;
				v_speed = 0;
				
				// Animations
				sprite_index = sprPlayerFlameDashSide;
				
				// Facing
				face_right = true;
				
				// Flamedash trail
				var trail = instance_create_layer(x, y, "Player", objFlameDashTrail);
				trail.image_angle = 270;
				
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
			
			// Play sound
			
			audio_play_sound(sndFlameDash, 10, false);
		}
		
		// Increment flamedash counter
		
		flamedash_counter += 1;
		
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
		
		var v_move = 0;
		if (place_meeting(x, y + v_speed, objWall))
		{
			while (!place_meeting(x, y + v_move + sign(v_speed), objWall))
			{
				v_move += sign(v_speed);
			}
			v_speed = v_move;
		}
		y = y + v_speed;
		
		// When state finishes, enter fall state
		
		if (flamedash_counter > flamedash_frames)
		{
			flamedash_counter = 0;
			state = player_states.fall;
			reset_animation = true;
		}
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HURT
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.hurt:
		
		//do things
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.dead:
		
		//do things
		
		break;
}