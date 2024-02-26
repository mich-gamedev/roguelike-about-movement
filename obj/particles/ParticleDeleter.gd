extends Node
class_name ParticleDeleter

@export var particle: GPUParticles2D
@export var actor: Node

func _ready() -> void:
	await get_tree().create_timer(particle.lifetime + 1.0).timeout
	actor.queue_free()
