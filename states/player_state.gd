class_name PlayerState extends State


#this will serve as a reference
const Standing = "Standing"
const Crouching = "Crouching"
const Proning = "Proning"

var crouching : bool = false
var proning : bool = false

var CharacterPlayer : CharacterBody3D

func _ready() -> void:
	await owner.ready
	CharacterPlayer = owner as CharacterBody3D    
	assert(CharacterPlayer != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
