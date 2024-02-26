extends Node
class_name DeleteComponent

@export var time: float = 1.0

func _ready() -> void:
	if Bullet.get_bullet(self):
		await get_tree().create_timer(time).timeout
		Bullet.get_bullet(self).queue_free()
