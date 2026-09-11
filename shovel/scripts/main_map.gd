extends Node

signal digged
@onready var player = $Player
@onready var map = $Map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.digged.connect(on_player_digged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func on_player_digged():
	var position = player.get_direction_position()
	print(position, " ", player.position)
	
	var coord = map.local_to_map(position)
	print(map.local_to_map(position), " ", map.local_to_map(player.position))
	
	map.set_cell(coord, 3, Vector2i(2, 1))
	# change tile
	digged.emit()
	
