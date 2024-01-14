@icon("res://icons/bullet_class.svg")
extends CharacterBody2D
class_name Bullet
@onready var sprite = $AnimatedSprite2D
@onready var hurtbox = $Area2D
@onready var area_collider = $Area2D/CollisionShape2D
@onready var screen_delete_actor = $VisibleOnScreenNotifier2D


func _ready() -> void:
	screen_delete_actor.connect("screen_exited", _off_screen_delete)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func _off_screen_delete():
	queue_free()
