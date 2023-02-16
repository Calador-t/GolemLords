extends Node2D
class_name Rune


var __nextRune = [null, null, null, null]
func addRune(upper, down, left, right):
	__nextRune = [upper, down, left, right]
	pass

func inputSignal(runeSignal):
	pass


