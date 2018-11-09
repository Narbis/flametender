// Draw knight sprite flashing inverted if invulnerable, otherwise draw normally

if (state == knight_states.hurt && (frame_counter % 6 >= 0 && frame_counter % 6 < 3))
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