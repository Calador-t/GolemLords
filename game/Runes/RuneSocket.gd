extends Area2D

class_name RuneSocket

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var index = Vector2(-1,-1)
var runeGrid = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		if $SocketSprite.get_rect().has_point($SocketSprite.to_local(event.position)):
			if runeGrid != null && runeGrid.has_method("placeRune"):
				runeGrid.socketSelected(index)

			print('test')
			get_tree().set_input_as_handled() # if you 

#func _input(event):
#	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
#		if $SocketSprite.get_rect().has_point($SocketSprite.to_local(event.position)):
#			print("ladsfds")
#			#get_tree().set_input_as_handled()


# warning-ignore:unused_argument
func _on_RuneSocket_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("clicked: " + str(index.x) + "; " + str(index.y))
		if runeGrid != null:
			runeGrid.socketSelected(index)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
#	if getSpriteRect().has_point(get_local_mouse_position()):
#			print("in ")
#			pass
	pass
