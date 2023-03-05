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
	if outRune == null ||  !outRune.is_in_group("Rune"):
		# invalid adjected rune
		return
	var newMana = mana.instance()
	var absoluteDirectionFrom = relativeToAbsoluteDirection(RuneEnums.Direction.TOP)
	
	if outRune.canInputMana(__index):
		outRune.inputMana(newMana, __index, self)

func getRuneOutputIndex() -> Vector2:
	match __runeRotation:
		0:
			return __index + Vector2(0, -1)
		1:
			return __index + Vector2(-1, 0)
		2:
			return __index + Vector2(0, 1)
		3:
			return __index + Vector2(1, 0)
	return Vector2()

func canInputMana(fromIndex: Vector2) -> bool:
	return false
