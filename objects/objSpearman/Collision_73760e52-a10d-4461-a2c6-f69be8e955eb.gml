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

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 3BFE9DDE
	/// @DnDParent : 3E12405F
	/// @DnDArgument : "var" "image_index"
	image_index = 0;

	/// @DnDAction : YoYo Games.Instances.Sprite_Animation_Speed
	/// @DnDVersion : 1
	/// @DnDHash : 4B845185
	/// @DnDParent : 3E12405F
	image_speed = 1;

	/// @DnDAction : YoYo Games.Instances.Set_Sprite
	/// @DnDVersion : 1
	/// @DnDHash : 2DB1D3A8
	/// @DnDParent : 3E12405F
	/// @DnDArgument : "imageind_relative" "1"
	/// @DnDArgument : "spriteind" "sprSpearmanDeath"
	/// @DnDSaveInfo : "spriteind" "1a192e84-524d-47f4-a444-e6f8ad158baf"
	sprite_index = sprSpearmanDeath;
	image_index += 0;

	/// @DnDAction : YoYo Games.Audio.Play_Audio
	/// @DnDVersion : 1
	/// @DnDHash : 077C0F85
	/// @DnDParent : 3E12405F
	/// @DnDArgument : "soundid" "sndSpearmanHurt"
	/// @DnDSaveInfo : "soundid" "f6b1896a-e8fc-4df0-bcc1-2e0b106d4b66"
	audio_play_sound(sndSpearmanHurt, 0, 0);

	/// @DnDAction : YoYo Games.Audio.Play_Audio
	/// @DnDVersion : 1
	/// @DnDHash : 2EB1C9AA
	/// @DnDParent : 3E12405F
	/// @DnDArgument : "soundid" "sndBurn"
	/// @DnDSaveInfo : "soundid" "c83212b2-29d0-41a6-91b8-e67da37c3033"
	audio_play_sound(sndBurn, 0, 0);

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