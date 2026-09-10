extends Node

signal finished

@onready var grid_container = $Grid
var grid_cell_scene: PackedScene = load("res://scenes/grid_cell.tscn")

var core: GridCore
var current_cell: Vector2i = NoCurrentCell

const Rows = 10
const Cols = 10
const TileSize = 55
const NoCurrentCell = Vector2i(-1, -1)

func _init() -> void:
	core = GridCore.create(Rows, Cols)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	core.init_game()
	
	grid_container.columns = Cols
	for i in range(Rows*Cols):
		var grid_cell = grid_cell_scene.instantiate()
		grid_cell.custom_minimum_size = Vector2(TileSize, TileSize)
		grid_cell.grid_cell = core.grid[i]
		grid_cell.hovered.connect(on_cell_hovered)
		grid_cell.exited_hovered.connect(on_cell_exited_hovered)
		
		grid_container.add_child(grid_cell)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print("where is my action")
	if Input.is_action_just_pressed("ui_action"):
		print("where is my action")
		if current_cell == NoCurrentCell:
			return
		
		core.dig(current_cell)
		redraw_grid()
		
		if core.is_over():
			core.finish()
			await get_tree().create_timer(1.0).timeout
			finished.emit()

func on_cell_hovered(i, j):
	current_cell = Vector2(i, j)
	print("hovered: ", current_cell.x, " ", current_cell.y)
	update_selection()
	
func on_cell_exited_hovered(i, j):
	if Vector2i(i, j) == current_cell:
		current_cell = NoCurrentCell
	print("exited hovered: ", current_cell.x, " ", current_cell.y)
	update_selection()
	
func update_selection():
	#core.current_dig
	for i in range(Rows*Cols):
		var grid_cell = grid_container.get_child(i)
		if not grid_cell:
			break
		grid_cell.unselect_cell()
		
	if current_cell != NoCurrentCell:
		var select_cell = grid_container.get_child(current_cell.x * Cols + current_cell.y)
		select_cell.select_cell()
		
	redraw_grid()

func redraw_grid():
	for i in range(Rows*Cols):
		var grid_cell = grid_container.get_child(i)
		if not grid_cell:
			break
		grid_cell.queue_redraw()
