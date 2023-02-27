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

func canInputMana(from: int) -> bool:
	return __manaCarried.size() <= 0 && absoluteToRelativeDirection(from) == RuneEnums.Direction.TOP

func inputMana(mana, fromDirection, fromRune):
	self.add_child(mana)
	
	__timer.start()
	__manaCarried.append(mana)
	print(__manaCarried)
	print("Mana added")


func _outputMana() -> void:
	#__timer.stop()
	var nextRune = getAdjectedRuneRelative(RuneEnums.Direction.BOTTOM)
	if __manaCarried.size() <= 0:
		# no mana to give 
		return
	
	if nextRune == null ||  !nextRune.is_in_group("Rune"):
		# invalid adjected rune
		return
	
	var absoluteDirectionFrom = relativeToAbsoluteDirection(RuneEnums.Direction.TOP)
	if nextRune.canInputMana(absoluteDirectionFrom):
		print(__manaCarried)
		var removedMana = __manaCarried[0]
		__manaCarried.remove(0)
		print(__manaCarried)
		print(removedMana)
		self.remove_child(removedMana)
		
		nextRune.inputMana(removedMana, absoluteDirectionFrom, self)
		print("mana Removed")
		pass

