extends Node

const player_scene = preload("res://real_player.tscn")
const idle_scene = preload("res://idle.tscn")
const StartPosition = Vector2(150, 360)

var player: RealPlayer
var idle: Idle

func _ready() -> void:
	start_idle()
	
func start_idle() -> void:
	idle = idle_scene.instantiate()
	idle.player_position = StartPosition
	idle.started_game.connect(on_idle_started_game)
	
	add_child(idle)

func stop_idle() -> void:
	if idle:
		if idle.started_game.is_connected(on_idle_started_game):
			idle.started_game.disconnect(on_idle_started_game)
		idle.queue_free()

func start_game() -> void:
	player = player_scene.instantiate()
	player.position = StartPosition
	player.collided.connect(on_player_collided)
	
	add_child(player)
	
	$ObstacleConveyor.start()
	
func game_over() -> void:
	if player:
		if player.collided.is_connected(on_player_collided):
			player.collided.disconnect(on_player_collided)
		player.queue_free()
		
	$ObstacleConveyor.stop()
	$ScoreBoard.game_over()

func on_obstacle_conveyor_score_got() -> void:
	$ScoreBoard.add_score()

func on_player_collided(object: Object) -> void:
	if object is Obstacle or object.get_instance_id() == $Floor.get_instance_id():
		game_over()
		start_idle()

func on_idle_started_game() -> void:
	stop_idle()
	start_game()
