extends Label
var score = 0

# show score
func _ready() -> void:
	text = "Score: " + str(score)
