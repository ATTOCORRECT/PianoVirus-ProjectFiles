extends Control

enum TimerState {
  RUN,
  SUCCESS,
  FAIL,
}
var timer_state = TimerState.RUN

var timer = Timer.new()
var wait_time = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)
	timer.call_deferred("start")
	
	await timer.timeout
	faliure()
	Singleton.minigame_controller.minigame_failed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	match timer_state:
		TimerState.RUN:
			draw_timer_pie()
		
		TimerState.SUCCESS:
			draw_sucess()
		
		TimerState.FAIL:
			draw_faliure()
		

func draw_faliure():
	var center = size/2
	var min_size = min(size.x/2,size.y/2)
	var width = min_size * 0.25
	var span = min_size - width/2 - 20
	
	var color = Color.RED
	
	draw_line(center + Vector2( span,  span), center + Vector2(-span, -span), color, width, false)
	draw_line(center + Vector2(-span,  span), center + Vector2( span, -span), color, width, false)

func draw_sucess():
	var center = size/2
	var min_size = min(size.x/2,size.y/2)
	var width = min_size * 0.25
	var span = min_size - width/2 - 20
	
	var color = Color.YELLOW_GREEN
	
	var points = [center + Vector2( -span, 0),
				  center + Vector2( 0, span * 0.75),
				  center + Vector2( span, -span)]
	
	draw_polyline(points, color, width, false)

func draw_timer_pie():
	var center = size/2
	var min_size = min(size.x/2,size.y/2)
	var width = min_size * 0.5
	var radius = min_size - width/2 - 10
	var start_angle = deg_to_rad(-90)
	var time_left = timer.time_left / wait_time
	var end_angle = deg_to_rad(1 - time_left * 360) + start_angle
	
	var color
	if time_left < 0.2:
		var flash = fmod(floor(timer.time_left * 10), 2)
		if flash == 0:
			color = Color.RED
		else:
			color = Color.PINK
	elif time_left < 0.5:
		color = Color.GOLDENROD
	else:
		color = Color.YELLOW_GREEN
	
	#draw_line(center, center + Vector2(1,1), Color.RED, 20)
	draw_arc(center, radius, start_angle, end_angle, 64, color, width, false)

func faliure():
	timer_state = TimerState.FAIL

func success():
	pause()
	timer_state = TimerState.SUCCESS

func pause():
	timer.paused = true

func get_remaining_time_01() -> float:
	return timer.time_left / wait_time
