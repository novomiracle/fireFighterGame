extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var puddle = preload("res://nodes/puddle.tscn")
var rng = RandomNumberGenerator.new();
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in 10:
		var instancePuddle = puddle.instance()
		instancePuddle.position = Vector2(rng.randi_range(-205,950),rng.randi_range(-50,540))
		add_child(instancePuddle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
