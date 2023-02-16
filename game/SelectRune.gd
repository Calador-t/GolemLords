extends Node2D

const SIZE_OF_TILE = 50


func _ready():
	$Sprite.modulate = Color(0.5,1,1)
func show_runes(position: Vector2, runes):
	visible = true
	$Sprite.position = to_local(position)
	print("showe")
	reziseRect(runes)
	
	pass

func hide_runes():
	pass

func reziseRect(runes):
	var size = $Sprite.get_rect().size
	var sideSize = (ceil(sqrt(runes.size())) as int / 2) as int * 2 + 1
	print(sideSize)
	var scaleUp = sideSize * SIZE_OF_TILE / size.x
	$Sprite.scale = Vector2(scaleUp,scaleUp)
