extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isIn = false
var isBurning = false
var timer = Timer.new()
var hp = 150
var speed = 30
onready var direction = (get_parent().find_node("fountain").position - position).normalized()
onready var puddles = get_parent().find_node("puddles").get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.wait_time = 0.05
	timer.connect("timeout",self,"timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isIn && Input.is_action_just_pressed("action"):
		isBurning = true
		timer.stop()
		timer.start()
	if isBurning:
		puddles.sort_custom(self,"findPuddle")
		move_and_slide((puddles[0].position- position).normalized()*speed)
		$AnimationPlayer.play("burning")
	else:
		$AnimationPlayer.play("idle")
		if position.distance_to(get_parent().find_node("fountain").position) > 30:
			direction = (get_parent().find_node("fountain").position - position).normalized()
			move_and_slide(direction*speed)


func _on_entered(area):
	if area.name == "puddle":
		isBurning = false
	if area.name == "player":
		isIn = true
	if area.name == "hitbox":
		queue_free()


func _on_exited(area):
	if area.name == "player":
		isIn = false

func timeout():
	if isBurning:
		hp-=1

func findPuddle(b,a):
	return position.distance_to(a.position) > position.distance_to(b.position)
