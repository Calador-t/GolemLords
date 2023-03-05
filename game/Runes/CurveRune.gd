extends Rune

class_name CurveRune

const POWER_COST = 0.01
var __timer: Timer

func _ready():
	__timer = Timer.new()
	add_child(__timer)
	__timer.wait_time = 0.5
	__timer.start()
	__timer.connect("timeout", self, "_outputMana")

func canInputMana(fromIndex: Vector2) -> bool:
	var fromTop = getRelativeTopRuneIndex() == fromIndex
	var fromRight = getRelativeRightRuneIndex() == fromIndex
	return __manaCarried.size() <= 0 && (fromTop || fromRight)

func inputMana(mana, fromDirection, fromRune):
	self.add_child(mana)
	__timer.start()
	__manaCarried.append(mana)
	setManaRotation(mana)

func _outputMana() -> void:
	if __manaCarried.size() <= 0:
		# no mana to give
		return
	
	var outRune = getOutRune()
	
	if !outRune || !outRune.is_in_group("Rune") || !outRune.canInputMana(__index):
		return
	
	var removedMana = __manaCarried[0]
	resetManaRotation(removedMana)
	__manaCarried.remove(0)
	self.remove_child(removedMana)
	outRune.inputMana(removedMana, __index, self)
	
	__timer.stop()


func getOutRune() -> Node2D:
	var randomFirstOutputTry = randi() % 2
	
	var topRuneIndex = getRelativeTopRuneIndex()
	var topRune = __runeGrid.getRuneByIndex(topRuneIndex)
	
	var rightRuneIndex = getRelativeRightRuneIndex()
	var rightRune = __runeGrid.getRuneByIndex(rightRuneIndex)
	
	if randomFirstOutputTry == 0:
		if topRune && topRune.canInputMana(__index):
			return topRune
		else:
			return rightRune
	else:
		if rightRune && rightRune.canInputMana(__index):
			return rightRune
		else:
			return topRune
	return null

func setManaRotation(mana: Node2D):
	mana.rotation_degrees = -45

func resetManaRotation(mana: Node2D):
	mana.rotation_degrees = 0
