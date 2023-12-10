extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hp_rounded = round(Globals.health)
	$healthui.text = str(hp_rounded)
	$scoreui.text = str(Globals.score)
