extends CharacterBody2D

signal digged

const SPEED = 300.0
@onready var _animated_player = $AnimationPlayer
@onready var _sprite = $Sprite2D
var direction = Vector2(0, 1) # front is default

var is_action = false

class AnimationParams:
	var animation: String
	var flip_h: bool

func _process(_delta: float) -> void:
	update_animation()

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal := Input.get_axis("ui_left", "ui_right")
	var vertical := Input.get_axis("ui_up", "ui_down")
	
	var is_new_action = Input.is_action_just_pressed("ui_accept")
	if is_new_action and !is_action:
		is_action = true
		
	var new_velocity = Vector2(horizontal, vertical).normalized() * SPEED
	if is_action:
		new_velocity = Vector2(0, 0)
	
	velocity = new_velocity

	move_and_slide()


func update_animation():
	var new_direction = determine_direction(velocity)
	var params = determine_animation(new_direction, velocity.length() > 0, is_action)
	
	_sprite.flip_h = params.flip_h	
	_animated_player.play(params.animation)
	
	direction = new_direction
	
func determine_direction(current_velocity: Vector2) -> Vector2:
	var new_direction = direction
	
	if current_velocity.length() > 0:
		if current_velocity.x == 0:
			new_direction = Vector2(0, current_velocity.y / abs(current_velocity.y))
		else:
			new_direction = Vector2(current_velocity.x / abs(current_velocity.x), 0)
		
	return new_direction	
		
func determine_animation(current_direction: Vector2, is_moving: bool, current_is_action: bool) -> AnimationParams:
	var params = AnimationParams.new()
	params.animation = "idle_front"
	params.flip_h = false
	
	if current_direction.x == 1:
		if current_is_action:
			params.animation = "attack_side"
		elif is_moving:
			params.animation = "walk_side"
		else:
			params.animation = "idle_side"
		params.flip_h = false
	elif current_direction.x == -1:
		if current_is_action:
			params.animation = "attack_side"
		elif is_moving:
			params.animation = "walk_side"
		else:
			params.animation = "idle_side"
		params.flip_h = true
	elif current_direction.y == 1:
		if current_is_action:
			params.animation = "attack_front"
		elif is_moving:
			params.animation = "walk_front"
		else:
			params.animation = "idle_front"
	elif current_direction.y == -1:
		if current_is_action:
			params.animation = "attack_back"
		elif is_moving:
			params.animation = "walk_back"
		else:
			params.animation = "idle_back"
		
	return params
		
func dig():
	is_action = false
	digged.emit()
		
