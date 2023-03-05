extends Rune

class_name CurveRune

const POWER_COST = 0.01
var __timer: Timer
var __inputDirection: int

func _ready():
	__timer = Timer.new()
	add_child(__timer)
	__timer.wait_time = 0.5
	#__timer.start()
	__timer.connect("timeout", self, "_outputMana")

func canInputMana(fromIndex: Vector2) -> bool:
	
	var fromTop = absoluteToRelativeDirection(from) == RuneEnums.Direction.TOP
	var fromRight = absoluteToRelativeDirection(from) == RuneEnums.Direction.RIGHT
	return __manaCarried.size() <= 0 && (fromTop || fromRight)

func inputMana(mana, fromDirection, fromRune):
	self.add_child(mana)
	__inputDirection = absoluteToRelativeDirection(fromDirection)
	print("In Mana: " + str(RuneEnums.Direction.keys()[__inputDirection]))
	__timer.start()
	__manaCarried.append(mana)
	print(__manaCarried)
	print("Mana added")


func _outputMana() -> void:
	
	var outDirection
	if __inputDirection == RuneEnums.Direction.TOP:
		outDirection = RuneEnums.Direction.RIGHT
	elif __inputDirection == RuneEnums.Direction.RIGHT:
		outDirection = RuneEnums.Direction.TOP
	else:
		printerr("! Err: Wrong dir given (from Mana.gd)")
	var nextRune = getAdjectedRuneRelative(outDirection)
	if __manaCarried.size() <= 0:
		# no mana to give 
		return
	#print("out Dir")
	#print(RuneEnums.Direction.keys()[outDirection])
	if nextRune == null ||  !nextRune.is_in_group("Rune"):
		# invalid adjected rune
		return
	print("InDir "+ str(RuneEnums.dirIntToString(__inputDirection))+
	" Outdir "+ str(RuneEnums.Direction.keys()[outDirection])+ 
	" Rot: " + str(__runeRotation) + 
	" goal Dir: " + str(RuneEnums.dirIntToString(relativeToAbsoluteDirection(RuneEnums.invertDirection(outDirection)))) )
	if nextRune.canInputMana(relativeToAbsoluteDirection(RuneEnums.invertDirection(outDirection))):
		print(__manaCarried)
		var removedMana = __manaCarried[0]
		__manaCarried.remove(0)
		print(__manaCarried)
		print(removedMana)
		self.remove_child(removedMana)
		
		nextRune.inputMana(removedMana, relativeToAbsoluteDirection(outDirection), self)
		print("mana Removed")
		pass
