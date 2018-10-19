// Draw player sprite flashing inverted if invulnerable, otherwise draw normally

if (invuln && (invuln_counter % 6 >= 0 && invuln_counter % 6 < 3))
{
	if (shader_is_compiled(shaInvert))
	{
		shader_set(shaInvert);
		draw_self();
		shader_reset();
	}
}
else
{
	draw_self();
}