extends Node

var pos: Vector2
var vel: Vector2
var hp: float
var max_hp: float

var cam_limits: Rect2

signal player_fired
signal player_harmed
signal player_healed
