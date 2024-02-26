@icon("res://icons/health_class.svg")
extends Node
class_name Health

enum Team {PLAYER, ENEMY, NEUTRAL, NONE}

@export_group("Health Settings")
@export var invincible: bool = false ## health can go below 0
@export_range(1,10, 1, "or_greater") var max_health: int = 8
@export_range(1,10, 1, "or_greater") var starting_health: int = 8
@export_group("Regeneration")
@export_range(0, 300, 0.01, "suffix:s", "or_greater") var regen_time: float = 60
@export_range(0, 10, 0.01, "suffix:s", "or_greater") var regen_offset: float = 3
@export_group("Actors")
@export var regen_timer: Timer
@export var offset_timer: Timer

var health: float = starting_health
var old_health: float = health

signal harmed(damage)
signal healed(amount)
signal died

func _process(_delta: float) -> void:
	if !invincible:
		health = clamp(health, 0, max_health)
	else:
		health = min(health, max_health)
	if old_health > health:
		harmed.emit(old_health - health)
	if old_health < health:
		harmed.emit(health - old_health)
	if old_health != health:
		old_health = health

func heal(amount):
	health += amount

func harm(amount):
	health -= amount
