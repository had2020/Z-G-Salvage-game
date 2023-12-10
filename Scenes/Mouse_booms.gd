extends Node2D

var input_up = "UP"
var input_down = "DOWN"

@export var change_rate:float = 0.01

# this var is meant to keep the growth factor growing after the end of the func
var stored_change:float = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var growth_factor =  Input.get_action_strength(input_up) - Input.get_action_strength(input_down)
	if growth_factor == 0:
		stored_change = 1
	self.position = get_global_mouse_position()
	var myscale = Vector2(0.5, 0.5)
	var times_factor =  growth_factor + growth_factor * stored_change
	myscale = myscale * times_factor
	#print(Input.get_action_strength(input_up) - Input.get_action_strength(input_down)) debuging only 
	self.set_scale(myscale)
	stored_change = stored_change + change_rate
	#print(stored_change) debug only to check if there's change
	if stored_change == 10000:
		stored_change = 1
