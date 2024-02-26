extends Node
class_name ParticleOneShot

@export var particle: GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particle.emitting = true
