extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("Entered Standing state")
	
	player.animation_player.play("CROUCHING", -1, -player.animation_speed, true)

	proning = false
	crouching = false  # Set crouching state to false

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") and not crouching:
		crouching = true
		finished.emit(Crouching)  # Transition to Crouching if the action is pressed
		
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		finished.emit(Proning)
