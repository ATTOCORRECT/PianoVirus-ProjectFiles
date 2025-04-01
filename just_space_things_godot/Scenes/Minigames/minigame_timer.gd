extends Control

var timer = Timer.new()
var wait_time = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)
	timer.call_deferred("start")
	
	await timer.timeout
	Singleton.minigame_controller.minigame_failed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var center = size/2
	var min = min(size.x/2,size.y/2)
	var width = min * 0.5
	var radius = min - width/2 - 10
	var start_angle = deg_to_rad(-90)
	var time_left = (timer.time_left / wait_time)
	var end_angle = deg_to_rad(1 - time_left * 360) + start_angle
	var color
	
	if time_left < 0.2:
		color = Color.ORANGE_RED
	elif time_left < 0.5:
		color = Color.GOLDENROD
	else:
		color = Color.YELLOW_GREEN
	
	#draw_line(center, center + Vector2(1,1), Color.RED, 20)
	draw_arc(center, radius, start_angle, end_angle, 64, color, width, false)
