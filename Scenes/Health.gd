extends Area2D

var health:float = 100

func _on_body_entered(body):
	print("player hit") 
	health = health - randf_range(25, 5)
	Globals.health = health
	if health < 0:
		Globals.score = 1
		get_tree().reload_current_scene()


func _on_timer_timeout():
	health = health + randf_range(20, 1) 
