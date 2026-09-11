extends Control

var next_dig: Shovel.Kinds
var TileSize = 65
var OutlineWidth = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	var area = Shovel.get_mask(next_dig)
	area = Shovel.rotate_mask_counterclockwise(area)
	
	var pivot = Vector2i.ZERO
	for value in area:
		if value.x < pivot.x:
			pivot.x = value.x
		if value.y < pivot.y:
			pivot.y = value.y
			
	for i in range(len(area)):
		area[i] = area[i] - pivot
		
	draw_rect(Rect2(Vector2.ZERO, size), Color.TRANSPARENT, true)
	for value in area:
		var rect = Rect2(TileSize * Vector2(value.x, value.y), Vector2(TileSize, TileSize))
		print(value, rect)
		draw_rect(rect, Color.DARK_VIOLET, false, OutlineWidth)
