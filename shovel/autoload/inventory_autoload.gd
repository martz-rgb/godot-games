extends Node

var counts = {}

func _init() -> void:
	for i in Items.List:
		if Items.List[i] == Items.Kinds.None:
			continue
		counts[Items.List[i]] = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# test
	#counts[Items.Kinds.PlantA] = 2

func add_items(new_items: Dictionary): # Items.Kinds : int
	for key in new_items:
		var count = counts[key]
		counts[key] = count + new_items[key]
