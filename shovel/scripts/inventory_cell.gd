extends Control

@onready var color_rect = $ColorRect
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func set_color(color: Color):
	color_rect.color = color
	
func set_label(text: String):
	label.text = text
