/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 5AE0A343
/// @DnDArgument : "expr" "instance_exists(follow)"
if(instance_exists(follow))
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 71668769
	/// @DnDParent : 5AE0A343
	/// @DnDArgument : "expr" "follow.x"
	/// @DnDArgument : "var" "towardX"
	towardX = follow.x;

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7F03C884
	/// @DnDParent : 5AE0A343
	/// @DnDArgument : "expr" "follow.y"
	/// @DnDArgument : "var" "towardY"
	towardY = follow.y;
}

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 6DF77034
/// @DnDArgument : "expr" "(towardX - x) / 25"
/// @DnDArgument : "expr_relative" "1"
/// @DnDArgument : "var" "x"
x += (towardX - x) / 25;

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 0292D7C8
/// @DnDArgument : "expr" "(towardY - y) / 25"
/// @DnDArgument : "expr_relative" "1"
/// @DnDArgument : "var" "y"
y += (towardY - y) / 25;

/// @DnDAction : YoYo Games.Common.Function_Call
/// @DnDVersion : 1
/// @DnDHash : 3BDACF00
/// @DnDArgument : "function" "camera_set_view_pos"
/// @DnDArgument : "arg" "cam, x - view_w_half, y - view_h_half"
camera_set_view_pos(cam, x - view_w_half, y - view_h_half);