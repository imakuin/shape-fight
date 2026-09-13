extends CharacterBody2D

@export var speed_enemy := 150
@export var sprint_enemy := 300
var player
var enemy
var field_size = Vector2(2000,2000)
@export var enemy_health = 1
var rand_num = 0
var rand_cooldown = false
var rand_dir = Vector2(0,0)
signal enemy_death


# get the player, set spawn position for enemy (random)
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	position = Vector2(randf_range(0, field_size.x), randf_range(0, field_size.y))
	if player != null:
		# if enemy spawns too close to player --> queue_free()
		if player.global_position.distance_to(position) <= 200:
			queue_free()

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	# enemy direction to player, velocity calculation
	if rand_num == 0:
		var direction = global_position.direction_to(player.global_position)
		direction = direction.normalized()
		velocity = direction * speed_enemy
	# enemy goes to player with higher velocity
	if rand_num == 1:
		var direction = global_position.direction_to(player.global_position)
		direction = direction.normalized()
		velocity = direction * sprint_enemy
	# enemy changes direction
	if rand_num == 2:
		var direction = global_position.direction_to(player.global_position)
		direction = direction + rand_dir
		direction = direction.normalized()
		velocity = direction * speed_enemy
	#enemy changes direction + velocity
	if rand_num == 3:
		var direction = global_position.direction_to(player.global_position)
		direction = direction + rand_dir
		direction = direction.normalized()
		velocity = direction * sprint_enemy
	move_and_slide()

#cooldown for the different "actions" 0,1,2,3
func _process(delta):
	if rand_cooldown == false:
		rand_cooldown = true
		await get_tree().create_timer(3).timeout
		rand_num = randi_range(0,2)
		sprint_enemy = randi_range(150,400)
		rand_dir = Vector2(randi_range(-5,5), randi_range(-5,5))
		rand_cooldown = false
	
func take_damage(damage):
	enemy_health -= damage
	if enemy_health <= 0:
		enemy_death.emit()
		queue_free()
