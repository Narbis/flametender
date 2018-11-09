/// PlaySound(sound, x, y)
/// @description PlaySound(sound, x, y)
/// @param sound
/// @param x
/// @param y

var distance = point_distance(argument1, argument2, objCamera.x, objCamera.y);

var gain = 1;

if (distance > 200)
{
	gain = max(0, (200 - (distance - 200)) / 200);
}

var sound = audio_play_sound(argument0, 10, false);
audio_sound_gain(sound, gain, 0);