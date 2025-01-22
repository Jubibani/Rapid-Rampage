class_name CharacterPlayer extends CharacterBody3D

@export var animation_player : AnimationPlayer
@export_range(5.0, 5.0, 10.0)var animation_speed = 5.0
var SPEED = walking_speed

var is_running : bool = false
var is_crouching : bool = false

const running_speed = 10.0
const walking_speed = 5.5
const crouching_speed = 2.5
const proning_speed = 2.0
const JUMP_VELOCITY = 4.5

#head bobbing
const bob_frequency = 2.0
const bob_amplitude = 0.08
var t_bob = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 
func _input(event):
	
		
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

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		
	#head bobbing
	t_bob += delta * velocity.length() * float(is_on_floor())
	$head.transform.origin = _headbob(t_bob)
	
	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_frequency) * bob_amplitude
	return pos
