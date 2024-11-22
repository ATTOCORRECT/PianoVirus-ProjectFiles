extends Node3D


@onready var display = $Display
@onready var area = $Area
@onready var viewport = $Viewport

var mesh_size = Vector2()

var mouse_entered = false
var mouse_held = false
var mouse_inside = false

var last_mouse_position_3D = null
var last_mouse_position_2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.mouse_entered.connect(func(): mouse_entered = true)
	viewport.set_process_input(true)
	pass # Replace with function body.

func _unhandled_input(event):
	var is_mouse_event = false
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		is_mouse_event = true
	
	if mouse_entered and (is_mouse_event or mouse_held):
		handle_mouse(event)
	elif not is_mouse_event:
		viewport.push_input(event)

func handle_mouse(event):
	mesh_size = display.mesh.size
	
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		mouse_held = event.pressed
	
	var mouse_position_3D = find_mouse(event.global_position)
	
	mouse_inside = mouse_position_3D != null
	
	if mouse_inside:
		mouse_position_3D = area.global_transform.affine_inverse() * mouse_position_3D
		last_mouse_position_3D = mouse_position_3D
		
	else:
		mouse_position_3D = last_mouse_position_3D
		if mouse_position_3D == null:
			mouse_position_3D = Vector3.ZERO
	
	var mouse_position_2D = Vector2(mouse_position_3D.x, -mouse_position_3D.y)
	
	mouse_position_2D.x += mesh_size.x / 2 # try making this vector wise
	mouse_position_2D.y += mesh_size.y / 2
	
	# set to 0 - 1 scale
	mouse_position_2D.x = mouse_position_2D.x / mesh_size.x
	mouse_position_2D.y = mouse_position_2D.y / mesh_size.y
	
	# convert to viewport range
	mouse_position_2D.x = mouse_position_2D.x * viewport.size.x
	mouse_position_2D.y = mouse_position_2D.y * viewport.size.y
	
	event.position = mouse_position_2D
	event.global_position = mouse_position_2D
	
	if event is InputEventMouseMotion:
		if last_mouse_position_2D == null:
			event.relative = Vector2(0,0)
		else:
			event.relative = mouse_position_2D - last_mouse_position_2D

	last_mouse_position_2D = mouse_position_2D
	viewport.push_input(event)



func find_mouse(event_position: Vector2):
	var camera = get_viewport().get_camera_3d()
	
	var dss: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var rayparm = PhysicsRayQueryParameters3D.new()
	rayparm.from = camera.project_ray_origin(event_position)
	var distance = 5
	rayparm.to = rayparm.from + camera.project_ray_normal(event_position) * distance
	rayparm.collide_with_bodies = false
	rayparm.collide_with_areas = true
	
	#print_debug(camera.project_ray_origin(event_position))
	
	var result = dss.intersect_ray(rayparm)
	
	
	if result.size() > 0:
		return result.position
	else:
		return null
