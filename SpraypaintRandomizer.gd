extends GPUParticles2D
@export var options: Array[Color]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true
	modulate = options.pick_random()
