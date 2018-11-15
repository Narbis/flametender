if (objControls.action == input.activate)
{
	objPlayer.bunny = true;
	scrPlaySound(sndWeird, x, y);
	instance_destroy();
}