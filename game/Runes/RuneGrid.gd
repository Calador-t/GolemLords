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
		settingSocketRotation += 90
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
		if newRune != null:
			addAdjectedRunes(newRune, settingSocketRotation, settingSocketIndex)
			updateAdjectedRunes(newRune, settingSocketIndex)
			newRune.position = indexToPos(settingSocketIndex)
			if __runeGrid[settingSocketIndex.x][settingSocketIndex.y] != null:
				__runeGrid[settingSocketIndex.x][settingSocketIndex.y].queue_free()
			__runeGrid[settingSocketIndex.x][settingSocketIndex.y] = newRune
			$RuneGroup.add_child(newRune)
			newRune.rotation_degrees = settingSocketRotation
			settingSocket = false

func addAdjectedRunes(rune, rotation: int, index: Vector2):
	if isRune(rune):
		var topRune = getTopRuneSafe(index)
		var bottomRune = getBottomRuneSafe(index)
		var leftRune = getLeftRuneSafe(index)
		var rightRune = getRightRuneSafe(index)
		
		var rotate: int = rotation % 360 / 90 as int
		rune.setRuneRotation(rotate)
		rune.setTopRune(topRune)
		rune.setBottomRune(bottomRune)
		rune.setLeftRune(leftRune)
		rune.setRightRune(rightRune)
		pass
	pass

func updateAdjectedRunes(rune, index: Vector2):
	var topRune = getTopRuneSafe(index)
	if isRune(topRune):
		topRune.setBottomRune(rune)
	var bottomRune = getBottomRuneSafe(index)
	if isRune(bottomRune):
		bottomRune.setTopRune(rune)
	var leftRune = getLeftRuneSafe(index)
	if isRune(leftRune):
		leftRune.setRightRune(rune)
	var rightRune = getRightRuneSafe(index)
	if isRune(rightRune):
		rightRune.setLeftRune(rune)


func getTopRuneSafe(index: Vector2) -> Node2D:
	if index.y-1 >= 0:
		return __runeGrid[index.x][index.y-1]
	return null
func getBottomRuneSafe(index: Vector2) -> Node2D:
	if index.y+1 < __runeGrid[0].size():
		return  __runeGrid[index.x][index.y+1]
	return null
func getLeftRuneSafe(index: Vector2) -> Node2D:
	if index.x-1 >= 0:
		return __runeGrid[index.x-1][index.y]
	return null
func getRightRuneSafe(index: Vector2) -> Node2D:
	if index.x+1 < __runeGrid.size():
		return __runeGrid[index.x+1][index.y]
	return null

func isRune(rune: Node2D) -> bool:
	return rune != null && rune.is_in_group("Rune")


func socketSelected(index: Vector2):
	settingSocketRotation = 0
	settingSocketIndex = index
	settingSocket = true


func indexToPos(indexVector: Vector2) -> Vector2:
	return Vector2(indexVector.x * SOCKET_SIZE, indexVector.y * SOCKET_SIZE)
