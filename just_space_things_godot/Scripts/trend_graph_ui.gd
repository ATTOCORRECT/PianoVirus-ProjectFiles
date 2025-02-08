extends Control

@export var graph_panel : Panel

@export var trend_vbox : VBoxContainer

var lines : Array[Line2D]
var boxes : Array[RichTextLabel]

var run_after_ready = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in Singleton.trends.size():
		var new_line = Line2D.new()
		new_line.default_color = Singleton.trends[i].color
		lines.append(new_line)
		graph_panel.add_child(lines[i])
		
		var new_trend_box = RichTextLabel.new()
		
		new_trend_box.size_flags_vertical = Control.SIZE_EXPAND

		boxes.append(new_trend_box)
		trend_vbox.add_child(boxes[i])
	
	slow_process()
	
	await get_tree().create_timer(0.1).timeout
	after_ready()
	step_graph_multiple_times(10)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func slow_process():
	while true:
		await get_tree().create_timer(1.0).timeout
		step_graph()

func step_graph():
	for i in Singleton.trends.size():
		Singleton.trends[i].value = clamp(Singleton.trends[i].value + randf_range(-0.1,0.1),0,1)
		
		for j in 9:
			var next_point = lines[i].points[j + 1].y
			lines[i].points[j].y = next_point
		
		lines[i].points[9].y = graph_panel.size.y * Singleton.trends[i].value
	
	for i in Singleton.trends.size():
		var index = 0
		for j in Singleton.trends.size():
			if Singleton.trends[i].value > Singleton.trends[j].value:
				index += 1
		trend_vbox.move_child(boxes[i],index)
	
	for i in boxes.size():
		boxes[i].clear()
		boxes[i].append_text("test")

func step_graph_multiple_times(steps : int):
	for i in steps:
		step_graph()

func after_ready():
	run_after_ready = false
	for i in lines.size():
		for j in 10:
			var new_point = Vector2(graph_panel.size.x / 9 * j, graph_panel.size.y * randf())
			lines[i].add_point(new_point,j)
