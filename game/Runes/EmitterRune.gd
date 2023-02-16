extends Rune

class_name EmitterRune


const runePower = 5
onready var runeLabel = $runeLabel

func _ready():
	runeLabel.text = "EM"
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 1
	#timer.start()
	timer.connect("timeout", self, "_emitt")

func _emitt() -> void:
	print("emit Signal")
	if __nextRune[1] != null && __nextRune[1].has_method("inputSignal"):
		var runeSignal = RuneSignal.new(runePower)
		__nextRune[1].inputSignal(runeSignal)

