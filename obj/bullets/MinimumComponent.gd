extends Node
class_name MinimumVelocity

@export var minimum: float = 25

func _process(_delta: float) -> void:
	if Bullet.get_bullet(self) and Bullet.get_bullet(self).velocity.length() <= minimum:
		Bullet.get_bullet(self).queue_free()
