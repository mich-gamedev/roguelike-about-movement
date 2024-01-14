extends CharacterBody2D

@export_group("Horizontal Movement")
@export var speed: int = 240
@export var ground_friction: int = 15000
@export_group("Vertical Movement")
@export var floor_jump_speed: int = 400
@export var gravity: int = 1500
@export var terminal_velocity: int = 750
@export_group("BG sliding")
@export var sliding_speed: int = 50
@export var air_jump_speed: int = 480
@export_group("Air movement")
@export var air_friction: int = 1600

@onready var slide_collider: Area2D = $SlidingWallCollider
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var gun_pivot: GunPivot = $GunContainer


var friction: float
var max_falling_speed : float
var can_wall_jump : bool = false

func _process(delta: float) -> void:
	input_control(delta)
	
	environment_control(delta)
	
	if velocity:
		particles.emitting = true
	else:
		particles.emitting = false
	
	gun_pivot.target_vector = get_local_mouse_position()
	
	if Input.is_action_pressed("fire"):
		gun_pivot.picked_gun.fire_bullet(gun_pivot.rotation)
	
	PlayerStats.pos = position
	PlayerStats.vel = velocity
	PlayerStats.hp = $Health.health
	PlayerStats.max_hp = $Health.max_health
	
	move_and_slide()

func _on_sliding_wall_entered(_body: Node2D) -> void:
	can_wall_jump = true
func _on_sliding_wall_exited(_body: Node2D) -> void:
	can_wall_jump = false

func input_control(delta: float) -> void:
	var input_axis: float = Input.get_axis("move_left", "move_right")
	if input_axis:
		velocity.x = move_toward(velocity.x, input_axis * speed, friction * delta)
		var flip_tween: Tween = get_tree().create_tween()
		flip_tween.tween_property(anim, "scale", Vector2(input_axis, 1), 0.1)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -floor_jump_speed
		elif can_wall_jump and (max_falling_speed == sliding_speed):
			velocity.y = -air_jump_speed
			can_wall_jump = false
	
	if Input.is_action_just_pressed("next_item"):
		gun_pivot.gun_index += 1
		print(wrap(gun_pivot.gun_index, 0, gun_pivot.carried_guns.size()))
	if Input.is_action_just_pressed("previous_item"):
		gun_pivot.gun_index -= 1
		print(wrap(gun_pivot.gun_index, 0, gun_pivot.carried_guns.size()))
func environment_control(delta: float) -> void:
	if is_on_floor():
		friction = ground_friction
		can_wall_jump = true
		if velocity == Vector2.ZERO:
			anim.play("Idle")
		else:
			anim.play("Run")
	else:
		friction = air_friction
		velocity.y = move_toward(velocity.y, max_falling_speed, gravity * delta)
		if velocity.y < 0:
			anim.play("Jump")
		if velocity.y >= 0:
			anim.play("Fall")
	
	if Input.is_action_pressed("slide") and slide_collider.get_overlapping_bodies():
		max_falling_speed = sliding_speed
		anim.play("BG Slide")
	else:
		max_falling_speed = terminal_velocity
	
	if Input.is_action_just_pressed("slide"):
		can_wall_jump = true
