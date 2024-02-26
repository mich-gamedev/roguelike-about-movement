extends BulletComponent
class_name GravityComponent

@export var rate:= Vector2(0,2000)

func _process(delta: float) -> void:
	if Bullet.get_bullet(self):
		Bullet.get_bullet(self).velocity += rate * delta
