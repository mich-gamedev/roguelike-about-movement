extends ActionLeaf

@export var speed: float = 360.0

var delta_time: float

func _process(delta: float) -> void:
	delta_time = delta

func tick(actor: Node, blackboard: Blackboard) -> int:
	if !actor is CharacterBody2D: return FAILURE

	var targets = get_tree().get_nodes_in_group(blackboard.get_value("target"))
	targets.sort_custom(func(a, b): return actor.global_position - a.global_position > actor.global_position - b.global_position)
	blackboard.set_value("targets", targets)

	var direction = Util.get_bool_axis(actor.to_local(blackboard.get_value("targets")[0].global_position) > 0)
	actor.velocity = actor.velocity.move_toward(direction * speed, blackboard.get_value("acceleration") * delta_time)

	actor.move_and_slide()
	return RUNNING
