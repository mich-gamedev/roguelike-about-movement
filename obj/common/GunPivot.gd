extends Marker2D
class_name GunPivot

@export var flip_actor: Node2D
var target_vector: Vector2
var recoil: float

var carried_guns: Array = []
var gun_index: int = 0
var picked_gun: FireBullet

func _process(_delta: float) -> void:
	carried_guns.clear()
	for i in get_children():
		if i is FireBullet:
			carried_guns.append(i)
	picked_gun = carried_guns[gun_index]
	
	
	var target_direction = snapped(position.angle_to_point(target_vector), picked_gun.snap_angle)
	if flip_actor:
		if Vector2.from_angle(rotation).x > 0:
			scale.y = 1
			rotation = target_direction - deg_to_rad(recoil)
		else:
			scale.y = -1
			rotation = target_direction + deg_to_rad(recoil)
	else:
		rotation = target_direction + deg_to_rad(recoil)

func bullet_recoil():
	recoil = picked_gun.recoil
	var recoil_tween: Tween = get_tree().create_tween()
	recoil_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	recoil_tween.tween_property(self, "recoil", 0, picked_gun.cooldown)

func _on_child_entered_tree(node: Node) -> void:
	if node is FireBullet:
		node.connect("bullet_fired", bullet_recoil)
