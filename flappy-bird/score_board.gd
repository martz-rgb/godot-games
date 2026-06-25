extends HBoxContainer


var score: int = 0
var max_score: int = 0

func _ready() -> void:
	$MarginContainer/Score.text = str(score)
	$MarginContainer2/TopScore.text = str(max_score)

func add_score():
	score += 1
	$MarginContainer/Score.text = str(score)
	
func game_over():
	if score > max_score:
		max_score = score
	score = 0
	
	$MarginContainer/Score.text = str(score)
	$MarginContainer2/TopScore.text = str(max_score)
	
