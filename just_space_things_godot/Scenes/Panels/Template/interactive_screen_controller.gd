extends Node3D

@onready var display: MeshInstance3D = $Display
@onready var area = $Area
@onready var viewport: Viewport = $Viewport

var mesh_size = Vector2()

var mouse_entered = false
var mouse_held = false
var mouse_inside = false

var last_mouse_position_3D = null
var last_mouse_position_2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	viewport.set_process_input(true)
	
	var material = StandardMaterial3D.new()
	material.set_local_to_scene(true) 
	
	var viewport_texture = ViewportTexture.new()
	viewport_texture.is_local_to_scene()
	
	viewport_texture = $Viewport.get_texture()
	
	material.albedo_texture = viewport_texture
	
	display.set_surface_override_material(0,material)

func _unhandled_input(event):
	var is_mouse_event = false
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		is_mouse_event = true
	
	if mouse_entered and (is_mouse_event):
		handle_mouse(event)

func handle_mouse(event):
	mesh_size = display.mesh.size
	
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
	
	mouse_position_2D.x += mesh_size.x / 2
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
	
	var result = dss.intersect_ray(rayparm)
	
	
	if result.size() > 0:
		return result.position
	else:
		return null


func _on_area_mouse_entered() -> void:
	mouse_entered = true


func _on_area_mouse_exited() -> void:
	mouse_entered = false
