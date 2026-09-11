extends Node

signal finished

@onready var grid_container = $Grid
var grid_cell_scene: PackedScene = load("res://scenes/grid_cell.tscn")

@onready var turns_label = $MarginContainer/VBoxContainer/LeftTurns
@onready var next_dig = $MarginContainer/VBoxContainer/NextDig

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
	
	update_gui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print("where is my action")
	if Input.is_action_just_pressed("ui_action"):
		make_dig()
			
	elif Input.is_action_just_pressed("ui_rotate"):
		core.rotate_shovel()
		update_selection()

func on_cell_hovered(i, j):
	current_cell = Vector2(i, j)
	update_selection()
	
func on_cell_exited_hovered(i, j):
	if Vector2i(i, j) == current_cell:
		current_cell = NoCurrentCell
	update_selection()
	
func make_dig():
	#print("where is my action")
	if current_cell == NoCurrentCell:
		return
	
	core.dig(current_cell)
	redraw_grid()
	
	if core.is_over():
		core.finish()
		await get_tree().create_timer(1.0).timeout
		finished.emit()
		
	update_gui()
	
func update_selection():
	for i in range(Rows*Cols):
		var grid_cell = grid_container.get_child(i)
		if not grid_cell:
			break
		grid_cell.unselect_cell()
			
	if current_cell != NoCurrentCell:
		var selection = Shovel.get_area(core.current_dig, current_cell, Rows, Cols, core.rotate)
		for value in selection:
			var select_cell = grid_container.get_child(value.x * Cols + value.y)
			if select_cell:
				select_cell.select_cell()
					
	redraw_grid()

func redraw_grid():
	for i in range(Rows*Cols):
		var grid_cell = grid_container.get_child(i)
		if not grid_cell:
			break
		grid_cell.queue_redraw()

func update_gui():
	turns_label.text = "Digs left: "+str(core.turns)
	next_dig.next_dig = core.next_dig
	next_dig.queue_redraw()
	
