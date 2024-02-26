extends ReferenceRect
class_name CameraRect

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	PlayerStats.cam_limits.position = global_position
	PlayerStats.cam_limits.size = size
