/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 66E8581A
/// @DnDArgument : "expr" "facing_right"
if(facing_right)
{
	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 1E4B6EB8
	/// @DnDParent : 66E8581A
	/// @DnDArgument : "xpos" "x + 4"
	/// @DnDArgument : "ypos" "y"
	/// @DnDArgument : "objectid" "objFireballHit"
	/// @DnDArgument : "layer" ""Player""
	/// @DnDSaveInfo : "objectid" "417ccadb-0171-48eb-ab14-e9f88909ac63"
	instance_create_layer(x + 4, y, "Player", objFireballHit);
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 6EACA8E1
else
{
	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 4875EFBA
	/// @DnDParent : 6EACA8E1
	/// @DnDArgument : "xpos" "x - 4"
	/// @DnDArgument : "ypos" "y"
	/// @DnDArgument : "objectid" "objFireballHit"
	/// @DnDArgument : "layer" ""Player""
	/// @DnDSaveInfo : "objectid" "417ccadb-0171-48eb-ab14-e9f88909ac63"
	instance_create_layer(x - 4, y, "Player", objFireballHit);
}

/// @DnDAction : YoYo Games.Instances.Destroy_Instance
/// @DnDVersion : 1
/// @DnDHash : 12A3E35E
instance_destroy();