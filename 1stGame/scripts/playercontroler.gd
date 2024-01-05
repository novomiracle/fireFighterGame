extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2();
var speed = 200;
var hp = 200.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	move_and_slide(velocity.normalized()*speed)
	$CollisionShape2D.scale = Vector2(max(min(2,hp/100),0.5),max(min(2,hp/100),0.5))
	$FirePlayer.scale = Vector2(max(min(2,hp/100),0.5),max(min(2,hp/100),0.5))
	if hp <= 0:
		var scene = load("res://nodes/loseScreen.tscn").instance()
		#get_tree().root.remove_child(get_parent())
		get_tree().root.get_child(1).get_node("Game").queue_free()
		Global.playing = false
		get_tree().root.add_child(scene)


func _on_player_entered(area):
	if area.name == "projectile":
		hp -= 1
