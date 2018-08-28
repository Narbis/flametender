/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 445094E8
/// @DnDArgument : "expr" "facing_right"
if(facing_right)
{
	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 3B531F51
	/// @DnDParent : 445094E8
	/// @DnDArgument : "xpos" "x + 4"
	/// @DnDArgument : "ypos" "y"
	/// @DnDArgument : "objectid" "objFireballHit"
	/// @DnDArgument : "layer" ""Player""
	/// @DnDSaveInfo : "objectid" "417ccadb-0171-48eb-ab14-e9f88909ac63"
	instance_create_layer(x + 4, y, "Player", objFireballHit);
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 0943640E
else
{
	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 1D74E315
	/// @DnDParent : 0943640E
	/// @DnDArgument : "xpos" "x - 4"
	/// @DnDArgument : "ypos" "y"
	/// @DnDArgument : "objectid" "objFireballHit"
	/// @DnDArgument : "layer" ""Player""
	/// @DnDSaveInfo : "objectid" "417ccadb-0171-48eb-ab14-e9f88909ac63"
	instance_create_layer(x - 4, y, "Player", objFireballHit);
}

/// @DnDAction : YoYo Games.Instances.Destroy_Instance
/// @DnDVersion : 1
/// @DnDHash : 5E68BB58
instance_destroy();