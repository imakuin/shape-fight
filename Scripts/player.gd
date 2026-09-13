extends Area2D
var hasShot = false
@export var speed_player = 300.0
const ball_scene = preload("uid://dtgm3noq3rmgb")
var field_size = Vector2(2000,2000)
var direction_ball

signal death_signal

# set spwan position of player
func _ready() -> void:
	position = Vector2(randf_range(0, field_size.x), randf_range(0, field_size.y))
	

func _process(delta: float) -> void:
	# movement of player
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed_player
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, field_size)

	if Input.is_action_just_pressed("shoot_up")&& hasShot == false:
		direction_ball = Vector2.UP
		shoot()
	elif Input.is_action_just_pressed("shoot_down")&& hasShot == false:
		direction_ball = Vector2.DOWN
		shoot()
	elif Input.is_action_just_pressed("shoot_right")&& hasShot == false:
		direction_ball = Vector2.RIGHT
		shoot()
	elif Input.is_action_just_pressed("shoot_left")&& hasShot == false:
		direction_ball = Vector2.LEFT
		shoot()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		queue_free()
		death_signal.emit()
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("meteor"):
		queue_free()
		death_signal.emit()

# shooting
func shoot():
	hasShot = true
	var ball = ball_scene.instantiate()
	ball.global_position = global_position
	ball.direction_ball = direction_ball
	get_tree().current_scene.add_child(ball)
	await get_tree().create_timer(0.25).timeout
	hasShot = false
