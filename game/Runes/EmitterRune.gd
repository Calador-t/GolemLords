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
	var nextRune = getAdjectedRuneRelative(RuneEnums.Direction.BOTTOM)
	var newMana = mana.instance()

	if nextRune == null ||  !nextRune.is_in_group("Rune"):
		# invalid adjected rune
		return
	var absoluteDirectionFrom = relativeToAbsoluteDirection(RuneEnums.Direction.TOP)
	if nextRune.canInputMana(absoluteDirectionFrom):
		nextRune.inputMana(newMana, absoluteDirectionFrom, self)


func canInputMana(from: int) -> bool:
	return false
