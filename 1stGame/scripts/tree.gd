extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isIn = false
var fIsIn = false
var isBurning = false
var hp = 150
var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.wait_time = 0.05
	timer.connect("timeout", self, "timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func timeout():
	if isBurning:
		hp-=1
	#elif hp < 150:
	#	hp+=1

func _process(delta):
	if Input.is_action_just_pressed("action") && isIn:
		isBurning = true
		$AnimationPlayer.play("burning")
		timer.stop()
		timer.start()
	if fIsIn:
		isBurning = false
		$AnimationPlayer.play("idle")
		timer.stop()
		timer.start()
	if hp <= 0:
		get_parent().get_parent().get_node("player").hp+= 1
		queue_free()


func _on_enter(area):
	if area.name =="player":
		isIn = true
	if area.name =="fire_fighter":
		fIsIn = true

func _on_exit(area):
	if area.name =="player":
		isIn = false
	if area.name =="fire_fighter":
		fIsIn = false
