extends Node2D

signal finished

@onready var _nav_region = $NavigationRegion2D
var dirt_scene: PackedScene = load("res://scenes/dirt.tscn")

func _ready() -> void:
	print("i am readyy!")
	
	for i in range(200):
		var random_point = Triangle.get_random_point_in_polygon(_nav_region.navigation_polygon.get_vertices())
		print(random_point)
		
		var new_dirt = dirt_scene.instantiate()
		new_dirt.mass = randf_range(0.5, 10.0)
		new_dirt.ready_scale = randf_range(1, 3.0)
		new_dirt.position = random_point
		add_child(new_dirt)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#print(NavigationServer2D.region_get_random_point($NavigationRegion2D.get_rid(), 1, false))
