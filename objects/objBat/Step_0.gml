// Increment frame counter

frame_counter += 1;

switch (state)
{
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: IDLE
	//
	// The bat is hanging
	//-----------------------------------------------------------------------------------------------------------------
	#region 
	case bat_states.idle:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Calculate movement
		
		h_speed = 0;
		
		// Animations
		
		if (distance_to_object(objPlayer) < alert_distance)
		{
			sprite_index = sprBatHangEyes;
		}
		else
		{
			sprite_index = sprBatHang;
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
		
		
		if (wait_counter > wait_frames)
		{
			with(aggro_zone)
			{
				if (place_meeting(x, y, objPlayer))
				{
					other.state = bat_states.attack;
					other.wait_counter = 0;
				
					if (objPlayer.x > x)
					{
						other.face_right = true;
					}
					else
					{
						other.face_right = false;
					}
				}
			}
		}
		else
		{
			wait_counter++;
		}
		
		// Reset animation and frame counter if necessary
		
		if (state != bat_states.idle)
		{
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion

	//-----------------------------------------------------------------------------------------------------------------
	// STATE: ATTACK
	//
	// The bat is attacking the player
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case bat_states.attack:
		
		// Reset animation
		
		if (reset_animation == true)
		{
			image_index = 0;
			reset_animation = false;
		}
		
		// Animations
		
		if (v_speed > 0)
		{
			sprite_index = sprBatDescend;
		}
		else
		{
			sprite_index = sprBatAscend;
		}
			
		// Set facing of sprite and horizontal speed based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = -1;
			h_speed = move_speed;
		}
		else
		{
			image_xscale = 1;
			h_speed = -move_speed;
		}
		
		// Calculate movement and create hitbox
		
		if (frame_counter == 1)
		{
			v_speed = 5;
			hitbox = instance_create_layer(x, y, "Player", objBatHitbox);
		}
		else
		{
			v_speed = v_speed - objPlayer.v_gravity;
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
		
		// Move hitbox
		
		hitbox.x = x;
		hitbox.y = y;
		
		// Reset animation and frame counter if necessary
		
		if (place_meeting(x, y - 1, objWall))
		{
			state = bat_states.idle;
			reset_animation = true;
			frame_counter = 0;
			
			instance_destroy(hitbox);
			hitbox = noone;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: HURT
	//
	// The bat is invulnable after being hurt
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case bat_states.hurt:
		
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
		
		sprite_index = sprBatHurt;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = -1;
		}
		else
		{
			image_xscale = 1;
		}
		
		// Reset animation and frame counter if necessary
		
		hurt_counter++;
		
		if (hurt_counter > hurt_frames)
		{
			state = bat_states.attack;
			reset_animation = true;
			frame_counter = 0;
		}
		
		break;
	#endregion
	
	//-----------------------------------------------------------------------------------------------------------------
	// STATE: DEAD
	//
	// The bat is dead
	//-----------------------------------------------------------------------------------------------------------------
	#region
	case bat_states.dead:
		
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
		
		sprite_index = sprBatHurt;
			
		// Set facing of sprite based on state of the face_right variable
		
		if (face_right)
		{
			image_xscale = -1;
		}
		else
		{
			image_xscale = 1;
		}
		
		// Death particles
		
		x_spread += 0.1;
		y_spread += 0.1;
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
			instance_destroy(aggro_zone);
			instance_destroy();
		}
		
		break;
	#endregion
}

// Move aggro zone

if (instance_exists(aggro_zone))
{
	aggro_zone.x = x;
	aggro_zone.y = y;
}