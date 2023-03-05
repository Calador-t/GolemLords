extends Node2D
class_name Rune

# All relative to Rotation
var __topRune = null
var __bottomRune = null
var __leftRune = null
var __rightRune = null

var __manaCarried: Array
var __runeRotation: int = 0
var __index: Vector2
var __runeGrid

func setIndex(index: Vector2):
	print(index)
	__index = index
func getIndex() -> Vector2:
	return __index

func setRuneGrid(runeGrid):
	__runeGrid = runeGrid

func setTopRune(topRune):
	__topRune = topRune
func setBottomRune(bottomRune):
	__bottomRune = bottomRune
func setLeftRune(leftRune):
	__leftRune = leftRune
func setRightRune(rightRune):
	__rightRune = rightRune


func canInputMana(fromIndex: Vector2) -> bool:
	return __manaCarried.size() <= 0

func inputMana(mana, fromIndex: Vector2, fromRune):
	pass

func getAdjectedRuneRelative(fromDirection: int) -> Node2D:
	var newDirection = relativeToAbsoluteDirection(fromDirection)
	match newDirection:
		RuneEnums.Direction.TOP:
			return __topRune
		RuneEnums.Direction.BOTTOM:
			return __bottomRune
		RuneEnums.Direction.LEFT:
			return __leftRune
		RuneEnums.Direction.RIGHT:
			return __rightRune
	return null



func relativeToAbsoluteDirection(fromDirection: int) -> int:
	var directionInt = 0
	match fromDirection:
		RuneEnums.Direction.TOP:
			directionInt = 0
		RuneEnums.Direction.BOTTOM:
			directionInt = 2
		RuneEnums.Direction.LEFT:
			directionInt = 3
		RuneEnums.Direction.RIGHT:
			directionInt = 1
	directionInt = (directionInt + __runeRotation) % 4
	var newDirection: int
	match directionInt:
		0:
			newDirection = RuneEnums.Direction.TOP
		2:
			newDirection = RuneEnums.Direction.BOTTOM
		3:
			newDirection = RuneEnums.Direction.LEFT
		1:
			newDirection = RuneEnums.Direction.RIGHT
	return newDirection

func absoluteToRelativeDirection(fromDirection: int) -> int:
	var directionInt = 0
	match fromDirection:
		RuneEnums.Direction.TOP:
			directionInt = 0
		RuneEnums.Direction.BOTTOM:
			directionInt = 2
		RuneEnums.Direction.LEFT:
			directionInt = 1
		RuneEnums.Direction.RIGHT:
			directionInt = 3
	directionInt = (directionInt + __runeRotation) % 4
	var newDirection: int = 0
	match directionInt:
		0:
			newDirection = RuneEnums.Direction.TOP
		2:
			newDirection = RuneEnums.Direction.BOTTOM
		1:
			newDirection = RuneEnums.Direction.LEFT
		3:
			newDirection = RuneEnums.Direction.RIGHT
	return newDirection

func setRuneRotation(rotation: int):
	__runeRotation = rotation
	pass


func getAdjectedRunes():
	print("12: " + str(__runeRotation))
	print("Relativ top to new: " + str(relativeToAbsoluteDirection(RuneEnums.Direction.TOP)))
	print("Top: " + str(getAdjectedRuneRelative(RuneEnums.Direction.TOP)) + 
		  " Bot: " + str(getAdjectedRuneRelative(RuneEnums.Direction.BOTTOM)) + 
		  " Left: " + str(getAdjectedRuneRelative(RuneEnums.Direction.LEFT)) + 
		  " Right: " + str(getAdjectedRuneRelative(RuneEnums.Direction.RIGHT)))
	return [__topRune, __bottomRune, __leftRune, __rightRune]
