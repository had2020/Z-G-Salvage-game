extends Camera2D

# effects zoom speed and smoothness 
var zoomspeed = 100
var zoommargin = 0.5 #lower means more smooth but it becomes slower to zoom

# zoom limits
var zoomMin = 0.3
var zoomMax = 6

var zoompos = Vector2()
var zoomfactor = 1.0

func _process(delta):
	zoom.x = lerp(zoom.x, zoom.x * zoomfactor, zoomspeed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomfactor, zoomspeed * delta)
	
	zoom.x = clamp(zoom.x, zoomMin, zoomMax)
	zoom.y = clamp(zoom.y, zoomMin, zoomMax)

func _input(event):
	if abs(zoompos.x - get_global_mouse_position().x) > zoommargin:
		zoomfactor = 1.0
	if abs(zoompos.y - get_global_mouse_position().y) > zoommargin:
		zoomfactor = 1.0
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP: 
				zoomfactor -= 0.01 
				zoompos = get_global_mouse_position()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoomfactor += 0.01
				zoompos = get_global_mouse_position()
