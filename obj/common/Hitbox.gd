@icon("res://icons/hitbox_class.svg")
extends Area2D
class_name HitBox

@export var health_actor: Health
enum dmg_mode{ON_ENTER, ON_EXIT, ON_COLLISION}
@export var damage_mode: dmg_mode
@export_range(0,1,0.01, "or_greater", "suffix:s") var damage_cooldown: float = 0
@export_group("Actors")
@export var cooldown_timer: Timer

func _on_area_entered(area: Area2D) -> void:
	if damage_mode == dmg_mode.ON_ENTER and area is HurtBox:
		health_actor.harm(area.damage)

func _on_area_exited(area: Area2D) -> void:
	if damage_mode == dmg_mode.ON_EXIT and area is HurtBox:
		health_actor.harm(area.damage)
