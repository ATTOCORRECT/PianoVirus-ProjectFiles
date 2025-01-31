extends Node3D

@onready var star = $Star
var map : Node3D
var visible_trend : Trend
var planet_data : Planet_data
var material : StandardMaterial3D
var color
var selected = false
var selectable = true
@export var key : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# initial setup
	map = get_parent_node_3d().get_parent_node_3d()
	star.visible = false
	star.PROCESS_MODE_DISABLED
	
	# get visible trend
	var range : int = Singleton.trends.size() - 1
	#seed(key.hash())
	visible_trend = Singleton.trends[randi_range(0, range)]
	
	# change material color
	color = visible_trend.color
	$Star/StarSprite.modulate = color
	$Star/Cursor.modulate = Color(1,1,1,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var local_position = global_position - map.global_position
	
	var distance = max(abs(local_position.x) / (3/2.0), abs(local_position.y) / (1/2.0), abs(local_position.z) / (2/2.0))
	
	#https://www.desmos.com/calculator/pyx2feihzn
	var alpha : float = clamp(0,1, 1 / (10 * (distance - 1)) + 1)
	color = Color(color, alpha)
	$Star/StarSprite.modulate = color
	
	if not (alpha <= 0 or alpha >= 1):
		star.visible = true
		star.PROCESS_MODE_INHERIT
	else:
		star.visible = false
		star.PROCESS_MODE_DISABLED

func select_star():
	selected = true
	$Star/Cursor.modulate = Color(1,1,1,1)
	map.select_star($".")

func deselect_star():
	selected = false
	$Star/Cursor.modulate = Color(1,1,1,0)
	pass

func travel():
	# spend star
	selectable = false
	color = Color.GRAY
	
	# travel
	map.set_map_position_target(global_position - map.global_position)
	if planet_data == null:
		planet_data = Planet_data.new(key ,visible_trend, "this is a description for the planet")
	Singleton.travel_to_planet(planet_data)
	
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("Select") and selectable:
			select_star()

func _on_area_3d_mouse_entered() -> void:
	if not selected and selectable: 
		$Star/Cursor.modulate = Color(1,1,1,0.3)

func _on_area_3d_mouse_exited() -> void:
	if not selected and selectable: 
		$Star/Cursor.modulate = Color(1,1,1,0)
