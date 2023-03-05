extends Node2D

const WIDTH = 5
const HEIGHT = 5
const SOCKET_SIZE = 50


var runes =  [load("res://Runes/WindOutRune.tscn"), load("res://Runes/Pipe.tscn"), load("res://Runes/CurveRune.tscn")]
var __socketGrid = []
var __runeGrid = []
var runeBlueprint = load("res://Runes/RuneBlueprint.tscn")
var runeSocket = load("res://Runes/RuneSocket.tscn")

var settingSocket: bool = false
var settingSocketIndex: Vector2 
var settingSocketRotation: int = 0

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
	pass

func _unhandled_input(event):
	if settingSocket && event.is_action("rotateRune") && event.is_pressed():
		print("rotate")
		settingSocketRotation = (settingSocketRotation + 1) % 4
	if settingSocket && event is InputEventKey && event.is_pressed():
		var newRune = null
		match event.scancode:
			KEY_1:
				print("key 1")
				newRune = runes[0].instance()
			KEY_2:
				print("key 2")
				newRune = runes[1].instance()
			KEY_3:
				newRune = runes[2].instance()
		if newRune != null && newRune.is_in_group("Rune"):
			newRune.setRuneGrid(self)
			newRune.setIndex(settingSocketIndex)
			newRune.setRuneRotation(settingSocketRotation % 4 as int)
			newRune.position = indexToPos(settingSocketIndex)
			if __runeGrid[settingSocketIndex.x][settingSocketIndex.y] != null:
				__runeGrid[settingSocketIndex.x][settingSocketIndex.y].queue_free()
				__runeGrid[settingSocketIndex.x][settingSocketIndex.y] = null
			__runeGrid[settingSocketIndex.x][settingSocketIndex.y] = newRune
			$RuneGroup.add_child(newRune)
			newRune.rotation_degrees = settingSocketRotation * 90
			settingSocket = false


func getRuneByIndex(index: Vector2):
	var validX = index.x >= 0 && index.x < __runeGrid.size()
	var validY = index.y >= 0 && index.y < __runeGrid[0].size()
	
	if validX && validY:
#		if __runeGrid[index.x][index.y] != null:
#			__runeGrid[index.x][index.y].queue_free()
#			__runeGrid[index.x][index.y] = null
		return __runeGrid[index.x][index.y]
	return null

func isRune(rune: Node2D) -> bool:
	return rune != null && rune.is_in_group("Rune")


func socketSelected(index: Vector2):
	settingSocketRotation = 0
	settingSocketIndex = index
	settingSocket = true


func indexToPos(indexVector: Vector2) -> Vector2:
	return Vector2(indexVector.x * SOCKET_SIZE, indexVector.y * SOCKET_SIZE)


func removeRune(index: Vector2):
	var validX = index.x >= 0 && index.x < __runeGrid.size()
	var validY = index.y >= 0 && index.y < __runeGrid[0].size()
	
	if validX && validY:
		__runeGrid[index.x][index.y] = null

