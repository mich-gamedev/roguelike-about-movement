extends Marker2D
class_name GunPivot

@export var flip_actor: Node2D
@export var carrier: CharacterBody2D
@export var await_fire := true
var target_vector: Vector2
var recoil: float

var carried_guns: Array = []
var gun_index: int = 0
var picked_gun: FireBullet
var ready_to_fire: bool = true
var current_index: int

signal current_gun_fired(direction: float)
signal new_gun_picked(gun: FireBullet, index: int)
signal gun_grabbed(gun: FireBullet, index: int)
signal gun_dropped(gun: FireBullet, index: int)

func _ready() -> void:
	for i in get_children():
		if i is FireBullet:
			carried_guns.append(i)
	if await_fire:
		new_gun_picked.connect(_on_gun_swapped)

func _process(_delta: float) -> void:
	gun_index = wrap(gun_index, 0, carried_guns.size())
	picked_gun = carried_guns[gun_index]
	for gun in carried_guns:
		if gun == picked_gun:
			gun.show()
		else:
			gun.hide()

	if current_index != gun_index:
		current_index = gun_index
		new_gun_picked.emit(carried_guns[gun_index], gun_index)
	
	var target_direction = snapped(position.angle_to_point(target_vector), picked_gun.snap_angle)
	if flip_actor:
		if Vector2.from_angle(rotation).x > 0:
			scale.y = 1
			rotation = lerp_angle(rotation, target_direction - deg_to_rad(recoil), 0.5)
		else:
			scale.y = -1
			rotation = lerp_angle(rotation, target_direction + deg_to_rad(recoil), 0.5)
	else:
		rotation = lerp_angle(rotation, target_direction + deg_to_rad(recoil), 0.5)

func fire_current_gun(direction: float):
	if ready_to_fire:
		picked_gun.fire_bullet(direction)

func bullet_recoil():
	recoil = picked_gun.recoil
	var recoil_tween: Tween = get_tree().create_tween()
	recoil_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	recoil_tween.tween_property(self, "recoil", 0, picked_gun.cooldown)

func _on_child_entered_tree(node: Node) -> void:
	if node is FireBullet:
		node.connect("bullet_fired", bullet_recoil)
		gun_grabbed.emit()

	carried_guns.clear()
	for i in get_children():
		if i is FireBullet:
			carried_guns.append(i)

func _on_gun_swapped(_gun: FireBullet, _index: int) -> void:
	print("gun swapped")
	if ready_to_fire == true:
		ready_to_fire = false
		await get_tree().create_timer(picked_gun.cooldown / 2).timeout
		ready_to_fire = true
