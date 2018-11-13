if (objControls.action == input.activate)
{
	objPlayer.bunny = true;
	scrPlaySound(sndSelect, x, y);
	instance_destroy();
}