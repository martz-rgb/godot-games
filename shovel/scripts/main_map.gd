extends Node

signal digged
@onready var _player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player.digged.connect(_on_player_digged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_player_digged():
	digged.emit()
	
