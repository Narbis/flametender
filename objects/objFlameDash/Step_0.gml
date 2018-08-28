/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 3A763F0D
/// @DnDArgument : "expr" "instance_exists(follow)"
if(instance_exists(follow))
{
	/// @DnDAction : YoYo Games.Movement.Jump_To_Point
	/// @DnDVersion : 1
	/// @DnDHash : 647020B4
	/// @DnDParent : 3A763F0D
	/// @DnDArgument : "x" "follow.x"
	/// @DnDArgument : "y" "follow.y"
	x = follow.x;
	y = follow.y;
}