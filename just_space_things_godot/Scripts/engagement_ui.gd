extends Control

@export var graph_panel : Panel

@export var trend_vbox : VBoxContainer

@export var lower_threshold : float
@export var upper_threshold : float

var resolution = 100

var next_engagement_value = 1

var line : Line2D
var engagement_values : Array[float]
#var boxes : Array[RichTextLabel]
var current_engagement : float

var run_after_ready = true

var acceleration = -0.0025
var velocity = 1

var first_minigame = false
var velocity_indicator = true

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


func EndGame():
	print("End of game :)")

func step_graph():
	
	for i in resolution - 1:
		var next_value = engagement_values[i + 1]
		engagement_values[i] = next_value

	
	#progression logic
	if first_minigame:
		velocity += acceleration
		velocity = clamp(velocity, 0.9, 1.1)
		next_engagement_value *= velocity + randf_range(-0.01, 0.01)
		next_engagement_value = max(next_engagement_value, 1)
	
	
	if (next_engagement_value >= upper_threshold):
		EndGame()
	#if (next_engagement_value = lower_threshold):
		#EndGame()
	
	
	print(velocity)
	#+ randf_range(-100,100)
	
	# drawing 
	engagement_values[resolution - 1] = next_engagement_value
	
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
		var new_point = Vector2(graph_panel.size.x / (resolution - 1) * i, 1)
		engagement_values.append(new_point.y)
		line.add_point(new_point,i)

func add_velocity(add_value : float, trend_value : float):
	print(velocity)
	
	velocity += (add_value * trend_value ) - 0.1
	first_minigame = true
	print("amount added = ", (add_value * trend_value ) - 0.1)
