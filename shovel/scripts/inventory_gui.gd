extends Control

@onready var grid = $MarginContainer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = 0
	
	for kind in Items.Kinds:
		var value = Items.Kinds[kind]
		
		if not InventoryAutoload.counts.has(value):
			continue
		var count = InventoryAutoload.counts[value]
		
		var child = grid.get_child(index)
		if not child:
			break
		
		var color = kind_to_color(value)
			
		child.set_color(color)
		child.set_label(str(count))
		
		index = index+1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func kind_to_color(kind: Items.Kinds) -> Color:
	match kind:
		Items.Kinds.PlantA:
			return Color.AQUAMARINE
		Items.Kinds.PlantB:
			return Color.BLUE_VIOLET
		Items.Kinds.Coin:
			return Color.DARK_GOLDENROD
			
	return Color.from_rgba8(0x67, 0x45, 0x28)
