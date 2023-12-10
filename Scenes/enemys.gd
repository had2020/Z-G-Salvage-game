extends Node2D

@onready var scene_res = preload("res://Scenes/enemy_1.tscn")

var count = 10
var radius = Vector2(1000, 0)
var center = Vector2(0, 0)

var step = 2 * PI / count

func _ready():
	count = 200 # for first batch of enemeys 
	spawn_nodes()

# spawns the enemys based off a count around a point
func spawn_nodes():
	for i in range(count):
		var spawn_pos = center + radius.rotated(step * i)

		var node = scene_res.instantiate()
		node.position = spawn_pos 
		add_child(node)
		#print("spawn func ran") for debuging only
