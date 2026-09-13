extends Node2D
var enemy
const ENEMY = preload("uid://bkrc82sqpm3e8")
var score := 0
var spawn_count = 6

# spawn enemies at the beginning
func _ready() -> void:
	for i in range(8):
		enemy = ENEMY.instantiate()
		add_child(enemy)
		enemy.enemy_death.connect(_on_enemy_death)

# spawn enemies after timer timeout
func _on_enemy_timer_timeout() -> void:
	for i in range(spawn_count):
		enemy = ENEMY.instantiate()
		add_child(enemy)
		enemy.enemy_death.connect(_on_enemy_death)
	
# update score on enemy death
func _on_enemy_death():
	score += 1 
	$CanvasLayer/Control/Label.text = "Score: " + str(score)

# increase spawn number of enemies after timer timeout
func _on_timer_timeout() -> void:
	spawn_count += 2
