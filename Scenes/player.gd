extends RigidBody2D  

# The force applied to the body when accelerating
@export var thrust = 500.0

# The maximum speed of the body
@export var max_speed = 1000

# The damping factor that reduces the body's velocity over time
@export var damping = 0.01

# The input actions for controlling the body
var input_up = "UP"
var input_down = "DOWN"
var input_left = "LEFT"
var input_right = "RIGHT"

func _physics_process(delta):
	var times_factor = Globals.score * 0.1
	var myscale = Vector2(1, 1) * times_factor
	self.set_scale(myscale)
	# uses the look_at method to look at the mouse pos
	look_at(get_global_mouse_position())
	rotate(deg_to_rad(90))
	
	# Get the input vector from the keyboard
	var input_vector = Vector2.ZERO
	input_vector.y += Input.get_action_strength(input_up) - Input.get_action_strength(input_down)
	input_vector.x += Input.get_action_strength(input_right) - Input.get_action_strength(input_left)
	input_vector = input_vector.normalized()
	#print(input_vector) for debug only, it just tells the positon, the player will move.

	# Apply a force to the body in the direction of its rotationß
	var force = Vector2.UP.rotated(rotation) * input_vector.y * thrust
	apply_central_force(force)

	# Apply a torque to the body to make it rotate
	var torque = -input_vector.x * angular_velocity
	apply_torque(torque)

	# Limit the body's speed to the maximum value
	var speed = linear_velocity.length()
	if speed > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	# Apply a damping factor to the body's velocity
	linear_velocity *= 1.0 - damping
