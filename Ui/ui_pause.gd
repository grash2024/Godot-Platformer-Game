extends CanvasLayer
var pause=true

func _on_pause_button_pressed():
	get_tree().paused=pause
	pause=not pause