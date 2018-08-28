/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 65E7E31A
/// @DnDArgument : "expr" "view_camera[0]"
/// @DnDArgument : "var" "cam"
cam = view_camera[0];

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 24754E90
/// @DnDArgument : "expr" "objPlayer"
/// @DnDArgument : "var" "follow"
follow = objPlayer;

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 1A3598B8
/// @DnDInput : 2
/// @DnDArgument : "expr" "xstart"
/// @DnDArgument : "expr_1" "ystart"
/// @DnDArgument : "var" "towardX"
/// @DnDArgument : "var_1" "towardY"
towardX = xstart;
towardY = ystart;

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 755000C4
/// @DnDInput : 2
/// @DnDArgument : "expr" "camera_get_view_width(cam) * 0.5"
/// @DnDArgument : "expr_1" "camera_get_view_height(cam) * 0.5"
/// @DnDArgument : "var" "view_w_half"
/// @DnDArgument : "var_1" "view_h_half"
view_w_half = camera_get_view_width(cam) * 0.5;
view_h_half = camera_get_view_height(cam) * 0.5;