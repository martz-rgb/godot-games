extends Node2D

signal finished

func _ready() -> void:
	print("i am readyy!")
	
	await get_tree().create_timer(3.0).timeout
	finished.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
