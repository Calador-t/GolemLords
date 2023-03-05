extends Node
class_name RuneSignal

var __power
var __statDict = {}


func _initStats(power: float):
	__power = power

func _ready():
	addRuneStat(RuneEnums.StatTypes.AMMOUNT, 1,0)
	print(__statDict)
	addRuneStat(RuneEnums.StatTypes.AMMOUNT, -1,2)
	print(__statDict)
	pass

func reducePower(value: float):
	__power -= value
	if __power < 0:
		__power = 0

# DFTL value is always 0 an multp is always 1
func addRuneStat(stat: int, value: float, mult: float): 
	if __statDict.has(stat):
		var oldStat = __statDict[stat]
		__statDict[stat] = [oldStat[0] + value, oldStat[1] + mult]
	else:
		__statDict[stat] =  [value, mult]
	pass

func invertRuneStats():
	# for each 
	#	make invert value
	pass

func toColor() -> Color:
	return Color(1,1,1, __powerToAlpha())

# return float between 0 and 1
func __powerToAlpha() -> float:
	if __power == 0:
		return 0.0
	else:
		# function starts at 0.2 at 0 and at 5 is at 0.8 and gets closser to 1 until infint
		return ((0.8*0.6*__power)/(0.6*__power+1))+0.2

func status():
	print(JSON.parse(JSON.print(__statDict)).result)
	var string = {"Power": __power,
				  "Stats": dictToJSON(__statDict)}
	return string

func dictToJSON(dict):
	return JSON.parse(JSON.print(dict)).result

