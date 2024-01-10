@icon("res://icons/fire_bullet_class.svg")
extends Sprite2D
class_name FireBullet


@export_group("Bullet Scenes")
@export var bullet: PackedScene
@export var particle: PackedScene

@export_group("Settings")
@export var rotate_bullet: bool = false
@export var do_physics_recoil: bool = true
@export_range(0,1, 0.01) var velocity_bonus: float = 0.25

@export_group("Gun Stats")
@export_range(0, 3, 0.01, "or_greater") var cooldown: float = 0.35
@export_range(0, 128, 0.5, "or_greater") var recoil: float = 25
@export_range(0,180, 0.1, "or_greater", "radians_as_degrees") var snap_angle: float

@export_group("Bullet Stats")
@export var damage: int
@export var speed: float

@export_group("Randomization")
@export_range(0,45,0.1,  "or_greater", "radians_as_degrees") var angle_variation: float
@export_range(0,300,0.1, "or_greater") var velocity_variation: float

@export_group("Multifire")
@export var amount: int = 1
@export_range(-180, 180, 0.1, "or_less", "or_greater", "radians_as_degrees") var field: float = 0.785398

@export_group("Actors")
@export var cooldown_timer: Timer

@onready var projectile_space: float = field / amount

signal bullet_fired
signal cooldown_timeout

func _ready() -> void:
	cooldown_timer.wait_time = cooldown
	print(projectile_space)
	
func fire_bullet(direction: float):
	print(get_carrier())
	if cooldown_timer.time_left == 0:
		if particle:
			var spawned_particle = particle.instantiate()
			add_child(spawned_particle)
		for i in range(amount):
			var spawned_bullet = bullet.instantiate()
			get_tree().root.add_child(spawned_bullet)
			spawned_bullet.global_position = global_position
			if spawned_bullet is CharacterBody2D:
				if amount > 1:
					var new_angle = direction + (i * projectile_space) - field / 2
					spawned_bullet.velocity = Vector2.from_angle(new_angle + randf_range(-angle_variation, angle_variation)) * (speed + randf_range(-velocity_variation, velocity_variation))
				else:
					spawned_bullet.velocity = Vector2.from_angle(direction) * speed
				spawned_bullet.velocity += get_carrier().velocity * velocity_bonus
		if do_physics_recoil:
			get_carrier().velocity += Vector2.from_angle(direction + PI) * Vector2(1,2) * (recoil*5)
		bullet_fired.emit()
		cooldown_timer.start()

func get_carrier() -> CharacterBody2D:
	if get_parent() is GunContainer:
		return get_parent().carrier
	else:
		print("Parent is not GunContainer")
		return
