extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("Entered Proning state")
	player.animation_player.play("STANDPRONE", -1, player.animation_speed)
	proning = true  # Set the proning flag to true

func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("prone_or_unprone"):
		proning = false
		finished.emit(Standing)  # Transition to Standing if the action is pressed
