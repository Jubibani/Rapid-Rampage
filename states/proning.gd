extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
	print("Proning")

func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("prone_or_unprone"):
		finished.emit(Standing)  # Assuming a transition back to Standing
