extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var trees = get_parent().get_parent().get_node("trees").get_child_count()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = str(Global.score)
