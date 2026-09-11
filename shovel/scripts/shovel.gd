extends Node
class_name Shovel

enum Kinds {
	None,
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

static func get_mask(kind: Kinds) -> Array:
	match kind:
		Kinds.Rect1x1:
			return [Vector2i(0, 0)]
		Kinds.Rect2x3:
			return [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(0, -1),
			Vector2i(-1, -1), Vector2i(-2, 0), Vector2i(-2, -1)]
		Kinds.Rect1x5:
			return [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-2, 0 ), Vector2i(-3, 0), Vector2i(-4, 0)]
		Kinds.Rect1x6:
			return [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-2, 0), Vector2i(-3, 0), Vector2i(-4, 0), Vector2i(-5, 0)]
		Kinds.Rect2x2:
			return [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(0, -1), Vector2i(-1, -1)]
	return []
	
static func rotate_mask_counterclockwise(area: Array) -> Array:
	var new_area = []
	for value in area:
		new_area.append(Vector2i(value.y, value.x * -1))
		
	return new_area
	
static func apply_mask(mask: Array, pivot: Vector2i, rows: int, cols: int) -> Array:
	var result = []
	
	for value in mask:
		var tmp = pivot + value
		if tmp.x < 0 || tmp.x >= rows || tmp.y < 0 || tmp.y >= cols:
			continue
		result.append(tmp)
		
	return result

static func get_area(kind: Kinds, pivot: Vector2i, rows: int, cols: int, rotate: int = 0) -> Array:
	var mask = get_mask(kind)
	
	for i in range(rotate % 4):
		mask = rotate_mask_counterclockwise(mask)
	
	return apply_mask(mask, pivot, rows, cols)
	
