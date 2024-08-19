class_name PlayerState extends State

const Standing = "Standing"
const Crouching = "Crouching"
const Proning = "Proning"

<<<<<<< HEAD
var crouching : bool = true 
var proning : bool = true 

@export var player: PlayerCharacter

func _ready() -> void:
	await owner.ready
	player = owner as PlayerCharacter    
	print("owner: ", owner)
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	
	if player == null:
		print("Player is null")
	else:
		print("Player is initialized")
=======

var crouching : bool = false  # Set default to false
var proning : bool = false 

var player: CharacterBody3D

func _ready() -> void:
	await owner.ready
	player = owner as CharacterBody3D    
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
>>>>>>> f19b1fbe91b7d47950f84f4253c45acf63007c07
