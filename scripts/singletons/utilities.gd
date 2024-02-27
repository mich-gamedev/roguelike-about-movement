extends Node

func get_bool_axis(boolean : bool) -> int:
	return lerp(-1, 1, int(boolean))
