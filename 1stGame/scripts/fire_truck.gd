extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var projectile = load("res://nodes/projectile.tscn")
var hp = 600;
var isIn = false;
var isBurning = false;
var timer = Timer.new();
var speed = 150;
var playerIn = false
var attackPlayer = false
var attackTimer = 0;
var attackWaitTime = 0.15;
onready var trees = get_parent().find_node("trees").get_children();
var theTree;
var moving = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.wait_time = 0.05
	timer.connect("timeout", self, "timeout")
	trees.sort_custom(self,"closestTree")
	findBurning(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attackTimer += delta
	if playerIn:
		if(position.distance_to(get_parent().find_node("player").position) > 30):
			move_and_slide((get_parent().find_node("player").position - position).normalized()*speed)
	elif is_instance_valid(theTree) && theTree.isBurning:
		if(position.distance_to(theTree.position) > 3):
				move_and_slide((theTree.position - position).normalized()*speed)
	else:
		trees = get_parent().find_node("trees").get_children()
		trees.sort_custom(self,"closestTree")
		findBurning(0)
	if attackPlayer && attackTimer > attackWaitTime:
		attackTimer = 0
		attack()
	if hp <= 0:
		queue_free()
	if Input.is_action_just_pressed("action") && isIn:
		isBurning = true
		$AnimationPlayer.play("burning")
		timer.stop()
		timer.start()


func _on_vision_entered(body):
	if body.name == "player":
		playerIn = true


func _on_vision_exited(body):
	if body.name == "player":
		playerIn = false

func findBurning(b):
	if trees[b].isBurning:
		theTree = trees[b]
	elif trees.size()-1 > b:
		findBurning(b+1)
func closestTree(b,a):
	return position.distance_to(a.position) -position.distance_to(b.position) > 0


func _on_attack_entered(body):
	if body.name == "player":
		attackPlayer = true


func _on_attack_exited(body):
	if body.name == "player":
		attackPlayer = false

func attack():
	var r = RandomNumberGenerator.new()
	var instance = projectile.instance()
	r.randomize()
	instance.position = position
	instance.direction = (get_parent().find_node("player").position -position + Vector2(r.randf_range(-10,10),r.randf_range(-10,10))).normalized()
	get_parent().add_child(instance)

func timeout():
	if isBurning:
		hp-=1


func _on_fire_truck_entered(area):
	if area.name == "player":
		isIn = true


func _on_fire_truck_exited(area):
	if area.name == "player":
		isIn = false
