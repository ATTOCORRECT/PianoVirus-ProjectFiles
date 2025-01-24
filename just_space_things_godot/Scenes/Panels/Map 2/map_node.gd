extends Node3D

@onready var star = $Star
var map
var visible_trend : Trend
var planet_data : Planet_data
var material : StandardMaterial3D
var distance
var color
var key : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# initial setup
	map = get_parent_node_3d().get_parent_node_3d()
	star.visible = false
	star.PROCESS_MODE_DISABLED
	
	# get visible trend
	var range : int = Singleton.trends.size() - 1
	visible_trend = Singleton.trends[randi_range(0, range)]
	
	
	
	# change material color
	color = visible_trend.color
	$Star/Sprite3D.modulate = color



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var local_position = global_position - map.global_position
	
	distance = max(abs(local_position.x) / (3/2.0), abs(local_position.y) / (1/2.0), abs(local_position.z) / (2/2.0))
	
	if (distance < 1):
		star.visible = true
		star.PROCESS_MODE_INHERIT
	else:
		star.visible = false
		star.PROCESS_MODE_DISABLED
	
	#https://www.desmos.com/calculator/pyx2feihzn
	var alpha = clamp(0,1, 1 / (10 * (distance - 1)) + 1)
	$Star/Sprite3D.modulate = Color(color, alpha)


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("Select"):
			travel()

func travel():
	map.set_map_position_target(global_position - map.global_position)
	if planet_data == null:
		planet_data = Planet_data.new(visible_trend, "this is a description for the planet")
	Singleton.travel_to_planet(planet_data)
	
