extends Control

@export var graph_panel : Panel

@export var trend_vbox : VBoxContainer

var resolution = 100

var line : Line2D
var engagement_values : Array[float]
#var boxes : Array[RichTextLabel]

var run_after_ready = true

var acceleration = -1
var velocity = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.engagement = $"."
	
	line = Line2D.new()
	graph_panel.add_child(line)
	
	line.default_color = Color.HOT_PINK

	slow_process()
	
	await get_tree().process_frame
	after_ready()
	step_graph_multiple_times(resolution)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func slow_process():
	while true:
		await get_tree().create_timer(1).timeout
		step_graph()

func step_graph():
	
	for i in resolution - 1:
		var next_value = engagement_values[i + 1]
		engagement_values[i] = next_value
	
	velocity += acceleration
	
	engagement_values[resolution - 1] += velocity #+ randf_range(-100,100)
	
	var min_engangement_value = engagement_values[0]
	var max_engangement_value = engagement_values[0]
	
	for i in resolution:
		if min_engangement_value < engagement_values[i]:
			min_engangement_value = engagement_values[i]
		
		if max_engangement_value > engagement_values[i]:
			max_engangement_value = engagement_values[i]
	
	for i in resolution:
		var value = remap(engagement_values[i], min_engangement_value, max_engangement_value, 0, 1)
		line.points[i].y = value * graph_panel.size.y

func step_graph_multiple_times(steps : int):
	for i in steps:
		step_graph()

func after_ready():
	run_after_ready = false
	for i in resolution:
		var new_point = Vector2(graph_panel.size.x / (resolution - 1) * i, 0)
		engagement_values.append(new_point.y)
		line.add_point(new_point,i)

func add_velocity(add_value : float, trend_value : float):
	print(velocity)
	velocity += add_value * 100 * trend_value
	print(velocity)
