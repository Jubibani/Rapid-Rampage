class_name CharacterPlayer extends CharacterBody3D

@export var animation_player: AnimationPlayer
@export_range(5.0, 10.0) var animation_speed = 5.0

enum State {STANDING, CROUCHING, PRONE}
var current_state = State.STANDING

var SPEED = walking_speed

var is_running : bool = false
var is_crouching : bool = false
var is_proning : bool = false

const proning_speed = 1.8
const crouching_speed = 2.3
const walking_speed = 5.5
const running_speed = 12.5
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _input(event):
	#if Input.is_action_just_pressed("crouch") and is_on_floor():
		#state_machine
		#match current_state:
			#State.STANDING:
				#_crouch()
			#State.CROUCHING:
				#_prone() # Changed from _uncrouch()
			#State.PRONE:
				#_uncrouch() s# Added

	if Input.is_action_just_pressed("prone") and is_on_floor():
		match current_state:
			State.STANDING:
				_prone()
			State.CROUCHING:
				_uncrouch() # Added
			State.PRONE:
				_crouch() # Added

	if Input.is_action_just_pressed("run") and is_on_floor():
		if current_state == State.STANDING:
			SPEED = running_speed
		else:
			SPEED = walking_speed

	if event is InputEventScreenDrag:
		var look_sensitivity = 0.5
		rotate_y(deg_to_rad(-event.relative.x * look_sensitivity))
		$head.rotate_x(deg_to_rad(-event.relative.y * look_sensitivity))

		var head_rotation = $head.rotation_degrees
		head_rotation.x -= event.relative.y * look_sensitivity
		head_rotation.x = clamp(head_rotation.x, -90, 90)
		$head.rotation_degrees = head_rotation

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Adjust movement speed based on current state
	match current_state:
		State.STANDING:
			SPEED = walking_speed
		State.CROUCHING:
			SPEED = crouching_speed
		State.PRONE:
			SPEED = proning_speed

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _crouch():
	if current_state == State.STANDING:
		current_state = State.CROUCHING
		animation_player.play("CROUCHING", -1, animation_speed)
	elif current_state == State.PRONE: # Added
		current_state = State.CROUCHING
		animation_player.play("ProneToStand", -1, animation_speed) # Changed animation name
		# Adjust collider size and position

func _uncrouch():
	if current_state == State.CROUCHING:
		current_state = State.STANDING
		animation_player.play("CROUCHING", -1, -animation_speed, true)
	elif current_state == State.PRONE: # Added
		current_state = State.STANDING
		animation_player.play("ProneToStand", -1, -animation_speed, true) # Changed animation name
		# Restore collider size and position

func _prone():
	if current_state == State.STANDING:
		current_state = State.PRONE
		animation_player.play("StandProne", -1, animation_speed)
	elif current_state == State.CROUCHING: # Added
		current_state = State.PRONE
		animation_player.play("CrouchProne", -1, animation_speed) # Changed animation name
		# Adjust collider size and position

func _unprone():
	if current_state == State.PRONE:
		current_state = State.STANDING
		animation_player.play("StandProne", -1, -animation_speed, true)
	elif current_state == State.CROUCHING: # Added
		current_state = State.STANDING
		animation_player.play("CrouchProne", -1, -animation_speed, true) # Changed animation name

func _run():
	if !is_crouching:
		if !is_running:
			SPEED = running_speed
			print("running at the speed of: ", SPEED)
		elif is_crouching:
			SPEED = crouching_speed
		elif is_running:
			SPEED = walking_speed
			print("walking at the speed of: ", SPEED)
	elif SPEED == walking_speed:
		SPEED = running_speed
		print("running at the speed of: ", SPEED)	
	else:
		SPEED = walking_speed
		print("from run(), and walking at the speed of: ", SPEED)	


func _on_jump_pressed():
	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("jumped")


func _on_run_pressed():
	if !is_crouching and is_on_floor():
		_run()
	is_running = !is_running

func _on_crouch_pressed():
	if !is_crouching:
		_crouch()
	else:
		_uncrouch()
	is_crouching = !is_crouching
