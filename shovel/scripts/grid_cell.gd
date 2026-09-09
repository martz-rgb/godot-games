extends Panel
class_name GridCellPanel

func _init() -> void:
	pass
	#size = Vector2(40, 40)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.size = size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
