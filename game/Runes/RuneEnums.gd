class_name RuneEnums

# Every stat consists of a Value and Multiplier
enum StatTypes {
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
enum Tags{
	TIMER,
	OUTPUT,
	INPUT,
	CONNECTOR,
}

enum Direction{
	TOP,
	BOTTOM,
	LEFT,
	RIGHT
}

static func invertDirection(direction: int):
	match direction:
		Direction.TOP:
			return Direction.BOTTOM
		Direction.BOTTOM:
			return Direction.TOP
		Direction.LEFT:
			return Direction.RIGHT
		Direction.RIGHT:
			return Direction.LEFT
	pass
static func dirIntToString(number: int) -> String:
	return Direction.keys()[number]
