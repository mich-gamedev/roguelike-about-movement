@icon("res://icons/bullet_class.svg")
extends CharacterBody2D
class_name Bullet
@export var collision_particle: PackedScene

var bounces_left: int
var bounce_decay: float

func _physics_process(delta: float) -> void:
	var coll_info = move_and_collide(velocity * delta)
	if coll_info:
		velocity = velocity.bounce(coll_info.get_normal()) * bounce_decay

		if collision_particle:
			var new_particle = collision_particle.instantiate()
			get_tree().root.add_child(new_particle)
			new_particle.global_position = global_position - (velocity.normalized() * 3)

		if bounces_left == 0:
			queue_free()
		bounces_left -= 1

static func get_bullet(node: Node) -> Bullet:
	if node.get_parent() is Bullet:
		return node.get_parent()
	else:
		return
