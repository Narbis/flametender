/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 3B74D923
/// @DnDArgument : "expr" "facing_right == true"
if(facing_right == true)
{
	/// @DnDAction : YoYo Games.Movement.Jump_To_Point
	/// @DnDVersion : 1
	/// @DnDHash : 00E69F48
	/// @DnDParent : 3B74D923
	/// @DnDArgument : "x" "x + 6"
	/// @DnDArgument : "y" "y"
	x = x + 6;
	y = y;
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 165A78E1
else
{
	/// @DnDAction : YoYo Games.Instances.Sprite_Scale
	/// @DnDVersion : 1
	/// @DnDHash : 05C6261B
	/// @DnDParent : 165A78E1
	/// @DnDArgument : "xscale" "-1"
	image_xscale = -1;
	image_yscale = 1;

	/// @DnDAction : YoYo Games.Movement.Jump_To_Point
	/// @DnDVersion : 1
	/// @DnDHash : 0775076B
	/// @DnDParent : 165A78E1
	/// @DnDArgument : "x" "x - 6"
	/// @DnDArgument : "y" "y"
	x = x - 6;
	y = y;
}