extends Node2D
class_name Rune

const BOTTOM_VECTOR = Vector2(0, 1)
const TOP_VECTOR = Vector2(0, -1)
const LEFT_VECTOR = Vector2(-1, 0)
const RIGHT_VECTOR = Vector2(1, 0)


var __manaCarried: Array
var __runeRotation: int = 0
var __index: Vector2
var __runeGrid

func _init():
	self.add_to_group("Rune")

func setIndex(index: Vector2):
	__index = index

func getIndex() -> Vector2:
	return __index

func setRuneGrid(runeGrid):
	__runeGrid = runeGrid

func canInputMana(fromIndex: Vector2) -> bool:
	return false

func inputMana(mana, fromIndex: Vector2, fromRune):
	pass

func setRuneRotation(rotation: int):
	__runeRotation = rotation
	pass


func getRelativeBottomRuneIndex() -> Vector2:
	match __runeRotation:
		0:
			return __index + BOTTOM_VECTOR
		1:
			return __index + LEFT_VECTOR
		2:
			return __index + TOP_VECTOR
		3:
			return __index + RIGHT_VECTOR
	return Vector2()

func getRelativeTopRuneIndex() -> Vector2:
	match __runeRotation:
		0:
			return __index + TOP_VECTOR
		1:
			return __index + RIGHT_VECTOR
		2:
			return __index + BOTTOM_VECTOR
		3:
			return __index + LEFT_VECTOR
	return Vector2()

func getRelativeLeftRuneIndex() -> Vector2:
	match __runeRotation:
		0:
			return __index + LEFT_VECTOR
		1:
			return __index + TOP_VECTOR
		2:
			return __index + RIGHT_VECTOR
		3:
			return __index + BOTTOM_VECTOR
	return Vector2()

func getRelativeRightRuneIndex() -> Vector2:
	match __runeRotation:
		0:
			return __index + RIGHT_VECTOR
		1:
			return __index + BOTTOM_VECTOR
		2:
			return __index + LEFT_VECTOR
		3:
			return __index + TOP_VECTOR
	return Vector2()
