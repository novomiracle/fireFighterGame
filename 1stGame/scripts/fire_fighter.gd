extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isIn = false
var speed = 70;
var hp = 350
var isBurning = false
var timer = Timer.new()
onready var trees = get_parent().find_node("trees").get_children()
onready var puddles = get_parent().find_node("puddles").get_children()
var theTree;
# Called when the node enters the scene tree for the first time.
func _ready():
	trees.sort_custom(self,"closestTree")
	findBurning(0)
	add_child(timer)
	timer.wait_time = 0.05
	timer.connect("timeout", self, "timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func closestTree(b,a):
	return position.distance_to(a.position) -position.distance_to(b.position) > 0

func _process(delta):
	if Input.is_action_just_pressed("action") && isIn:
		isBurning = true
		$AnimationPlayer.play("burning")
		timer.stop()
		timer.start()
	if hp <= 0:
		queue_free()
	if isBurning:
		puddles.sort_custom(self,"findPuddle")
		move_and_slide((puddles[0].position- position).normalized()*speed)
	else:
		if(is_instance_valid(theTree) && theTree.isBurning):
			if(position.distance_to(theTree.position) > 3):
				move_and_slide((theTree.position - position).normalized()*speed)
		else:
			if(position.distance_to(get_parent().find_node("player").position) > 70):
				move_and_slide((get_parent().find_node("player").position - position).normalized()*speed)
			trees = get_parent().find_node("trees").get_children()
			trees.sort_custom(self,"closestTree")
			findBurning(0)


func _on_entered(area):
	if area.name =="player":
		isIn = true
	if area.name =="puddle":
		isBurning = false
		$AnimationPlayer.play("idle")
	

func _on_exited(area):
	if area.name =="player":
		isIn = false

func timeout():
	if isBurning:
		hp-=1
func findBurning(b):
	if trees.size() > 0:
		if trees[b].isBurning:
			theTree = trees[b]
		elif trees.size()-1 > b:
			findBurning(b+1)

func findPuddle(b,a):
	return position.distance_to(a.position) > position.distance_to(b.position)
