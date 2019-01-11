if (other.state != player_states.flamedash)
{
	other.flame -= 5;
	instance_destroy();
}