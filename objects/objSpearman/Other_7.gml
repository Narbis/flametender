/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 1BCD9839
/// @DnDArgument : "expr" "sprite_index == sprSpearmanDeath"
if(sprite_index == sprSpearmanDeath)
{
	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 1D7C4CF9
	/// @DnDParent : 1BCD9839
	/// @DnDArgument : "xpos" "x"
	/// @DnDArgument : "ypos" "y"
	/// @DnDArgument : "var" "target"
	/// @DnDArgument : "var_temp" "1"
	/// @DnDArgument : "objectid" "objSpearmanAshes"
	/// @DnDArgument : "layer" ""Player""
	/// @DnDSaveInfo : "objectid" "852bb078-f9b2-4b35-9e3c-35a3bb213b8d"
	var target = instance_create_layer(x, y, "Player", objSpearmanAshes);

	/// @DnDAction : YoYo Games.Common.If_Expression
	/// @DnDVersion : 1
	/// @DnDHash : 1F09EFAC
	/// @DnDParent : 1BCD9839
	/// @DnDArgument : "expr" "face_right"
	/// @DnDArgument : "not" "1"
	if(!(face_right))
	{
		/// @DnDAction : YoYo Games.Instances.Sprite_Scale
		/// @DnDVersion : 1
		/// @DnDHash : 4DA0913B
		/// @DnDApplyTo : target
		/// @DnDParent : 1F09EFAC
		/// @DnDArgument : "xscale" "-1"
		with(target) {
		image_xscale = -1;
		image_yscale = 1;
		}
	}

	/// @DnDAction : YoYo Games.Instances.Destroy_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 62A5CFA9
	/// @DnDParent : 1BCD9839
	instance_destroy();
}