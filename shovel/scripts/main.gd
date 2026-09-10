extends Node

@onready var _main_map = $MainMap
var minigame_scene: PackedScene = load("res://scenes/grid_game.tscn")

var minigame

func _ready() -> void:
	_main_map.digged.connect(on_main_map_digged)

#func _process(delta: float) -> void:
	#pass

func on_main_map_digged():
	pause_and_start_minigame()

func pause_and_start_minigame():
	if minigame:
		return
	
	_main_map.process_mode = Node.PROCESS_MODE_DISABLED
	#if child_tree:
		#child_tree.paused = true
	
	var new_minigame = minigame_scene.instantiate()
	minigame = new_minigame
	
	minigame.finished.connect(quit_minigame)
	add_child(minigame)
	
func quit_minigame():
	print("got finished")
	if minigame:
		remove_child(minigame)
		minigame.queue_free()
		minigame = null
		
	_main_map.process_mode = Node.PROCESS_MODE_INHERIT
	#var child_tree = _main_map.get_tree()
	#if child_tree:
		#child_tree.paused = false
