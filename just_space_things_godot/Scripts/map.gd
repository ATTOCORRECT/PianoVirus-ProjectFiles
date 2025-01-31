extends Node3D

var map_position = Vector3.ZERO
var map_position_target = Vector3.ZERO
var old_map_position_target = Vector3.ZERO

var area_size = Vector3i(8, 8, 8)
var area_row    = area_size.x
var area_slice  = area_size.x * area_size.y
var area_volume = area_size.x * area_size.y * area_size.z

var map_node = preload("res://Scenes/Panels/Map/map_node.tscn")

var cells = {}

var target_star : Node3D

var step = 0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	
	chase_target(delta)
	update_cells()
	
	#DebugDraw3D.draw_box(Vector3(0,0,0) + position, Quaternion.IDENTITY, Vector3(3,1,2), Color.WHITE, true)
	#DebugDraw3D.draw_sphere(Vector3.ZERO,0.02,Color.WHITE)
	pass

func chase_target(delta):
	if (map_position_target != map_position):
		if (step < 1): #                               v speed
			step += (-abs(step - 0.5) + 0.5) * delta * 3 + delta / 10
		else:
			step = 1
		
		map_position = lerp(old_map_position_target, map_position_target, step)

func update_cells():
	var update_center = Vector3i(map_position)
	
	for i in area_volume:
		var x =  i               % area_size.x - (area_size.x / 2)
		var y = (i / area_row  ) % area_size.y - (area_size.z / 2)
		var z = (i / area_slice) % area_size.z - (area_size.z / 2)
		
		var cell_position = Vector3i(x,y,z) + update_center
		
		add_cell(cell_position)
		var cell = get_cell(cell_position)
		if cell != null:
			pass
			#cell.should_remove = false # this is for later if i want to clean up cells from memory
	
	for key in cells.keys():
		var cell : Map_cell = cells[key]
		cell.set_position_offset(map_position * -1)
		pass

func add_cell(cell_position: Vector3i):
	var key = (str(cell_position.x) 
	   + "," + str(cell_position.y) 
	   + "," + str(cell_position.z))
	
	if cells.has(key):
		return
	
	var cell = Map_cell.new(cell_position, map_node, key)
	add_child(cell)
	
	cells[key] = cell

func get_cell(cell_position: Vector3i):
	var key = (str(cell_position.x) 
	   + "," + str(cell_position.y) 
	   + "," + str(cell_position.z))
	if cells.has(key):
		return cells.get(key)
	return null

func set_map_position_target(position_target: Vector3):
	step = 0
	old_map_position_target = map_position_target
	map_position_target = (position_target * 1.25) + map_position
	#                                        ^ 1/(Map transform scale)
func select_star(star):
	if target_star != null and target_star != star:
		target_star.deselect_star()
	target_star = star


func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("Select") and target_star != null and $"../WarpButton/Cooldown".is_stopped():
			target_star.travel()
			$"../WarpButton/Cooldown".start()
