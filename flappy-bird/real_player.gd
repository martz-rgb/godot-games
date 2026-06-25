extends CharacterBody2D
class_name RealPlayer

signal collided(object: Object)

func _ready() -> void:
	$AnimatedSprite2D.play("flying")

const JUMP_VELOCITY = Vector2(0, -400)

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity = JUMP_VELOCITY
		
	var is_collision = move_and_slide()
	if is_collision:
		var collision = get_last_slide_collision()
		var collider = collision.get_collider()
		collided.emit(collider)

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
