extends Node2D

const METEOR = preload("uid://djenrrcxoi3fw")
var meteor

# spawn meteors at the beginning
func _ready() -> void:
	for i in range(4):
		meteor = METEOR.instantiate()
		add_child(meteor)

# spawn meteors after timer timeout
func _on_timer_timeout() -> void:
	for i in range(4):
		meteor = METEOR.instantiate()
		add_child(meteor)
