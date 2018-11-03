// Increment frame counter

frame_counter += 1;

switch (state)
{
	
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: IDLE
	//
	// The bowman is standing still
	//-----------------------------------------------------------------------------------------------------------------
	#region 
	case bowman_states.idle:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = 0;
		
		// Animations
		
		sprite_index = sprBowmanIdle;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// After 2 seconds, change to attack state
		
		if (frame_counter >= 120)
		{	
			state = bowman_states.attack;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != bowman_states.idle)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ATTACK
	//
	// The bowman is shooting an arrow
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case bowman_states.attack:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprSpearmanAttack;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// On frame 2, create attack hitbox
		
		if (frame_counter == 6)
		{
			with(instance_create_layer(x, y, "Player", objSpearmanHitbox))
			{
				image_xscale = other.image_xscale;
			}
		}
		
		// Change pack to pursuit state after animation completes
		
		if (frame_counter >= 30)
		{
			state = bowman_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != bowman_states.attack)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HURT
	//
	// The bowman is invulnable after being hurt
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case bowman_states.hurt:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		v_speed = v_speed + objPlayer.v_gravity;
		
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
		
		sprite_index = sprSpearmanHit;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		if (place_meeting(x, y + 1, objWall))
		{
			state = bowman_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != bowman_states.hurt)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The bowman is dead
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case bowman_states.dead:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprSpearmanDeath;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Death particles
		
		x_spread += 0.1;
		y_spread += 0.2
		if (face_right)
		{
			part_emitter_region(global.particle_system, emitter, (x - 3) - x_spread, (x - 3) + x_spread, (y + 3) - y_spread, (y + 3) + y_spread, ps_shape_rectangle, ps_distr_invgaussian);
		}
		else
		{
			part_emitter_region(global.particle_system, emitter, (x + 3) - x_spread, (x + 3) + x_spread, (y + 3) - y_spread, (y + 3) + y_spread, ps_shape_rectangle, ps_distr_invgaussian);
		}
		part_emitter_burst(global.particle_system, emitter, global.flame_particle, 10);
		part_emitter_burst(global.particle_system, emitter, ash_ember_particle, 2);
		
		// Destroy instance after animation completes
		
		if (frame_counter >= 48)
		{
			part_emitter_burst(global.particle_system, emitter, ash_particle, 50);
			instance_destroy();
		}
		
		break;
	#endregion
}