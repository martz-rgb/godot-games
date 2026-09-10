extends Node
class_name Shovel

enum Kinds {
	Rect1x1,
	Rect2x3,
	Rect1x5,
	Rect1x6,
	Rect2x2
}

const List = [
	Kinds.Rect2x3,
	Kinds.Rect1x5,
	Kinds.Rect1x6,
	Kinds.Rect2x2
]

const common_probability = 10. / 2
const rare_probability = 1. / 2

const probabilities = [
	common_probability,
	common_probability,
	rare_probability,
	rare_probability
]

static func get_area(kind: Kinds, pivot: Vector2i):
	# TO-DO kinds and also
	return [pivot]
