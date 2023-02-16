extends Node2D

const WIDTH = 5
const HEIGHT = 5
const SOCKET_SIZE = 50

var runes = []
var __socketGrid = []
var __runeGrid = []
var runeBlueprint = load("res://Runes/RuneBlueprint.tscn")
var runeSocket = load("res://Runes/RuneSocket.tscn")

var windOut = load("res://Runes/WindOutRune.tscn")
var pipe = load("res://Runes/Pipe.tscn")
var settingSocket: bool = false
var runeHoverd: Node2D = null

func _ready():
	for x in range(WIDTH):
		__socketGrid.append([])
		__socketGrid[x].resize(HEIGHT)
		
		__runeGrid.append([])
		__runeGrid[x].resize(HEIGHT)
		
		for y in range(HEIGHT):
			var socket: RuneSocket = runeSocket.instance()
			socket.index = Vector2(x, y)
			socket.runeGrid = self
			$SocketGroup.add_child(socket)
			__socketGrid[x][y] = socket
			
			socket.position = indexToPos(Vector2(x, y))

	#var emitter = EmitterRune.new()
	#var pipe = PipeRune.new()
	#emitter.addRune(pipe,pipe,pipe,pipe)
	#add_child(emitter)
	#add_child(pipe)
	
	pass

func _unhandled_input(event):
	if settingSocket && event.is_action("rotateRune") && event.is_pressed():
		print("rotate")
		runeHoverd.rotation_degrees += 90
		print(runeHoverd.rotation_degrees as int % 360)



func socketSelected(index: Vector2):
	print("asd")
	var globalPosition = to_global(indexToPos(index))
	$SelectRune.show_runes(globalPosition, runes)
	settingSocket = true
	"""print("Socket sel" + str(index))
	runeHoverd = windOut.instance()
	runeHoverd.position = indexToPos(index)
	__runeGrid[index.x][index.y] = runeHoverd
	$RuneGroup.add_child(runeHoverd)"""
	pass

func showSelectRune():
	
	pass
func hideSelectRune():
	$SelectRune.hide()
	pass
	
# warning-ignore:unused_argument
func placeRune(index: Vector2):
	print(index)
	#__runeGrid[index.x][index.y] = 
	pass

func indexToPos(indexVector: Vector2) -> Vector2:
	return Vector2(indexVector.x * SOCKET_SIZE, indexVector.y * SOCKET_SIZE)
