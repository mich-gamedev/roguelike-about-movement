@icon("res://icons/bullet_class.svg")
extends Resource
class_name BulletResource
@export_group("Sprite")
@export var texture: SpriteFrames = load("res://obj/bullets/player_bullet.tres")
@export var rotate_bullet: bool = false
@export var delete_radius:= Vector2(32,32)

@export_group("Bullet Properties")
@export var damage: int = 1
@export var speed: float = 600
@export var bounces: int = 0
@export_range(0,1) var bounce_decay: float = 1

@export_group("Collisions")
@export_flags_2d_physics var layer: int
@export_flags_2d_physics var mask: int
@export var collider:= Rect2(Vector2(-3, -3), Vector2(6,6))

@export_group("Special Bullets")
@export var specials: Array[BulletProperty] = []
@export var bullet_scene: PackedScene = preload("res://obj/bullets/player_bullet.tscn")

func instantiate_bullet():
	var new_bullet = bullet_scene.instantiate()
	if new_bullet is Bullet:
		return new_bullet
	else: 
		return
