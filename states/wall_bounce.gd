extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
		print("wallbounce")
		wall_bounce()


func physics_update(_delta: float) -> void:
	finished.emit(Standing)
			
	#! this is to release these pressed buttons when pressed midair
	Input.action_release("run")	
	Input.action_release("Jump")
			


#feature movement
func wall_bounce():
	#if CharacterPlayer.is_on_wall():
	CharacterPlayer.last_wall_normal = CharacterPlayer.get_wall_normal()  # Get direction of the wall
	print("Wall Bounce Normal: ", CharacterPlayer.last_wall_normal)  # Debugging

	# Remove vertical component of the normal (prevents bouncing upwards)
	CharacterPlayer.last_wall_normal.y = 0
	CharacterPlayer.last_wall_normal = CharacterPlayer.last_wall_normal.normalized()

	# Apply bounce force in the wall's normal direction + some forward movement
	CharacterPlayer.velocity = (CharacterPlayer.last_wall_normal * CharacterPlayer.wall_bounce_multiplier * CharacterPlayer.SPEED) + Vector3(0, CharacterPlayer.wall_boost, 0)
	CharacterPlayer.is_wall_bouncing = true
	

	
