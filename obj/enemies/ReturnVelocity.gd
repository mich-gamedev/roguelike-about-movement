extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if !actor is CharacterBody2D: return FAILURE

	actor.velocity.x = move_toward(actor.velocity.x, 0.0, blackboard.get_value("acceleration"))
	if actor.velocity.x == 0: return SUCCESS
	
	actor.move_and_slide()
	return RUNNING

