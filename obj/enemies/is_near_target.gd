extends ConditionLeaf 
class_name IsNearPlayer

@export var range: float = 128

func tick(actor: Node, blackboard: Blackboard) -> int:
	if !actor is Node2D: return FAILURE

	for i : Node2D in get_tree().get_nodes_in_group(blackboard.get_value("target")):
		if actor.global_position.distance_squared_to(i.global_position) <= range:
			return SUCCESS
	return FAILURE
