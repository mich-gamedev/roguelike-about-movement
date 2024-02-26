extends Area2D
@onready var left_wall: CollisionShape2D = $"../LeftWall"
@onready var right_wall: CollisionShape2D = $"../RightWall"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		left_wall.set_deferred("disabled", false)
		right_wall.set_deferred("disabled", false)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		left_wall.set_deferred("disabled", true)
		right_wall.set_deferred("disabled", true)
