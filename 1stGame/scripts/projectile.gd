extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction;
var speed = 300;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(direction * speed)


func _on_body_entered(body):
	if !body.is_in_group("fire_trucks"):
		queue_free()
