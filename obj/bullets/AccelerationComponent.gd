extends Node
class_name Acceleration

@export var acceleration: float = -100

func _process(delta: float) -> void:
	if Bullet.get_bullet(self): 
		Bullet.get_bullet(self).velocity += acceleration * Bullet.get_bullet(self).velocity.normalized() * delta
