extends VisibleOnScreenNotifier2D
class_name Bullet_DeleteOffScreen

func _ready() -> void:
	if Bullet.get_bullet(self):
		screen_exited.connect(Bullet.get_bullet(self).queue_free)
