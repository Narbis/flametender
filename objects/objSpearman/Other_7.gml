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
	/// @DnDArgument : "objectid" "objSpearmanAshes"
	/// @DnDArgument : "layer" ""Player""
	/// @DnDSaveInfo : "objectid" "852bb078-f9b2-4b35-9e3c-35a3bb213b8d"
	instance_create_layer(x, y, "Player", objSpearmanAshes);

	/// @DnDAction : YoYo Games.Instances.Destroy_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 62A5CFA9
	/// @DnDParent : 1BCD9839
	instance_destroy();
}