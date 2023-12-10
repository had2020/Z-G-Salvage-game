extends RigidBody2D

# The maximum speed of the RigidBody2D
const MAX_SPEED = 2000

# The maximum force or impulse to apply to the RigidBody2D
const MAX_FORCE = 1000

# The timer node that will trigger the random movement
@onready var timer = $Timer

# The raycast node that will check if the RigidBody2D is on the ground
@onready var raycast = $RayCast2D

var enemy = preload("res://Scenes/enemy_1.tscn")

func respawn():
	Globals.score = Globals.score + 1 
	var node = enemy.instantiate()
	node.position = Vector2(randf_range(1000, 0), randf_range(1000, 0))
	var root = get_tree().root
	root.add_child(node)
	queue_free()

func _on_timer_timeout():
	# Generate a random vector for the force or impulse
	var random_vector = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	# Apply a central force or impulse to the RigidBody2D
	# You can use either one of these methods, but not both at the same time
	apply_central_force(random_vector * MAX_FORCE)
	#apply_central_impulse(random_vector * MAX_FORCE)
	
	# If the RigidBody2D is on the ground, apply a vertical force or impulse to make it jump
	if raycast.is_colliding():
		apply_central_force(Vector2(0, -MAX_FORCE))
		#apply_central_impulse(Vector2(0, -MAX_FORCE))

func _integrate_forces(state):
	# Limit the speed of the RigidBody2D
	state.linear_velocity = state.linear_velocity.clamp(Vector2(-MAX_SPEED, -MAX_SPEED), Vector2(MAX_SPEED, MAX_SPEED))

#kill enemy when it is inside the mouse boom of doom
func _on_area_2d_area_entered(area):
	if area.is_in_group("Boom"):
		respawn()
