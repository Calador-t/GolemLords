extends Rune

class_name PipeRune

const POWER_COST = 0.01

var __timer: Timer

func _ready():
	__timer = Timer.new()
	add_child(__timer)
	__timer.wait_time = 0.5
	#__timer.start()
	__timer.connect("timeout", self, "_outputMana")

func canInputMana(fromIndex: Vector2) -> bool:
	return __manaCarried.size() <= 0 && getRelativeTopRuneIndex() == fromIndex


func inputMana(mana, fromDirection, fromRune):
	self.add_child(mana)
	
	__timer.start()
	__manaCarried.append(mana)

func getRuneOutputIndex() -> Vector2:
	return getRelativeBottomRuneIndex()

func _outputMana() -> void:
	if __manaCarried.size() <= 0:
		# no mana to give 
		return
	
	
	var outRuneIndex = getRelativeBottomRuneIndex()
	var outRune = __runeGrid.getRuneByIndex(outRuneIndex)
	
	if !outRune || !outRune.is_in_group("Rune") || !outRune.canInputMana(__index):
		return
	
	var removedMana = __manaCarried[0]
	__manaCarried.remove(0)
	self.remove_child(removedMana)
	outRune.inputMana(removedMana, __index, self)
	__timer.stop()

