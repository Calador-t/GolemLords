extends Rune

class_name PipeRune

const POWER_COST = 0.01

func inputSignal(runeSignal):
	runeSignal.addRuneStat(RuneSignal.StatTypes.AMMOUNT, 1,0)
	runeSignal.reducePower(POWER_COST)
	if __nextRune[1] != null && __nextRune[1].has_method("inputSignal"):
		__nextRune[1].inputSignal(runeSignal)
	print(self)
	print(runeSignal.status())

