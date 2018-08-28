/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 3E12405F
/// @DnDArgument : "expr" "dead"
/// @DnDArgument : "not" "1"
if(!(dead))
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 2A553BF2
	/// @DnDParent : 3E12405F
	/// @DnDArgument : "expr" "true"
	/// @DnDArgument : "var" "dead"
	dead = true;

	/// @DnDAction : YoYo Games.Instances.Set_Sprite
	/// @DnDVersion : 1
	/// @DnDHash : 2DB1D3A8
	/// @DnDParent : 3E12405F
	/// @DnDArgument : "imageind_relative" "1"
	/// @DnDArgument : "spriteind" "sprSpearmanDeath"
	/// @DnDSaveInfo : "spriteind" "1a192e84-524d-47f4-a444-e6f8ad158baf"
	sprite_index = sprSpearmanDeath;
	image_index += 0;

	/// @DnDAction : YoYo Games.Common.If_Expression
	/// @DnDVersion : 1
	/// @DnDHash : 72EEB004
	/// @DnDParent : 3E12405F
	/// @DnDArgument : "expr" "face_right"
	/// @DnDArgument : "not" "1"
	if(!(face_right))
	{
		/// @DnDAction : YoYo Games.Instances.Sprite_Scale
		/// @DnDVersion : 1
		/// @DnDHash : 2E9872FB
		/// @DnDParent : 72EEB004
		/// @DnDArgument : "xscale" "-1"
		image_xscale = -1;
		image_yscale = 1;
	}
}