/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 40A9C606
/// @DnDArgument : "expr" "dead"
/// @DnDArgument : "not" "1"
if(!(dead))
{
	/// @DnDAction : YoYo Games.Common.If_Expression
	/// @DnDVersion : 1
	/// @DnDHash : 3488A984
	/// @DnDParent : 40A9C606
	/// @DnDArgument : "expr" "distance_to_object(objPlayer) < 100 and state != 4"
	if(distance_to_object(objPlayer) < 100 and state != 4)
	{
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 31565842
		/// @DnDParent : 3488A984
		/// @DnDArgument : "expr" "4"
		/// @DnDArgument : "var" "state"
		state = 4;
	
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 79D9A5D3
		/// @DnDParent : 3488A984
		/// @DnDArgument : "var" "state_counter"
		state_counter = 0;
	}

	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 4325DF91
	/// @DnDParent : 40A9C606
	/// @DnDArgument : "var" "state"
	/// @DnDArgument : "value" "1"
	if(state == 1)
	{
		/// @DnDAction : YoYo Games.Instances.Set_Sprite
		/// @DnDVersion : 1
		/// @DnDHash : 0B9802E7
		/// @DnDParent : 4325DF91
		/// @DnDArgument : "spriteind" "sprSpearmanIdle"
		/// @DnDSaveInfo : "spriteind" "1fadbd79-6d03-42bf-8cad-1f0c64c99be6"
		sprite_index = sprSpearmanIdle;
		image_index = 0;
	
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 141A319C
		/// @DnDParent : 4325DF91
		/// @DnDArgument : "expr" "1"
		/// @DnDArgument : "expr_relative" "1"
		/// @DnDArgument : "var" "state_counter"
		state_counter += 1;
	
		/// @DnDAction : YoYo Games.Common.If_Variable
		/// @DnDVersion : 1
		/// @DnDHash : 5DAC48F7
		/// @DnDParent : 4325DF91
		/// @DnDArgument : "var" "state_counter"
		/// @DnDArgument : "value" "60"
		if(state_counter == 60)
		{
			/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 00CDEB8E
			/// @DnDParent : 5DAC48F7
			/// @DnDArgument : "expr" "irandom_range(2, 3)"
			/// @DnDArgument : "var" "state"
			state = irandom_range(2, 3);
		
			/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 7E5AB3AA
			/// @DnDParent : 5DAC48F7
			/// @DnDArgument : "var" "state_counter"
			state_counter = 0;
		}
	}

	/// @DnDAction : YoYo Games.Common.Else
	/// @DnDVersion : 1
	/// @DnDHash : 073B86AF
	/// @DnDParent : 40A9C606
	else
	{
		/// @DnDAction : YoYo Games.Common.If_Expression
		/// @DnDVersion : 1
		/// @DnDHash : 40E84FD7
		/// @DnDParent : 073B86AF
		/// @DnDArgument : "expr" "state == 2 or state == 3"
		if(state == 2 or state == 3)
		{
			/// @DnDAction : YoYo Games.Instances.Set_Sprite
			/// @DnDVersion : 1
			/// @DnDHash : 1E876B18
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "imageind_relative" "1"
			/// @DnDArgument : "spriteind" "sprSpearmanWalk"
			/// @DnDSaveInfo : "spriteind" "c4048e0c-069a-46ba-b3d4-be8887fcf44e"
			sprite_index = sprSpearmanWalk;
			image_index += 0;
		
			/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 090DDB65
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "expr" "1"
			/// @DnDArgument : "expr_relative" "1"
			/// @DnDArgument : "var" "state_counter"
			state_counter += 1;
		
			/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 730BA54C
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "expr" "vsp + grv"
			/// @DnDArgument : "var" "vsp"
			vsp = vsp + grv;
		
			/// @DnDAction : YoYo Games.Common.If_Expression
			/// @DnDVersion : 1
			/// @DnDHash : 083A4211
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "expr" "state == 2"
			if(state == 2)
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 63691F0D
				/// @DnDParent : 083A4211
				/// @DnDArgument : "expr" "walkspeed"
				/// @DnDArgument : "var" "hsp"
				hsp = walkspeed;
			}
		
			/// @DnDAction : YoYo Games.Common.Else
			/// @DnDVersion : 1
			/// @DnDHash : 58FF8243
			/// @DnDParent : 40E84FD7
			else
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 4CA61031
				/// @DnDParent : 58FF8243
				/// @DnDArgument : "expr" "-walkspeed"
				/// @DnDArgument : "var" "hsp"
				hsp = -walkspeed;
			}
		
			/// @DnDAction : YoYo Games.Collisions.If_Object_At
			/// @DnDVersion : 1.1
			/// @DnDHash : 287E0453
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "x" "x + hsp"
			/// @DnDArgument : "y" "y"
			/// @DnDArgument : "object" "objWall"
			/// @DnDSaveInfo : "object" "cc11bd9e-c820-4081-a465-8f0dc66c8bf7"
			var l287E0453_0 = instance_place(x + hsp, y, objWall);
			if ((l287E0453_0 > 0))
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 7FB9DF88
				/// @DnDParent : 287E0453
				/// @DnDArgument : "var" "hsp"
				hsp = 0;
			}
		
			/// @DnDAction : YoYo Games.Movement.Jump_To_Point
			/// @DnDVersion : 1
			/// @DnDHash : 3DDB65E0
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "x" "x + hsp"
			x = x + hsp;
		
			/// @DnDAction : YoYo Games.Collisions.If_Object_At
			/// @DnDVersion : 1.1
			/// @DnDHash : 13DD5BC8
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "x" "x"
			/// @DnDArgument : "y" "y + vsp"
			/// @DnDArgument : "object" "objWall"
			/// @DnDSaveInfo : "object" "cc11bd9e-c820-4081-a465-8f0dc66c8bf7"
			var l13DD5BC8_0 = instance_place(x, y + vsp, objWall);
			if ((l13DD5BC8_0 > 0))
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 7217F2B1
				/// @DnDParent : 13DD5BC8
				/// @DnDArgument : "var" "vsp"
				vsp = 0;
			}
		
			/// @DnDAction : YoYo Games.Movement.Jump_To_Point
			/// @DnDVersion : 1
			/// @DnDHash : 48B01DF6
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "y" "y + vsp"
			
			y = y + vsp;
		
			/// @DnDAction : YoYo Games.Common.If_Variable
			/// @DnDVersion : 1
			/// @DnDHash : 341CF481
			/// @DnDParent : 40E84FD7
			/// @DnDArgument : "var" "state_counter"
			/// @DnDArgument : "value" "120"
			if(state_counter == 120)
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 144F26CC
				/// @DnDParent : 341CF481
				/// @DnDArgument : "expr" "1"
				/// @DnDArgument : "var" "state"
				state = 1;
			
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 3FFB9A51
				/// @DnDParent : 341CF481
				/// @DnDArgument : "var" "state_counter"
				state_counter = 0;
			}
		}
	
		/// @DnDAction : YoYo Games.Common.Else
		/// @DnDVersion : 1
		/// @DnDHash : 2183A7DF
		/// @DnDParent : 073B86AF
		else
		{
			/// @DnDAction : YoYo Games.Common.If_Expression
			/// @DnDVersion : 1
			/// @DnDHash : 2573B20A
			/// @DnDParent : 2183A7DF
			/// @DnDArgument : "expr" "distance_to_object(objPlayer) < 15 or state_counter != 0"
			if(distance_to_object(objPlayer) < 15 or state_counter != 0)
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 64553845
				/// @DnDParent : 2573B20A
				/// @DnDArgument : "expr" "1"
				/// @DnDArgument : "expr_relative" "1"
				/// @DnDArgument : "var" "state_counter"
				state_counter += 1;
			
				/// @DnDAction : YoYo Games.Instances.Set_Sprite
				/// @DnDVersion : 1
				/// @DnDHash : 6B2AEE08
				/// @DnDParent : 2573B20A
				/// @DnDArgument : "imageind_relative" "1"
				/// @DnDArgument : "spriteind" "sprSpearmanAttack"
				/// @DnDSaveInfo : "spriteind" "81d0942e-2646-4b16-9b29-6e210d1e6e32"
				sprite_index = sprSpearmanAttack;
				image_index += 0;
			
				/// @DnDAction : YoYo Games.Common.If_Expression
				/// @DnDVersion : 1
				/// @DnDHash : 437BB904
				/// @DnDParent : 2573B20A
				/// @DnDArgument : "expr" "state_counter == 7"
				if(state_counter == 7)
				{
					/// @DnDAction : YoYo Games.Common.If_Expression
					/// @DnDVersion : 1
					/// @DnDHash : 43EB232D
					/// @DnDParent : 437BB904
					/// @DnDArgument : "expr" "face_right"
					if(face_right)
					{
						/// @DnDAction : YoYo Games.Instances.Create_Instance
						/// @DnDVersion : 1
						/// @DnDHash : 6D171FC9
						/// @DnDParent : 43EB232D
						/// @DnDArgument : "xpos" "x + 15"
						/// @DnDArgument : "ypos" "y + 5"
						/// @DnDArgument : "objectid" "objSpearmanHitbox"
						/// @DnDArgument : "layer" ""Player""
						/// @DnDSaveInfo : "objectid" "7e7513dd-aa0e-40df-996a-f9855828d38f"
						instance_create_layer(x + 15, y + 5, "Player", objSpearmanHitbox);
					}
				
					/// @DnDAction : YoYo Games.Common.Else
					/// @DnDVersion : 1
					/// @DnDHash : 70A9241B
					/// @DnDParent : 437BB904
					else
					{
						/// @DnDAction : YoYo Games.Instances.Create_Instance
						/// @DnDVersion : 1
						/// @DnDHash : 1DCCC709
						/// @DnDParent : 70A9241B
						/// @DnDArgument : "xpos" "x - 15"
						/// @DnDArgument : "ypos" "y + 5"
						/// @DnDArgument : "objectid" "objSpearmanHitbox"
						/// @DnDArgument : "layer" ""Player""
						/// @DnDSaveInfo : "objectid" "7e7513dd-aa0e-40df-996a-f9855828d38f"
						instance_create_layer(x - 15, y + 5, "Player", objSpearmanHitbox);
					}
				}
			
				/// @DnDAction : YoYo Games.Common.Else
				/// @DnDVersion : 1
				/// @DnDHash : 4DE66FAE
				/// @DnDParent : 2573B20A
				else
				{
					/// @DnDAction : YoYo Games.Common.If_Expression
					/// @DnDVersion : 1
					/// @DnDHash : 40FE0DE5
					/// @DnDParent : 4DE66FAE
					/// @DnDArgument : "expr" "state_counter == 30"
					if(state_counter == 30)
					{
						/// @DnDAction : YoYo Games.Common.Variable
						/// @DnDVersion : 1
						/// @DnDHash : 34B62B5D
						/// @DnDParent : 40FE0DE5
						/// @DnDArgument : "var" "state_counter"
						state_counter = 0;
					}
				}
			}
		
			/// @DnDAction : YoYo Games.Common.Else
			/// @DnDVersion : 1
			/// @DnDHash : 7F88F6EF
			/// @DnDParent : 2183A7DF
			else
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 5729E207
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "expr" "1.5"
				/// @DnDArgument : "var" "walkspeed"
				walkspeed = 1.5;
			
				/// @DnDAction : YoYo Games.Instances.Sprite_Animation_Speed
				/// @DnDVersion : 1
				/// @DnDHash : 73D4AF1D
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "speed" "1.5"
				image_speed = 1.5;
			
				/// @DnDAction : YoYo Games.Instances.Set_Sprite
				/// @DnDVersion : 1
				/// @DnDHash : 5D895D32
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "imageind_relative" "1"
				/// @DnDArgument : "spriteind" "sprSpearmanWalk"
				/// @DnDSaveInfo : "spriteind" "c4048e0c-069a-46ba-b3d4-be8887fcf44e"
				sprite_index = sprSpearmanWalk;
				image_index += 0;
			
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 24073D79
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "expr" "vsp + grv"
				/// @DnDArgument : "var" "vsp"
				vsp = vsp + grv;
			
				/// @DnDAction : YoYo Games.Common.If_Expression
				/// @DnDVersion : 1
				/// @DnDHash : 37AAEA6F
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "expr" "objPlayer.x > x"
				if(objPlayer.x > x)
				{
					/// @DnDAction : YoYo Games.Common.Variable
					/// @DnDVersion : 1
					/// @DnDHash : 6691F606
					/// @DnDParent : 37AAEA6F
					/// @DnDArgument : "expr" "walkspeed"
					/// @DnDArgument : "var" "hsp"
					hsp = walkspeed;
				}
			
				/// @DnDAction : YoYo Games.Common.Else
				/// @DnDVersion : 1
				/// @DnDHash : 45A53694
				/// @DnDParent : 7F88F6EF
				else
				{
					/// @DnDAction : YoYo Games.Common.Variable
					/// @DnDVersion : 1
					/// @DnDHash : 264A60F9
					/// @DnDParent : 45A53694
					/// @DnDArgument : "expr" "-walkspeed"
					/// @DnDArgument : "var" "hsp"
					hsp = -walkspeed;
				}
			
				/// @DnDAction : YoYo Games.Collisions.If_Object_At
				/// @DnDVersion : 1.1
				/// @DnDHash : 01B5A230
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "x" "x + hsp"
				/// @DnDArgument : "y" "y"
				/// @DnDArgument : "object" "objWall"
				/// @DnDSaveInfo : "object" "cc11bd9e-c820-4081-a465-8f0dc66c8bf7"
				var l01B5A230_0 = instance_place(x + hsp, y, objWall);
				if ((l01B5A230_0 > 0))
				{
					/// @DnDAction : YoYo Games.Common.Variable
					/// @DnDVersion : 1
					/// @DnDHash : 7E76757F
					/// @DnDParent : 01B5A230
					/// @DnDArgument : "var" "hsp"
					hsp = 0;
				}
			
				/// @DnDAction : YoYo Games.Movement.Jump_To_Point
				/// @DnDVersion : 1
				/// @DnDHash : 79437ACB
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "x" "x + hsp"
				x = x + hsp;
			
				/// @DnDAction : YoYo Games.Collisions.If_Object_At
				/// @DnDVersion : 1.1
				/// @DnDHash : 63A7E9FB
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "x" "x"
				/// @DnDArgument : "y" "y + vsp"
				/// @DnDArgument : "object" "objWall"
				/// @DnDSaveInfo : "object" "cc11bd9e-c820-4081-a465-8f0dc66c8bf7"
				var l63A7E9FB_0 = instance_place(x, y + vsp, objWall);
				if ((l63A7E9FB_0 > 0))
				{
					/// @DnDAction : YoYo Games.Common.Variable
					/// @DnDVersion : 1
					/// @DnDHash : 24AD6B6D
					/// @DnDParent : 63A7E9FB
					/// @DnDArgument : "var" "vsp"
					vsp = 0;
				}
			
				/// @DnDAction : YoYo Games.Movement.Jump_To_Point
				/// @DnDVersion : 1
				/// @DnDHash : 1A4A90AB
				/// @DnDParent : 7F88F6EF
				/// @DnDArgument : "y" "y + vsp"
				
				y = y + vsp;
			}
		}
	}

	/// @DnDAction : YoYo Games.Common.If_Expression
	/// @DnDVersion : 1
	/// @DnDHash : 0BA319B7
	/// @DnDParent : 40A9C606
	/// @DnDArgument : "expr" "hsp > 0"
	if(hsp > 0)
	{
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 65F10949
		/// @DnDParent : 0BA319B7
		/// @DnDArgument : "expr" "true"
		/// @DnDArgument : "var" "face_right"
		face_right = true;
	
		/// @DnDAction : YoYo Games.Instances.Sprite_Scale
		/// @DnDVersion : 1
		/// @DnDHash : 3914E6DA
		/// @DnDParent : 0BA319B7
		image_xscale = 1;
		image_yscale = 1;
	}

	/// @DnDAction : YoYo Games.Common.If_Expression
	/// @DnDVersion : 1
	/// @DnDHash : 6E25497D
	/// @DnDParent : 40A9C606
	/// @DnDArgument : "expr" "hsp < 0"
	if(hsp < 0)
	{
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 3FE843CB
		/// @DnDParent : 6E25497D
		/// @DnDArgument : "expr" "false"
		/// @DnDArgument : "var" "face_right"
		face_right = false;
	
		/// @DnDAction : YoYo Games.Instances.Sprite_Scale
		/// @DnDVersion : 1
		/// @DnDHash : 72D4CBBC
		/// @DnDParent : 6E25497D
		/// @DnDArgument : "xscale" "-1"
		image_xscale = -1;
		image_yscale = 1;
	}
}