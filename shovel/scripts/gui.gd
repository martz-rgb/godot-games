extends Control

@onready var button = $InventoryButton

var inventory_scene: PackedScene = load("res://scenes/inventory.tscn")
var open_inventory = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(on_button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
func on_button_pressed():
	if open_inventory:
		remove_child(open_inventory)
		open_inventory.queue_free()
		open_inventory = null
	else:
		open_inventory = inventory_scene.instantiate()
		add_child(open_inventory)
		
