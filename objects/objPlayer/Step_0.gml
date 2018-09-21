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
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.walk)
		{
			reset_animation = true;
			frame_counter = 0;
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
		
		// Animations and particles
		
		sprite_index = sprPlayerDash;
		
		if (frame_counter % 18 == 1)
		{
			if (controls.input_x > 0)
			{
				part_type_scale(global.dust_particle, 1, 1);
				part_type_sprite(global.dust_particle, sprRunDust, 1, 1, 0);
				part_type_life(global.dust_particle, 16, 16);
				part_particles_create(global.particle_system, x, y, global.dust_particle, 1);
			}
			else if (controls.input_x < 0)
			{
				part_type_scale(global.dust_particle, -1, 1);
				part_type_sprite(global.dust_particle, sprRunDust, 1, 1, 0);
				part_type_life(global.dust_particle, 16, 16);
				part_particles_create(global.particle_system, x, y, global.dust_particle, 1);
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
		
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: RUN
	//
	// The character is moving horizontally on the ground at a fast pace
	//-----------------------------------------------------------------------------------------------------------------
	
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
		
		if (sign(controls.input_x) == -sign(h_speed))
		{
			h_speed = 0;
		}
		else
		{
			h_speed = sign(controls.input_x) * move_speed;
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
		
		if (state != player_states.dash)
		{
			sprite_index = sprPlayerRun;
			
			if (frame_counter % 18 == 13)
			{
				part_particles_create(global.particle_system, x, y, global.dust_particle, 1);
			}
			
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
		else if (h_speed != 0)
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
		
		// Reset animation and frame counter if necessary
		
		if ((state != player_states.run && state != player_states.dash))
		{
			reset_animation = true;
			finish_animation = false;
			walk_transition_counter = 0;
			frame_counter = 0;
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
		
		// Animations and particles
		
		sprite_index = sprPlayerStop;
		
		if (frame_counter == 5)
		{
			if (face_right)
			{
				part_type_scale(global.dust_particle, 1, 1);
			}
			else
			{
				part_type_scale(global.dust_particle, -1, 1);
			}
			part_type_sprite(global.dust_particle, sprStopDust, 1, 1, 0);
			part_type_life(global.dust_particle, 16, 16);
			part_particles_create(global.particle_system, x, y, global.dust_particle, 1);
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
					state = player_states.dash;
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
		
		// Reset animation and frame counter if necessary
		
		if (state != player_states.fall)
		{
			reset_animation = true;
			jump_buffer = 0;
			frame_counter = 0;
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
		
		// Animations and particles
		
		sprite_index = sprPlayerLightLand;
		
		if (frame_counter == 1)
		{
			if (face_right)
			{
				part_type_scale(global.dust_particle, 1, 1);
			}
			else
			{
				part_type_scale(global.dust_particle, -1, 1);
			}
			part_type_sprite(global.dust_particle, sprLightLandDust, 1, 1, 0);
			part_type_life(global.dust_particle, 12, 12);
			part_particles_create(global.particle_system, x, y, global.dust_particle, 1);
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
		
		// Animations and particles
		
		sprite_index = sprPlayerHeavyLand;
		
		if (frame_counter == 1)
		{
			if (face_right)
			{
				part_type_scale(global.dust_particle, 1, 1);
			}
			else
			{
				part_type_scale(global.dust_particle, -1, 1);
			}
			part_type_sprite(global.dust_particle, sprHeavyLandDust, 1, 1, 0);
			part_type_life(global.dust_particle, 24, 24);
			part_particles_create(global.particle_system, x, y, global.dust_particle, 1);
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
		
		// When animation finishes, enter idle state and reset frame counter
		
		if (image_index > image_number - 1)
		{
			state = player_states.idle;
			reset_animation = true;
			frame_counter = 0;
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
		
		if (frame_counter == 1)
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
			audio_play_sound(sndFireballAttack, 10, false);
		}
		
		// When state finishes, enter idle state and reset frame counter
		
		if (frame_counter >= attack_frames)
		{
			state = player_states.idle;
			reset_animation = true;
			frame_counter = 0;
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
		
		if (frame_counter == 1)
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
				
				// Set particle direction
				part_type_direction(global.dash_particle, 220, 230, 0, 0);
				
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
			audio_play_sound(sndFlameDash, 10, false);
			
			// EXPERIMENTAL: Shockwave effect
			part_particles_create(global.particle_system, x, y, global.shockwave_particle, 1);
		}
		
		// EXPERIMENTAL: Particle effect
			
		part_emitter_region(global.particle_system, flamedash_emitter, x - 2, x + 2, y - 2, y + 2, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(global.particle_system, flamedash_emitter, global.dash_particle, 5);
		part_particles_create(global.particle_system, x, y, global.ember_particle, 1);
		
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
		
		// When state finishes, enter fall state and reset frame counter
		
		if (frame_counter >= flamedash_frames)
		{
			state = player_states.fall;
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HURT
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
	case player_states.hurt:
		
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
				
				// Set facing
				image_xscale = 1;
				
				// Animations
				sprite_index = sprPlayerHit;
				
			}
			else
			{
				// LEFT
				
				// Set facing
				image_xscale = -1;
				
				// Animations
				sprite_index = sprPlayerHit;
				
			}
			
			// Play hurt sound
			audio_play_sound(sndPlayerHurt, 10, false);
			
			// Deduct life
			life -= 1;
			
		}
		
		// When state finishes, enter dead state if out of life or enter idle state and reset frame counter
		
		if (life <= 0)
		{
			state = player_states.dead;
			reset_animation = true;
			frame_counter = 0;
		}
		else if (frame_counter >= hurt_frames)
		{
			state = player_states.idle;
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The character is...
	//-----------------------------------------------------------------------------------------------------------------
	
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
			
		}
		
		// When state finishes, show game over screen
		
		if (frame_counter >= dead_frames)
		{
			state = player_states.idle;
			reset_animation = true;
			frame_counter = 0;
			room_restart();
		}
		
		break;
}

if (mouse_check_button(mb_left))
{
	part_particles_create(global.particle_system, mouse_x, mouse_y, global.s_flame_particle, 3);
	part_particles_create(global.particle_system, mouse_x, mouse_y, global.ember_particle, 1);
}