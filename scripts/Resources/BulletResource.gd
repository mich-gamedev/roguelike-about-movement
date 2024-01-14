@icon("res://icons/bullet_class.svg")
extends Resource
class_name BulletResource
@export_group("Sprite")
@export var texture: SpriteFrames
@export var rotate_bullet: bool = false
@export var delete_radius:= Vector2(32,32)
@export_group("Bullet Properties")
@export var properties: Array[BulletProperty] = []
@export var damage: int
@export var speed: float
@export_group("Collisions")
@export_flags_2d_physics var layer: int
@export_flags_2d_physics var mask: int
@export var collider:= Rect2(Vector2(-3, -3), Vector2(6,6))

var bullet_scene: PackedScene = preload("res://obj/bullets/player_bullet.tscn")

func instantiate_bullet():
	var new_bullet = bullet_scene.instantiate()
	if new_bullet is Bullet:
		return new_bullet
	else: 
		return
