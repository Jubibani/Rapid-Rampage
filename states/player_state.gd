class_name PlayerState extends State


#this will serve as a reference
const Standing = "Standing"
const Crouching = "Crouching"
const Proning = "Proning"

var is_crouching : bool = false

var player: CharacterBody3D

func _ready() -> void:
	await owner.ready
	player = owner as CharacterBody3D    
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
