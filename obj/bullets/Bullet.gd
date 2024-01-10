@icon("res://icons/bullet_class.svg")
extends CharacterBody2D
class_name Bullet
@export var screen_delete_actor: VisibleOnScreenNotifier2D

func _ready() -> void:
	screen_delete_actor.connect("screen_exited", off_screen_delete)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func off_screen_delete():
	queue_free()
