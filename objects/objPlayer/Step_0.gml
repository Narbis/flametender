//-----------------------------------------------------------------------------------------------------------------
// PLAYER OBJECT STATE MACHINE
//
// Action performed by player depends on the current state; each state handles user input, character movement,
// sounds, and sprites/animations for that state
//-----------------------------------------------------------------------------------------------------------------

// Increment frame counter

frame_counter += 1;

switch (state)
{
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: IDLE
	//
	// The character is standing still
	//-----------------------------------------------------------------------------------------------------------------
	#region 
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
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.idle)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: WALK
	//
	// The character is moving horizontally on the ground at a slow pace
	//-----------------------------------------------------------------------------------------------------------------
	#region
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
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.walk)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DASH
	//
	// The character is transitioning into the run state; this is a special case of the run state
	//-----------------------------------------------------------------------------------------------------------------	
	#region
	case player_states.dash:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations and particles
		
		sprite_index = sprPlayerDash;
		
		if (frame_counter % 18 == 1)
		{
			if (controls.input_x > 0)
			{
				part_particles_create(global.particle_system, x, y, global.run_right_dust_particle, 1);
			}
			else if (controls.input_x < 0)
			{
				part_particles_create(global.particle_system, x, y, global.run_left_dust_particle, 1);
			}
		}
		
		// If animation finishes, enter run state
		
		if (floor(image_index) == 0)
		{
			if (finish_animation == true)
			{
				reset_animation = true;
				finish_animation = false;
			}
		}
		else
		{
			finish_animation = true;
		}
		
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: RUN
	//
	// The character is moving horizontally on the ground at a fast pace
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case player_states.run:
		
		// Reset animation and frame counter
		
		if (reset_animation == true && state == player_states.dash)
		{
			image_index = 0;
			reset_animation = false;
			state = player_states.run;
			frame_counter = 1;
		}
		
		// Calculate movement
		
		var target_speed = sign(controls.input_x) * move_speed;
		if (h_speed < target_speed)
		{
			h_speed = min(target_speed, h_speed + (move_speed / 8));
		}
		else
		{
			h_speed = max(target_speed, h_speed - (move_speed / 8));
		}
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
		
		// Animations and particles
		
		if (state != player_states.dash)
		{
			sprite_index = sprPlayerRun;
			
			if (frame_counter % 18 == 13)
			{
				if (face_right)
				{
					part_particles_create(global.particle_system, x, y, global.run_right_dust_particle, 1);
				}
				else
				{
					part_particles_create(global.particle_system, x, y, global.run_left_dust_particle, 1);
				}
			}
		}
		
		// Speed of animation corresponds to current run speed
		image_speed = abs(h_speed / move_speed);
		
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
		else if (h_speed != 0)
		{
			if (abs(controls.input_x) <= run_threshold && controls.input_x != 0)
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
		
		// Reset animation and frame counter if necessary
		
		if ((state != player_states.run && state != player_states.dash))
		{
			reset_animation = true;
			finish_animation = false;
			walk_transition_counter = 0;
			frame_counter = 0;
			image_speed = 1;
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: STOP
	//
	// The character is transitioning into the idle state
	//-----------------------------------------------------------------------------------------------------------------	
	#region
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
		
		// Animations and particles
		
		sprite_index = sprPlayerStop;
		
		if (frame_counter == 5)
		{
			if (face_right)
			{
				part_particles_create(global.particle_system, x, y, global.stop_right_dust_particle, 1);
			}
			else
			{
				part_particles_create(global.particle_system, x, y, global.stop_left_dust_particle, 1);
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
		
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.stop)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion

	//-----------------------------------------------------------------------------------------------------------------
	// STATE: JUMP
	//
	// The character is transitioning into a fall after gaining some initial vertical speed
	//-----------------------------------------------------------------------------------------------------------------	
	#region
	case player_states.jump:
	
		// Add initial vertical speed
		
		v_speed = -jump_speed;
		
		// Play sounds
		
		scrPlaySound(sndJump, x, y);
		
		// Enter fall state
		
		state = player_states.fall;
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: FALL
	//
	// The character is moving vertically and potentially horizontally and not touching the ground
	//-----------------------------------------------------------------------------------------------------------------	
	#region
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
		
		var target_speed = sign(controls.input_x) * max(move_speed, abs(h_speed));
		if (h_speed < target_speed)
		{
			h_speed = min(target_speed, h_speed + (move_speed / 16));
		}
		else
		{
			h_speed = max(target_speed, h_speed - (move_speed / 16));
		}
		
		v_speed = v_speed + v_gravity;
		if (v_speed >= 0 && controls.input_y > fast_fall_threshold)
		{
			v_speed = v_speed + v_gravity;
		}
		if (v_speed > 10)
		{
			v_speed = 10;
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
		if (v_move == 0) // Makes sure the animation doesn't suddenly change before landing
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
			else if (v_speed < 10)
			{
				sprite_index = sprPlayerFallDown3;
				fall = fall_states.heavy;
			}
			else
			{
				sprite_index = sprPlayerFallDown3;
				fall = fall_states.danger;
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
		if (controls.action == input.attack)
		{
			state = player_states.aerialattack;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.jump && jump_buffer > 0)
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.jump && ((position_meeting(x + 6, y + 15, objWall) && position_meeting(x + 6, y - 7, objWall)) || (position_meeting(x - 6, y + 15, objWall) && position_meeting(x - 6, y - 7, objWall))))
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
			
			// Add horizontal speed from jumping
			if (position_meeting(x - 6, y, objWall))
			{
				h_speed = move_speed;
			}
			else
			{
				h_speed = -move_speed;
			}
		}
		else if (v_speed >= 0 && place_meeting(x, y + 1, objWall))
		{
			if (fall == fall_states.light)
			{
				state = player_states.lightland;
			}
			else
			{
				state = player_states.heavyland;
			}
		}
		else if (v_speed >= 0 && ((position_meeting(x + 5, y + 15, objWall) && position_meeting(x + 5, y - 7, objWall)) || (position_meeting(x - 5, y + 15, objWall) && position_meeting(x - 5, y - 7, objWall))))
		{
			state = player_states.slide;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.fall)
		{
			reset_animation = true;
			jump_buffer = 0;
			frame_counter = 0;
			fall = fall_states.light;
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: LIGHTLAND
	//
	// The character is transitioning out of the fall state on the ground with a short landing animation
	//-----------------------------------------------------------------------------------------------------------------	
	#region
	case player_states.lightland:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		if (!(frame_counter == 1 && controls.action == input.jump))
		{
			// If jump is input on frame 1 allow bunny-hopping (by not reducing h_speed)
			h_speed = h_speed - (h_speed / 8);
		}
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
		
		// Animations and particles
		
		sprite_index = sprPlayerLightLand;
		
		if (frame_counter == 1)
		{
			part_particles_create(global.particle_system, x, y, global.lightland_dust_particle, 1);
		}
		else if (abs(h_speed) > 0.3 && frame_counter % 3 == 1)
		{
			part_particles_create(global.particle_system, x, y, global.land_slide_dust_particle, 1);
		}
		
		// Sounds
		
		if (frame_counter == 1)
		{
			scrPlaySound(sndJumpLand, x, y);
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
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.lightland)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HEAVYLAND
	//
	// The character is transitioning out of the fall state on the ground with a long landing animation
	//-----------------------------------------------------------------------------------------------------------------	
	#region
	case player_states.heavyland:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = h_speed - (h_speed / 8);
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
		
		// Animations and particles
		
		sprite_index = sprPlayerHeavyLand;
		
		if (frame_counter == 1)
		{
			part_particles_create(global.particle_system, x, y, global.heavyland_dust_particle, 1);
		}
		else if (abs(h_speed) > 0.3 && frame_counter % 3 == 1)
		{
			part_particles_create(global.particle_system, x, y, global.land_slide_dust_particle, 1);
		}
		
		// Sounds
		
		if (frame_counter == 1)
		{
			scrPlaySound(sndJumpLand, x, y);
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
		
		// Change to fall state if sliding off of a ledge
		
		if (!place_meeting(x, y + 1, objWall))
		{
			state = player_states.fall;
		}
		
		// When animation finishes, enter idle state and reset frame counter
		
		if (image_index > image_number - 1)
		{
			state = player_states.idle;
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HANG
	//
	// The character is hanging from a ledge
	//-----------------------------------------------------------------------------------------------------------------	
	#region
	case player_states.hang:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = 0;
		v_speed = 0;
		
		// Animations and positioning
		
		sprite_index = sprPlayerHang;
		
		if (image_index > image_number - 1)
		{
			image_speed = 0;
		}
		
		if (frame_counter == 1)
		{
			x = ledge.x;
			y = ledge.y;
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
			if (face_right)
			{
				x = x - 5;
				y = y + 3;
			}
			else
			{
				x = x + 5;
				y = y + 3;
			}
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		else if (controls.action == input.jump)
		{
			state = player_states.jump;
			if (face_right)
			{
				x = x - 5;
				y = y + 3;
			}
			else
			{
				x = x + 5;
				y = y + 3;
			}
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
			
			// Add horizontal speed from jumping
			if (face_right)
			{
				h_speed = -move_speed;
			}
			else
			{
				h_speed = move_speed;
			}
			face_right = !face_right;
		}
		else if (controls.input_y > 0.5)
		{
			// You need to hold down for 10 frames to slide down
			hang_slide_transition_counter += 1;
			if (hang_slide_transition_counter == hang_slide_transition_frames)
			{
				state = player_states.slide;
				if (face_right)
				{
					x = x - 5;
					y = y + 7;
				}
				else
				{
					x = x + 5;
					y = y + 7;
				}
				face_right = !face_right;
			}
			hang_climb_transition_counter = 0;
		}
		else if (((controls.input_x > 0.5 && face_right) || (controls.input_x < -0.5 && !face_right)) || controls.input_y < 0)
		{
			// You need to hold up or towards the wall for 10 frames to climb up
			hang_climb_transition_counter += 1;
			if (hang_climb_transition_counter == hang_climb_transition_frames)
			{
				state = player_states.climb;
			}
			hang_slide_transition_counter = 0;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.hang)
		{
			reset_animation = true;
			frame_counter = 0;
			image_speed = 1;
			hang_slide_transition_counter = 0;
			hang_climb_transition_counter = 0;
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: CLIMB
	//
	// The character is transitioning from hanging to standing
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case player_states.climb:
	
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
		
		sprite_index = sprPlayerClimb;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// When animation finishes, enter idle state and reset frame counter
		
		if (image_index > image_number - 1)
		{
			state = player_states.idle;
			reset_animation = true;
			frame_counter = 0;
			
			sprite_index = sprPlayerIdle;
			
			y = y - 16;
			if (face_right)
			{
				x = x + 5;
			}
			else
			{
				x = x - 5;
			}
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: SLIDE
	//
	// The character is slowly sliding down a vertical surface
	//-----------------------------------------------------------------------------------------------------------------	
	#region
	case player_states.slide:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Set facing on frame 1
		
		if (frame_counter == 1)
		{
			if (place_meeting(x - 1, y, objWall))
			{
				face_right = true;
			}
			else
			{
				face_right = false;
			}
		}
		
		// Calculate movement
		
		h_speed = 0;
		
		var target_speed = 1.5;
		if (controls.input_y > fast_fall_threshold)
		{
			target_speed = 3;
		}
		
		if (v_speed < target_speed)
		{
			v_speed = min(target_speed, v_speed + (1.5 / 8));
		}
		else
		{
			v_speed = max(target_speed, v_speed - (1.5 / 8));
		}
		
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
		
		// Animations and particles
		
		sprite_index = sprPlayerSlide;
		
		if (frame_counter % 5 == 1)
		{
			if (face_right)
			{
				part_particles_create(global.particle_system, x, y, global.slide_right_dust_particle, 1);
			}
			else
			{
				part_particles_create(global.particle_system, x, y, global.slide_left_dust_particle, 1);
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

		if (place_meeting(x, y + 1, objWall))
		{
			state = player_states.lightland;
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
			
			// Add horizontal speed from jumping
			if (face_right)
			{
				h_speed = move_speed;
			}
			else
			{
				h_speed = -move_speed;
			}
		}
		else if ((face_right && (!position_meeting(x - 5, y + 15, objWall) || !position_meeting(x - 5, y - 7, objWall))) || (!face_right && (!position_meeting(x + 5, y + 15, objWall) || !position_meeting(x + 5, y - 7, objWall))))
		{
			state = player_states.fall;
		}
		else if ((face_right && controls.input_x > 0) || (!face_right && controls.input_x < 0))
		{
			// You need to hold away from the wall for 10 frames to let go
			slide_fall_transition_counter += 1;
			if (slide_fall_transition_counter == slide_fall_transition_frames)
			{
				if (face_right)
				{
					h_speed = 0.5;
				}
				else
				{
					h_speed = -0.5;
				}
				state = player_states.fall;
			}
		}
		else
		{
			slide_fall_transition_counter = 0;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.slide)
		{
			reset_animation = true;
			frame_counter = 0;
			slide_fall_transition_counter = 0;
		}
		
		break;
	#endregion
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ATTACK
	//
	// The character is performing a forward-facing fire attack on the ground
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case player_states.attack:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Facing and animations are set on frame 1
		
		if (frame_counter == 1)
		{

			// Deduct 1 flame and reset regeneration counter
			if (!controls.debug)
			{
				flame -= 1;
				flame_regen_counter = 0;
			}
			
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
		
		if (frame_counter == 7)
		{
			if (face_right)
			{
				// Create fireball instance
				var fireball = instance_create_layer(x + 7, y + 3, "Player", objFireball);
			}
			else
			{
				// Create fireball instance
				var fireball = instance_create_layer(x - 7, y + 3, "Player", objFireball);
			}
			
			// Play sound
			scrPlaySound(sndFireballAttack, x, y);
			
			attacks++;
		}
		
		// When state finishes, enter idle state and reset frame counter
		
		if (frame_counter >= attack_frames)
		{
			state = player_states.idle;
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: AERIAL ATTACK
	//
	// The character is performing a forward-facing fire attack in the air
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case player_states.aerialattack:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		var target_speed = sign(controls.input_x) * max(move_speed, abs(h_speed));
		if (h_speed < target_speed)
		{
			h_speed = min(target_speed, h_speed + (move_speed / 16));
		}
		else
		{
			h_speed = max(target_speed, h_speed - (move_speed / 16));
		}
		
		v_speed = v_speed + v_gravity;
		if (v_speed > 10)
		{
			v_speed = 10;
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
		
		// Facing and animations are set on frame 1
		
		if (frame_counter == 1)
		{

			// Deduct 1 flame and reset regeneration counter
			if (!controls.debug)
			{
				flame -= 1;
				flame_regen_counter = 0;
			}
			
			if (controls.input_x > 0 || (controls.input_x == 0 && face_right == true))
			{
				// RIGHT
				
				// Set facing
				face_right = true;
				image_xscale = 1;
				
				// Animations
				sprite_index = sprPlayerAttackAerial;
				
			}
			else
			{
				// LEFT
				
				// Set facing
				face_right = false;
				image_xscale = -1;
				
				// Animations
				sprite_index = sprPlayerAttackAerial;
				
			}
			
		}
		
		// Sounds and projectile creation are done on frame 7
		
		if (frame_counter == 7)
		{
			if (face_right)
			{
				// Create fireball instance
				var fireball = instance_create_layer(x + 14, y + 6, "Player", objFireball);
			}
			else
			{
				// Create fireball instance
				var fireball = instance_create_layer(x - 14, y + 6, "Player", objFireball);
			}
			
			// Play sound
			scrPlaySound(sndFireballAttack, x, y);
			
			attacks++;
		}
		
		// If player collides with the ground before the animation finishes, cancel it and enter the heavy land state
		
		if (v_speed >= 0 && place_meeting(x, y + 1, objWall))
		{
			state = player_states.heavyland;
			reset_animation = true;
			frame_counter = 0;
		}
		
		// If animation finishes, enter fall state and reset frame counter
		
		if (frame_counter >= aerial_attack_frames)
		{
			state = player_states.fall;
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: FLAMEDASH
	//
	// The character is dashing quickly in the input direction
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case player_states.flamedash:
	
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Direction, movement speed, animations, and facing are all determined on frame 1
		
		if (frame_counter == 1)
		{
			
			dashes++;
			
			// Deduct 1 flame and reset regeneration counter
			if (!controls.debug)
			{
				flame -= 1;
				flame_regen_counter = 0;
			}
			
			// Determine dash direction
			
			var dash_direction;
			if (controls.input_x == 0 && controls.input_y == 0)
			{
				if (face_right)
				{
					dash_direction = 0;
				}
				else
				{
					dash_direction = 180;
				}
			}
			else
			{
				dash_direction = point_direction(x, y, x + controls.input_x, y + controls.input_y);
			}
			
			if (!place_meeting(x, y + 1, objWall) || (dash_direction > 22.5 && dash_direction < 157.5))
			{
				
				// AERIAL DASH
				
				dash_grounded = false;
				
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
				
					// Set particle direction
					part_type_direction(global.dash_particle, 220, 230, 0, 0);
					
					// Create dust cloud if dashing from ground
					if (place_meeting(x, y + 1, objWall))
					{
						part_particles_create(global.particle_system, x, y, global.flamedash_dust_particle, 1);
					}
				
				}
				else if (dash_direction >= 67.5 && dash_direction <= 112.5)
				{
					// UP
				
					// Movement speed
					h_speed = 0;
					v_speed = -flamedash_speed;
				
					// Animations
					sprite_index = sprPlayerFlameDashUp;
				
					// Set particle direction
					part_type_direction(global.dash_particle, 265, 275, 0, 0);
					
					// Create dust cloud if dashing from ground
					if (place_meeting(x, y + 1, objWall))
					{
						part_particles_create(global.particle_system, x, y, global.flamedash_dust_particle, 1);
					}
				
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
				
					// Set particle direction
					part_type_direction(global.dash_particle, 310, 320, 0, 0);
					
					// Create dust cloud if dashing from ground
					if (place_meeting(x, y + 1, objWall))
					{
						part_particles_create(global.particle_system, x, y, global.flamedash_dust_particle, 1);
					}
				
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
				
					// Set particle direction
					part_type_direction(global.dash_particle, -5, 5, 0, 0);
				
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
				
					// Set particle direction
					part_type_direction(global.dash_particle, 40, 50, 0, 0);
				
				}
				else if (dash_direction >= 247.5 && dash_direction <= 292.5)
				{
					// DOWN
				
					// Movement speed
					h_speed = 0;
					v_speed = flamedash_speed;
				
					// Animations
					sprite_index = sprPlayerFallDown3;
				
					// Set particle direction
					part_type_direction(global.dash_particle, 85, 95, 0, 0);
				
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
				
					// Set particle direction
					part_type_direction(global.dash_particle, 130, 140, 0, 0);
				
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
				
					// Set particle direction
					part_type_direction(global.dash_particle, 175, 185, 0, 0);
				
				}
			}
			else
			{
				
				// GROUNDED DASH
				
				dash_grounded = true;
				
				if ((dash_direction >= 157.5 && dash_direction < 247.5) || (!face_right && (dash_direction >= 247.5 && dash_direction <= 292.5)))
				{
					// LEFT
				
					// Movement speed
					h_speed = -flamedash_speed;
					v_speed = 0;
				
					// Animations
					sprite_index = sprPlayerFlameDashGround;
				
					// Facing
					face_right = false;
				
					// Set particle direction
					part_type_direction(global.dash_particle, -5, 5, 0, 0);
				
				}
				else
				{
					// RIGHT
				
					// Movement speed
					h_speed = flamedash_speed;
					v_speed = 0;
				
					// Animations
					sprite_index = sprPlayerFlameDashGround;
				
					// Facing
					face_right = true;
				
					// Set particle direction
					part_type_direction(global.dash_particle, 175, 185, 0, 0);
				
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
			
			// Play sound
			
			audio_sound_pitch(sndFlameDash, random_range(0.95, 1.05));
			scrPlaySound(sndFlameDash, x, y);
			
			// EXPERIMENTAL: Shockwave effect
			if (dash_grounded)
			{
				part_particles_create(global.particle_system, x, y + 7, global.shockwave_particle, 1);
			}
			else
			{
				part_particles_create(global.particle_system, x, y, global.shockwave_particle, 1);
			}
		}
		
		// EXPERIMENTAL: Particle effect
			
		if (dash_grounded)
		{
			part_emitter_region(global.particle_system, flamedash_emitter, x - 2, x + 2, y + 5, y + 9, ps_shape_rectangle, ps_distr_linear);
			part_emitter_burst(global.particle_system, flamedash_emitter, global.dash_particle, 5);
			part_particles_create(global.particle_system, x, y + 7, global.ember_particle, 1);
			if (frame_counter % 3 == 1)
			{
				if (face_right)
				{
					part_particles_create(global.particle_system, x, y, global.trail_right_dust_particle, 1);
				}
				else
				{
					part_particles_create(global.particle_system, x, y, global.trail_left_dust_particle, 1);
				}
			}
		}
		else
		{
			part_emitter_region(global.particle_system, flamedash_emitter, x - 2, x + 2, y - 2, y + 2, ps_shape_rectangle, ps_distr_linear);
			part_emitter_burst(global.particle_system, flamedash_emitter, global.dash_particle, 5);
			part_particles_create(global.particle_system, x, y, global.ember_particle, 1);
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
			
			// Enter slide or stop state after colliding with a wall
			if (dash_grounded)
			{
				state = player_states.stop;
			}
			else
			{
				state = player_states.slide;
			}
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
			
			// Enter heavy-land state if dashing into ground, otherwise cancel the dash if ceiling collision
			if (v_speed > 0 || place_meeting(x, y + 1, objWall))
			{
				state = player_states.heavyland;
			}
			else
			{
				state = player_states.fall;
			}
		}
		y = y + v_speed;
		
		// Grounded flamedash can be jumped out of
		
		if (dash_grounded && controls.action == input.jump)
		{
			state = player_states.jump;
			controls.action = input.none;
			controls.buffer = false;
			controls.buffer_counter = 0;
		}
		
		// If grounded flamedash moves player off a ledge, cancel it
		
		if (dash_grounded && !place_meeting(x, y + 1, objWall))
		{
			state = player_states.fall;
		}
		
		// When state finishes, enter fall or dash state
		
		if (frame_counter >= flamedash_frames)
		{
			if (dash_grounded)
			{
				state = player_states.dash;
			}
			else
			{
				state = player_states.fall;
			}
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.flamedash)
		{
			reset_animation = true;
			frame_counter = 0;
			slide_fall_transition_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HURT
	//
	// The character is in a stunned state after being hit
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case player_states.hurt:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		v_speed = v_speed + v_gravity;

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
		
		sprite_index = sprPlayerHurt;
		
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
		
		if (!invuln || (frame_counter >= hurt_frames && flame > 0))
		{
			state = player_states.fall;
		}
		
		if (place_meeting(x, y + 1, objWall))
		{
			if (flame > 0)
			{
				state = player_states.lightland;
			}
			else
			{
				state = player_states.dead;
			}
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.hurt)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The character is out of life and falls to the ground
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case player_states.dead:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Facing and animations are set on frame 1
		
		if (frame_counter == 1)
		{

			if (face_right == true)
			{
				// RIGHT
				
				// Movement speed
				h_speed = 0;
				v_speed = 0;
				
				// Set facing
				image_xscale = 1;
				
				// Animations
				sprite_index = sprPlayerDeath;
				
			}
			else
			{
				// LEFT
				
				// Movement speed
				h_speed = 0;
				v_speed = 0;
				
				// Set facing
				image_xscale = -1;
				
				// Animations
				sprite_index = sprPlayerDeath;
				
			}
			
			invuln = false;
			invuln_counter = 0;
		}
		
		// When state finishes, restart room
		
		if (frame_counter == dead_frames)
		{
			deaths++;
			flame = flame_max;
			image_speed = 0;
			
			objUI.transition_room = roomStart;
			objUI.transition_x = 48;
			objUI.transition_y = 176;
			objUI.state = ui_states.fade_in;
			objUI.frame_counter = 0;
			objControls.action = input.none;
		}
		
		break;
	#endregion
}

// INVULNERABILITY
#region

if (invuln)
{
	invuln_counter += 1;
	
	if (invuln_counter == invuln_frames && flame > 0)
	{
		invuln_counter = 0;
		invuln = !invuln;
	}
}

#endregion

// FLAME REGENERATION
#region

if (flame < flame_max)
{
	if (state == player_states.idle || state == player_states.walk)
	{
		flame_regen_counter += 3;
	}
	else if (state == player_states.dash || state == player_states.run)
	{
		flame_regen_counter += 2;
	}
	else
	{
		flame_regen_counter += 1;
	}
	
	if (flame_regen_counter >= flame_regen_frames)
	{
		flame += 1;
		flame_regen_counter -= flame_regen_frames;
		
		if (flame == flame_max)
		{
			flame_regen_counter = 0;
		}
	}
}

#endregion

// CHECK FOR OUT OF BOUNDS
#region

if (((x < -32 || x > room_width + 32) || (y < -32 || y > room_height + 32)))
{
	objUI.state = ui_states.fade_in;
	objUI.frame_counter = 0;
	objControls.action = input.none;
	
	if (!invuln)
	{
		state = player_states.hurt;
		reset_animation = true;
		frame_counter = 0;
		image_speed = 1;
		invuln = true;
		if (!controls.debug)
		{
			// get hurt?
		}
	}
}

#endregion

// DEBUGGING STUFF
#region
if (mouse_check_button(mb_left))
{
	
}
#endregion