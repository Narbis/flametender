enum spearman_states 
{
	idle,
	patrol,
	alerted,
	pursuit,
	attack,
	hurt,
	dead
}

// State and movement variables

state = spearman_states.idle;
face_right = true;
reset_animation = false;

h_speed = 0;
life = 1;

// State counters and constants

frame_counter = 0;

attack_frames = 20;
hurt_frames = 20;
dead_frames = 120;

aggro_distance = 100;
attack_distance = 20;

// Movement constants

move_speed = 1.5;