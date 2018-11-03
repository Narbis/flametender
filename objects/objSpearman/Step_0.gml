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
		
		// If the player gets close to the Spearman, he enters the alerted state
		
		if (distance_to_object(objPlayer) < aggro_distance)
		{
			state = spearman_states.alerted;
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
		
		// If the player gets close to the Spearman, he enters the alerted state
		
		if (distance_to_object(objPlayer) < aggro_distance)
		{
			state = spearman_states.alerted;
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
		
		if (x < objPlayer.x)
		{
			face_right = true;
			image_xscale = 1;
		}
		else
		{
			face_right = false;
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
		
		// Calculate movement and facing
		
		if (x < objPlayer.x)
		{
			face_right = true;
			h_speed = move_speed;
		}
		else
		{
			face_right = false;
			h_speed = -move_speed;
		}
		
		// Spearman should stop moving when encountering a wall or ledge OR when the player is above or below but not moving
		
		if ((place_meeting(x + 1, y, objWall) || place_meeting(x + h_speed, y + 1, objLedge)) || (objPlayer.h_speed == 0 && abs(objPlayer.y - y) > 20))
		{
			h_speed = 0;
		}
		
		if (objPlayer.state == player_states.dead)
		{
			h_speed = 0;
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
		
		if (h_speed == 0)
		{
			sprite_index = sprSpearmanPursuitWait;
		}
		else
		{
			sprite_index = sprSpearmanPursuit;
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
		
		// If the player gets within attacking distance, enter the attack state
		
		if (objPlayer.state != player_states.dead && distance_to_object(objPlayer) < attack_distance)
		{
			state = spearman_states.attack;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != spearman_states.pursuit)
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
			state = spearman_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != spearman_states.attack)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HURT
	//
	// The spearman is invulnable after being hurt
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case spearman_states.hurt:
		
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
			state = spearman_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != spearman_states.hurt)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The spearman is dead
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case spearman_states.dead:
		
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