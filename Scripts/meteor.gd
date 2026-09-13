extends Area2D
var direction = Vector2.ZERO
var meteor_speed = 250

# set spawn position and direction of the meteor
func _ready() -> void:
	position = Vector2(randi_range(300,1700), -500)
	direction = Vector2(randf_range(-1,1), 1)
	direction = direction.normalized()

func _process(delta: float) -> void:
	position += direction * meteor_speed * delta
	rotation = direction.angle()
