if (other.state != player_states.flamedash && !other.invuln)
{
	other.flame -= 5;
	instance_destroy();
}