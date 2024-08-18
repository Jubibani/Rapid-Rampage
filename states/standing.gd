extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("Entered Standing state")


func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("crouch_or_uncrouch") and is_crouching:
		finished.emit(Standing)
		
