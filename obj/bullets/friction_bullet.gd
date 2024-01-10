extends Bullet
class_name FrictionBullet

@export var decay_rate: float
func _ready() -> void:
	screen_delete_actor.connect("screen_exited", off_screen_delete)

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, decay_rate * delta)
	move_and_slide()
	if velocity == Vector2.ZERO:
		queue_free()
	
func off_screen_delete():
	queue_free()
