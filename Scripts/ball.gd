extends Area2D

@export var speed_ball = 400
var direction_ball := Vector2.ZERO
var damage = 1


# set position of ball after throwing
func _process(delta: float) -> void:
	position += direction_ball * speed_ball * delta

# if the ball touches enemy (body) -> enemy takes damage, ball: animation + queue_free()
func _on_body_entered(body) -> void:
	if body.has_method("take_damage"):
		$AnimatedSprite2D.play()
		speed_ball = 0
		body.take_damage(damage)
		await get_tree().create_timer(.15).timeout
		queue_free()

# if the ball is out of the game boundary -> animation + queue_free()
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("boundary"):
		$AnimatedSprite2D.play()
		speed_ball = 0
		await get_tree().create_timer(.15).timeout
		queue_free()
