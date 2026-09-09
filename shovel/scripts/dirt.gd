extends RigidBody2D

var ready_scale = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_child_scale(ready_scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_child_scale(scale: float):
	$CollisionShape2D.scale = Vector2(scale, scale)
	$Sprite2D.scale = Vector2(scale, scale) *21.75
