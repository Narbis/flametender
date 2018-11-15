// Increment frame counter

frame_counter += 1;

switch (state)
{
	
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: IDLE
	//
	// The knight is standing still
	//-----------------------------------------------------------------------------------------------------------------
	#region 
	case knight_states.idle:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = 0;
		
		// Animations
		
		sprite_index = sprKnightIdle;
		
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Set shield
		
		shield_active = false;
		
		// If the player gets close to the knight, he enters the alerted state
		
		if (distance_to_object(objPlayer) < aggro_distance)
		{
			state = knight_states.alerted;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != knight_states.idle)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ALERTED
	//
	// The knight is transitioning into the pursuit state
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case knight_states.alerted:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprKnightAlerted;
			
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
		
		// Set shield
		if (frame_counter == 24)
		{
			shield_active = true;
		}
		
		// When animation finishes, enter pursuit state
		
		if (frame_counter >= 48)
		{
			state = knight_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != knight_states.alerted)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: PURSUIT
	//
	// The knight is moving towards the player
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case knight_states.pursuit:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// If the player gets within attacking distance, enter the attack state
		
		if (objPlayer.state != player_states.dead && distance_to_object(objPlayer) < attack_distance)
		{
			state = knight_states.attack;
		}
		
		// Calculate movement and facing; enter turnaround state if necessary
		
		if ((x < objPlayer.x && face_right) || (x > objPlayer.x && !face_right))
		{
			h_speed = move_speed * sign(objPlayer.x - x);
		}
		else
		{
			state = knight_states.turnaround;
		}
		
		// Knight should stop moving when encountering a wall, ledge, or enemy, OR when the player is above or below but not moving
		
		if ((place_meeting(x + sign(h_speed), y, objWall) || place_meeting(x + h_speed, y + 1, objLedge) || instance_place(x + (sign(h_speed) * 12), y, objEnemy)) || (objPlayer.h_speed == 0 && abs(objPlayer.y - y) > 20))
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
			sprite_index = sprKnightPursuitWait;
		}
		else
		{
			sprite_index = sprKnightPursuit;
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
		
		// Set shield
		if (frame_counter == 1)
		{
			shield_active = true;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != knight_states.pursuit)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: TURNAROUND
	//
	// The knight is turning around
	//-----------------------------------------------------------------------------------------------------------------
	
	#region
	case knight_states.turnaround:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprKnightTurnAround;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (frame_counter == 1)
		{
			if (face_right)
			{
				image_xscale = 1;
			}
			else
			{
				image_xscale = -1;
			}
		}

		// Set shield
		if (frame_counter == 1)
		{
			shield_active = true;
		}
		
		if (frame_counter == 23)
		{
			face_right = !face_right;
		}
		
		
		// Change pack to pursuit state after animation completes
		
		if (frame_counter >= 37)
		{
			state = knight_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != knight_states.turnaround)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: BLOCK
	//
	// The knight is blocking an attack
	//-----------------------------------------------------------------------------------------------------------------
	
	#region
	case knight_states.block:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprKnightBlock;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Set shield
		
		if (frame_counter == 1)
		{
			shield_active = true;
		}
		
		// Change pack to pursuit state after animation completes
		
		if (frame_counter >= 30)
		{
			state = knight_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != knight_states.block)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ATTACK
	//
	// The knight is attacking the player
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case knight_states.attack:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprKnightAttack;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// On frame 3, create attack hitbox and play sound
		
		if (frame_counter == 12)
		{
			with(instance_create_layer(x, y, "Player", objKnightHitbox))
			{
				image_xscale = other.image_xscale;
			}
			
			scrPlaySound(sndSpearmanAttack, x, y);
		}
		
		// Set shield
		
		if (frame_counter == 1)
		{
			shield_active = false;
		}
		
		// Change pack to pursuit state after animation completes
		
		if (frame_counter >= 30)
		{
			state = knight_states.pursuit;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != knight_states.attack)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HURT
	//
	// The knight is invulnable after being hurt
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case knight_states.hurt:
		
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
		
		sprite_index = sprKnightHit;
			
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
			state = knight_states.pursuit;
		}
		
		// Set shield
		
		if (frame_counter == 1)
		{
			shield_active = false;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != knight_states.hurt)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The knight is dead
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case knight_states.dead:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		sprite_index = sprKnightDeath;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Set shield
		
		if (frame_counter == 1)
		{
			shield_active = false;
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