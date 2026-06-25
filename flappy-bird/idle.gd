extends Node
class_name Idle

signal started_game
var player_position: Vector2

func _ready(): 
	$AnimatedSprite2D.position = player_position
	$AnimatedSprite2D.play("flying")
	

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		started_game.emit()
