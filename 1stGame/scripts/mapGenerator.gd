extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var trees;
onready var tree = preload("res://nodes/tree.tscn")
var rng = RandomNumberGenerator.new();
var burningTrees = 0 
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in 75:
		var instanceTree = tree.instance()
		instanceTree.position = Vector2(rng.randi_range(-205,950),rng.randi_range(-50,540))
		add_child(instanceTree)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	trees = get_tree().get_nodes_in_group("trees")
	if(get_tree().get_nodes_in_group("trees").size() == 0):
		var scene = load("res://nodes/winScreen.tscn").instance()
		get_tree().root.remove_child(get_parent())
		get_tree().root.add_child(scene)
