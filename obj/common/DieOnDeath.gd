extends Node
class_name DeleteOnDeath

@export var health_actor: Health
@export_range(0,5,0.01, "or_greater", "suffix:s") var delay: float
@export var particles: PackedScene

func _ready() -> void:
	health_actor.died.connect(delete_owner)


func delete_owner():
	if delay > 0:
		await get_tree().create_timer(delay).timeout
	if particles:
		var spawned_particles: Node2D = particles.instantiate()
		get_tree().root.add_child(spawned_particles)
		spawned_particles.position = owner.global_position
	owner.queue_free()
