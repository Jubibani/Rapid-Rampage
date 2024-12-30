extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if CharacterPlayer.is_on_wall():
		CharacterPlayer.velocity.x = CharacterPlayer.JUMP_VELOCITY

		print("Wall jump! Velocity: ", CharacterPlayer.velocity)
	else:
		# Regular jump
		CharacterPlayer.velocity.y = CharacterPlayer.JUMP_VELOCITY
		print("Regular jump")
		
	#!release the buttons pressed
	Input.action_release("crouch_or_uncrouch")
	Input.action_release("prone_or_unprone")
	Input.action_release("run")
	Input.action_release("Jump")

const WALL_BOUNCE_BOOST := 50000  # Adjust for stronger horizontal boost


func physics_update(_delta: float) -> void:
	# Check if player is on the wall and presses Jump
	if not CharacterPlayer.is_on_floor() and Input.is_action_just_pressed("Jump"):
		if CharacterPlayer.is_on_wall():
			var collision = CharacterPlayer.get_last_slide_collision()
			if collision:
				# Get the wall's normal direction
				var wall_normal = collision.get_normal()

				# Ensure the normal is valid
				if wall_normal.length() > 0:
					# Push player horizontally away from the wall
					CharacterPlayer.velocity.x = -wall_normal.x * WALL_BOUNCE_BOOST
					CharacterPlayer.velocity.z = -wall_normal.z * WALL_BOUNCE_BOOST  # For 3D cases
					print("Wall Bounce! Normal: ", wall_normal, " Velocity: ", CharacterPlayer.velocity)

					# Release the jump action to avoid repeated triggering
					Input.action_release("Jump")
					return


	# Regular jump when on the floor
	if CharacterPlayer.is_on_floor() and Input.is_action_just_pressed("Jump"):
		CharacterPlayer.velocity.y = CharacterPlayer.JUMP_VELOCITY
		print("Regular Jump")
		Input.action_release("Jump")

	
	
	if CharacterPlayer.is_on_floor():
		if Input.is_action_just_pressed("crouch_or_uncrouch"):
			crouchingFromStand = true
			finished.emit(StandCrouching)
			Input.action_release("crouch_or_uncrouch")
	
		
		if Input.is_action_just_pressed("prone_or_unprone"):
			proning = true
			finished.emit(Proning) 
			Input.action_release("prone_or_unprone")
		
			
		if Input.is_action_just_pressed("run"):
			finished.emit(Standing)
			Input.action_release("run")

			
			
		if Input.is_action_just_pressed("Jump") and CharacterPlayer.is_on_floor():
			finished.emit(Jumping)
			Input.action_release("Jump")
			
			
	
	#! this is to release these pressed buttons when pressed midair
	Input.action_release("run")	
	Input.action_release("Jump")
			





func _on_run_pressed() -> void:
	Input.action_press("run")


func _on_jump_pressed() -> void:
	Input.action_press("Jump")


func _on_crouch_pressed() -> void:
	Input.action_press("crouch_or_uncrouch")


func _on_prone_pressed() -> void:
	Input.action_release("prone_or_unprone")
