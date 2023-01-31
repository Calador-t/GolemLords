extends Node


var nextRune = null
const POWER_COST = 0.01

func inputSignal(stats):
	stats.reducePower(POWER_COST)
	if nextRune != null && nextRune.hasMethode("inputSignal"):
		nextRune.inputSignal(stats)

