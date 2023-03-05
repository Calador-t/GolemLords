extends Node

# Every stat consists of a Value and Multiplier
enum statTypes {
	COOLDOWN, # how often a spell can be casted
	SIZE, # size of projektile/ spanned creature, ...
	DMG, # Amount 
	SPEED,
	LIFETIME,
	CHAINS,
	AMMOUNT,
	SPREAD,
	BOUNCE, # How often it bounces from the screen Edge
}

# Some runes have tags. They group runes by type and can add effects
enum tags{
	TIMER,
	OUTPUT,
	INPUT,
	CONNECTOR,
}

var __power
var __runeStatDict = {}

func _ready():
	addRuneStat(statTypes.AMMOUNT, 1,0)
	print(__runeStatDict)
	addRuneStat(statTypes.AMMOUNT, -1,2)
	print(__runeStatDict)
	pass

func reducePower(value: int):
	__power -= value

# DFTL value is always 0
func addRuneStat(stat: int, value: float, mult: float): 
	if __runeStatDict.has(stat):
		var oldStat = __runeStatDict[stat]
		__runeStatDict[stat] = [oldStat[0] + value, oldStat[1] + mult]
	else:
		__runeStatDict[stat] =  [value, mult]
	pass

func invertRuneStats():
	# for each 
	#	make invert value
	pass
