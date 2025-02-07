extends Control

@export var graph_panel : Panel

@export var trend_vbox : VBoxContainer

var lines : Array[Line2D]
var boxes : Array[Label]

var run_after_ready = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in Singleton.trends.size():
		var new_line = Line2D.new()
		new_line.default_color = Singleton.trends[i].color
		lines.append(new_line)
		graph_panel.add_child(lines[i])
		
		var new_trend_box = Label.new()
		var label_settings = LabelSettings.new()
		label_settings.font_color = Singleton.trends[i].color
		label_settings.font_size = 64
		
		new_trend_box.text = Singleton.trends[i].name
		
		new_trend_box.size_flags_vertical = Control.SIZE_EXPAND
		
		new_trend_box.label_settings = label_settings
		boxes.append(new_trend_box)
		trend_vbox.add_child(boxes[i])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if run_after_ready:
		after_ready()

func after_ready():
	run_after_ready = false
	for i in lines.size():
		for j in 10:
			var newPoint = Vector2(graph_panel.size.x / 9 * j, graph_panel.size.y * randf())
			lines[i].add_point(newPoint,j)
