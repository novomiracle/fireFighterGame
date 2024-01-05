extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxHp = 1500
var hp = maxHp
var isIn = false
var isBurning = false
var stage = -1
onready var wave = get_parent().find_node("wave_points").wave
var timer = Timer.new()
var r =RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.wait_time = 0.05
	timer.connect("timeout",self,"timeout")
	timer.start()
	r.randomize()
	position = Vector2(r.randi_range(50,600),r.randi_range(300,30))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isIn && Input.is_action_just_pressed("action") && stage >= 3:
		isBurning = true
	if !isBurning && stage >= 0:
		$AnimationPlayer.play(str(floor(stage)))
	elif isBurning:
		$AnimationPlayer.play("burning")
	if hp <= 0:
		hp = maxHp
		stage = 0
		$AnimationPlayer.play(str(floor(stage)))
		position = Vector2(r.randi_range(50,600),r.randi_range(300,30))
		isBurning = false
	wave = get_parent().find_node("wave_points").wave
	if wave >= 3 && stage < 0:
		stage = 0

func _on_hitbox_entered(area):
	if area.name == "player" :
		isIn = true
	if area.get_parent().is_in_group("constion_workers") && stage < 3:
		stage += 0.5

func _on_hitbox_exited(area):
	if area.name == "player" :
		isIn = false

func timeout():
	for i in $range.get_overlapping_bodies():
		if stage == 2 && i.name == "player":
			i.hp -= 0.1
		elif stage > 2 && i.name == "player":
			i.hp -= 0.2
	if isBurning:
		hp -= 1
