extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _input(event):
#	if (event is InputEventMouseButton && event.pressed):
#		print("clickj")
#		pass
#func _unhandled_input(event):
#	if (event is InputEventMouseButton && event.pressed):
#		print("clickj")
#		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("clickj")
		pass
	pass # Replace with function body.
