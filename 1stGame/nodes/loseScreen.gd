extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var arcade = load("res://nodes/arcade.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().root.add_child(arcade.instance())
	Global.score = 0
	Global.playing = true
	queue_free()
