extends CharacterBody2D
class_name Tire

@export var speed: float = 300
@export var acceleration: float = 200

@onready var area: Area2D = $Area2D
@onready var ray_cast: RayCast2D = $RayCast2D

var body_positions: Array[Vector2] = []
var nearest_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	body_positions.clear()
	for body in area.get_overlapping_bodies():
		if (body is CharacterBody2D) and (!body is Tire):
			body_positions.append(body.global_position)
