extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wave = 1
var timer = Timer.new()
onready var fire_fighter = load("res://nodes/fire_fighter.tscn")
onready var fire_truck = load("res://nodes/fire_truck.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.start()
	timer.wait_time = 60
	timer.connect("timeout", self, "timeout")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func timeout():
	for i in get_children():
		if i != timer:
			var instance = fire_fighter.instance()
			instance.position = Vector2(i.position.x + rand_range(-5, 5),i.position.y + rand_range(-5, 5))
			get_parent().add_child(instance)
	for i in wave:
		var instance = fire_truck.instance()
		var r = RandomNumberGenerator.new()
		r.randomize()
		var station = get_child(r.randi_range(0,4))
		instance.position = Vector2(station.position.x + rand_range(-5, 5),station.position.y + rand_range(-5, 5))
		get_parent().add_child(instance)
	wave += 1
