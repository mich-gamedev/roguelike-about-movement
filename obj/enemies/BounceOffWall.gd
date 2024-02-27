extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	if !actor is CharacterBody2D: return FAILURE
	
	var targets = get_tree().get_nodes_in_group(blackboard.get_value("target"))
	targets.sort_custom(func(a, b): return actor.global_position - a.global_position > actor.global_position - b.global_position)

	actor.velocity = (actor.global_position - targets[0].global_position).normalized() * actor.velocity.length()
	
	return RUNNING

