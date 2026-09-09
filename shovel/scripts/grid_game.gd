extends Node

signal finished

@onready var grid_container = $Grid
var grid_cell_scene: PackedScene = load("res://scenes/grid_cell.tscn")

var core: GridCore

const Rows = 10
const Cols = 10
const TileSize = 55

func _init() -> void:
	core = GridCore.create(Rows, Cols)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid_container.columns = Cols
	for i in range(Rows):
		for j in range(Cols):
			var grid_cell = grid_cell_scene.instantiate()
			grid_cell.custom_minimum_size = Vector2(TileSize, TileSize)
			grid_container.add_child(grid_cell)
			
	grid_container.queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
