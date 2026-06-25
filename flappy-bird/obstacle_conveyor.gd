extends Area2D

@export
var obstacle_speed: int = 100

signal score_got

var start_point = Vector2(520, 0)

func start() -> void:
	$Timer.start()
	$Timer.timeout.emit()
	
func stop() -> void:
	$Timer.stop()
	
	var children = get_children()
	for i in range(len(children)):
		var child = children[i] as Obstacle
		if child:
			destroy_obstacle(child)

func on_timer_timeout() -> void:
	create_obsctacle()
	
func on_body_exited(body: Node2D):
	if body is Obstacle:
		destroy_obstacle(body)
		
func on_win_area_body_entered(body: Node2D) -> void:
	if body is Obstacle:
		score_got.emit()

func create_obsctacle():
	var obstacle = Obstacle.new_obstacle()
	obstacle.position = start_point
	obstacle.velocity = Vector2(-obstacle_speed, 0)
	
	add_child(obstacle)
	
func destroy_obstacle(obstacle: Obstacle):
	obstacle.queue_free()
