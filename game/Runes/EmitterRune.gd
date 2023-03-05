extends Rune

class_name EmitterRune

onready var mana = load("res://Runes/Mana.tscn")

const runePower = 5
var __timer

func _ready():
	__timer = Timer.new()
	add_child(__timer)
	__timer.wait_time = 1
	__timer.start()
	__timer.connect("timeout", self, "_emitt")

func _emitt() -> void:
	var outRuneIndex = getRuneOutputIndex()
	var outRune = __runeGrid.getRuneByIndex(outRuneIndex)
	
	if outRune && outRune.is_in_group("Rune"):
		var newMana = mana.instance()
		
		if outRune.canInputMana(__index):
			outRune.inputMana(newMana, __index, self)


func getRuneOutputIndex() -> Vector2:
	return getRelativeBottomRuneIndex()

func canInputMana(fromIndex: Vector2) -> bool:
	return false
