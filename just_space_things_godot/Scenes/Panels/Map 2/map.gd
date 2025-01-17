extends Node3D

var map_position : Vector3 = Vector3.ZERO

var area_size = Vector3i(6, 6, 6)
var area_row    = area_size.x
var area_slice  = area_size.x * area_size.y
var area_volume = area_size.x * area_size.y * area_size.z

var cells = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var speed = 2
	if Input.is_action_pressed("look_left"):
		map_position += Vector3.LEFT * speed * delta
	if Input.is_action_pressed("look_right"):
		map_position += Vector3.RIGHT * speed * delta
	if Input.is_action_pressed("look_up"):
		map_position += Vector3.FORWARD * speed * delta
	if Input.is_action_pressed("look_down"):
		map_position += Vector3.BACK * speed * delta
	
		
	update_cells()
	
	DebugDraw3D.draw_box(Vector3(-1.5,0,-1.5),Quaternion.IDENTITY,Vector3.ONE * 3, Color.RED)
	pass

func update_cells():
	var update_center = Vector3i(map_position)
	
	for i in area_volume:
		var x =  i               % area_size.x - (area_size.x / 2)
		var y = (i / area_row  ) % area_size.y - 1
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
	

	
	var cell = Map_cell.new(cell_position)
	add_child(cell)
	
	cells[key] = cell

func get_cell(cell_position: Vector3i):
	var key = (str(cell_position.x) 
	   + "," + str(cell_position.y) 
	   + "," + str(cell_position.z))
	if cells.has(key):
		return cells.get(key)
	return null
