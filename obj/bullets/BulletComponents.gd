extends Node
class_name BulletComponent

func get_bullet() -> Bullet:
	if get_parent() is Bullet:
		return get_parent()
	else:
		return
