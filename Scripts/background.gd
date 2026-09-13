extends Node2D

var random_pos
var field_size = Vector2(2000,2000)
var game_size = Vector2(4000,4000)
var offset = Vector2(-500,-500)
@export var color = Color.ALICE_BLUE

# draw the background of the game
func _draw():
	draw_rect(Rect2(offset, game_size), color)
	draw_rect(Rect2(Vector2.ZERO, field_size), Color.BLACK)
	for circle in range(0,150):
		random_pos = Vector2(randf_range(0,field_size.x), randf_range(0,field_size.y))
		draw_circle(random_pos, 2,Color.NAVY_BLUE)
