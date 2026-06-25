extends AnimatableBody2D
class_name Obstacle

const me = preload("res://obstacle.tscn")

const min_gap: int = 200
const max_gap: int = 400
const max_offset: int = 100

var gap: int
var offset: int
var velocity = Vector2(0, 0)

static func new_obstacle() -> Obstacle:
	var obstacle = me.instantiate()
	obstacle.gap = randi_range(min_gap, max_gap)
	obstacle.offset = randi_range(-max_offset, max_offset)
	
	return obstacle

func _ready() -> void:
	pass
	$Up_CollisionShape.position.y -= gap / 2. - offset
	$Up_Sprite.position.y -= gap / 2. - offset
	
	$Down_CollisionShape.position.y += gap / 2. + offset
	$Down_Sprite.position.y += gap / 2. + offset


func _physics_process(delta: float) -> void:
	position += velocity * delta
	
	
