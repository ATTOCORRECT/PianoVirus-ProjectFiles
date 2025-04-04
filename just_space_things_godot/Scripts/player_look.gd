extends Camera3D

var mouse_position : Vector2
var look_position : Vector3
@export var look_range : float = 0.05
@export var look_speed : float = 10

var zoom = false
@export var default_fov : float = 75
@export var zoom_fov : float = 30
var zoom_look_range_factor : float = 1
var zoom_position : Vector3

@onready var viewport = get_viewport()

func _enter_tree() -> void:
	Singleton.player = %Player

func _ready() -> void:
	fov = default_fov

func _process(delta: float) -> void:
	update_input()
	update_look_direction(delta)
	update_fov(delta)

func update_fov(delta):
	var target_fov
	if zoom:
		target_fov = zoom_fov
	else:
		target_fov = default_fov

	fov = lerp(fov, target_fov, 10 * delta)

func update_input():
	if Input.is_action_just_pressed("zoom_in") and not zoom: 
		zoom_in()
	
	if Input.is_action_just_pressed("zoom_out") and zoom: 
		zoom_out()
	
	if Input.is_action_just_pressed("zoom_toggle"):
		if zoom:
			zoom_out()
		else:
			zoom_in()

func zoom_in():
	zoom = true
	var mouse_screen_position = viewport.get_mouse_position()
	zoom_position = project_ray_normal(mouse_screen_position)
	clamp_zoom()
	zoom_fov = 30

func zoom_out():
	zoom = false
	zoom_position = Vector3.FORWARD

func override_zoom(in_zoom_position : Vector3, in_fov : float):
	zoom_position = in_zoom_position.normalized()
	clamp_zoom()
	zoom_fov = in_fov

func update_look_direction(delta):
	mouse_position = viewport.get_mouse_position() / Vector2(viewport.size)
	look_position = lerp(look_position, 
		Vector3((0.5 - mouse_position.y) * look_range + asin(zoom_position.y), 
			(0.5 - mouse_position.x) * look_range - asin(zoom_position.x), 
			0), 
		look_speed * delta)
	rotation = look_position
	
func clamp_zoom():
	zoom_position = Vector3(clamp(zoom_position.x, deg_to_rad(-30), deg_to_rad(30)), 
							clamp(zoom_position.y, deg_to_rad(-20), deg_to_rad(20)), 0)
