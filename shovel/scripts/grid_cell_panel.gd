extends Panel
class_name GridCellPanel

const OutlineWidth = 2.

signal hovered(i: int, j: int)
signal exited_hovered(i: int, j: int)

var grid_cell: GridCell
var is_hovered: bool = false
var is_selected: bool = false

func _init() -> void:
	connect("mouse_entered", on_mouse_entered)
	connect("mouse_exited", on_mouse_exited)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.size = size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
func _draw():
	var rect = Rect2(Vector2.ZERO, size)
	draw_rect(rect, choose_color(), true)	
	if is_selected:
		draw_rect(rect, Color.BURLYWOOD, false, OutlineWidth)	

func select_cell():
	is_selected = true
	
func unselect_cell():
	is_selected = false	

func on_mouse_entered():
	hovered.emit(grid_cell.i, grid_cell.j)
	is_hovered = true
	
func on_mouse_exited():
	exited_hovered.emit(grid_cell.i, grid_cell.j)
	is_hovered = false

func choose_color():
	if grid_cell:
		if grid_cell.digged:
			return Color.SADDLE_BROWN
			
		match grid_cell.item:
			Items.Kinds.PlantA:
				return Color.AQUAMARINE
			Items.Kinds.PlantB:
				return Color.BLUE_VIOLET
			Items.Kinds.Coin:
				return Color.DARK_GOLDENROD
				
	return Color.from_rgba8(0x80, 0x9f, 0x60)	
	
