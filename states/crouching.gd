extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:

	
	print("Crouch State: ", "crouching: %s, proning: %s" % [str(crouchingFromStand), str(proning)]) 
	
	if crouchingFromStand:
		CharacterPlayer.animation_player.play("CROUCHING", -1, CharacterPlayer.animation_speed)
		print("Entering Crouching State - ",  "crouching: %s, proning: %s" % [str(crouchingFromStand), str(proning)])
		
	elif crouchingFromProne and not proning:
		CharacterPlayer.animation_player.play("CrouchProne", -1, -CharacterPlayer.animation_speed, true)
		print("Transitioning from Prone to Crouch - ",  "crouching: %s, proning: %s" % [str(crouchingFromProne), str(proning)])
		
	crouchingFromProne = true
	crouchingFromStand = true
	proning = false

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") or Input.is_action_just_pressed("crouch_mobile_button"):
		print("Mobile button or key press detected [from crouch]")
		crouchingFromStand = true
		finished.emit(Standing)  # Transition back to standing
		Input.action_release("crouch_mobile_button")
		
	elif Input.is_action_just_pressed("prone_or_unprone") or Input.is_action_just_pressed("prone_mobile_button"):
		crouchingFromStand = false
		proning = true
		finished.emit(Proning)  # Transition to proning
		Input.action_release("prone_mobile_button")

## Mobile Button
func _on_crouch_pressed() -> void:
	Input.action_press("crouch_mobile_button")
	

func _on_prone_pressed() -> void:
	Input.action_press("prone_mobile_button")
