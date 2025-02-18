extends Control

@export var graph_panel : Panel

@export var trend_vbox : VBoxContainer

var resolution = 10

var line : Line2D
#var boxes : Array[RichTextLabel]

var run_after_ready = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line = Line2D.new()
	graph_panel.add_child(line)
	
	line.default_color = Color.HOT_PINK
	
	
	slow_process()
	
	await get_tree().create_timer(0.1).timeout
	after_ready()
	#step_graph_multiple_times(10)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func slow_process():
	while true:
		await get_tree().create_timer(1.0).timeout
		step_graph()

func step_graph():
	
	for i in resolution - 1:
		var next_point = line.points[i + 1].y
		line.points[i].y = next_point
	
	line.points[resolution - 1].y = randf() * graph_panel.size.y

func step_graph_multiple_times(steps : int):
	for i in steps:
		step_graph()

func after_ready():
	run_after_ready = false
	for i in resolution:
		var new_point = Vector2(graph_panel.size.x / (resolution - 1) * i, graph_panel.size.y * randf())
		line.add_point(new_point,i)
