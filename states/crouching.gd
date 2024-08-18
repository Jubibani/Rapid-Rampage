extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("Entered Crouching state")


func physics_update(_delta: float) -> void:
	if Input.is_action_pressed("crouch_or_uncrouch"):
		finished.emit(Standing)
		is_crouching = false
