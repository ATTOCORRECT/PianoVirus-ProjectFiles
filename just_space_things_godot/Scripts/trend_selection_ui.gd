extends Control

@export var trend_primary : RichTextLabel
@export var trend_primary_sprite : TextureRect
@export var trend_primary_selection : ColorRect
@export var trend_primary_button : Node3D
@export var trend_secondary : RichTextLabel
@export var trend_secondary_sprite : TextureRect
@export var trend_secondary_selection : ColorRect
@export var trend_secondary_button : Node3D


var font = load("res://Assets/Fonts/terminal-grotesque.ttf")

func _enter_tree() -> void:
	Singleton.trend_select = self

func _ready() -> void:
	await get_tree().process_frame
	trend_primary_button.set_color(Color.DIM_GRAY)
	trend_secondary_button.set_color(Color.DIM_GRAY)
	slow_process()
	disable_panel()

func slow_process():
	while true:
		await get_tree().create_timer(1.0).timeout
		if process_mode == ProcessMode.PROCESS_MODE_INHERIT:
			update_text()

func null_text():
	# primary
	trend_primary.clear()
	trend_primary_sprite.modulate = Color.GRAY
	trend_primary_selection.color = Color.BLACK
	trend_primary_button.set_color(Color.WHITE)
	
	# secondary
	trend_secondary.clear()
	trend_secondary_sprite.modulate = Color.GRAY
	trend_secondary_selection.color = Color.BLACK
	trend_secondary_button.set_color(Color.WHITE)

func update_text():
	if Singleton.active_planet_data == null:
		return
		
	if Singleton.active_planet_data.spent == true:
		disable_panel()
		return
	
	# primary
	var primary_color = Singleton.active_planet_data.primairy_trend.color
	
	trend_primary.clear()
	trend_primary.push_font(font)
	trend_primary.push_color(primary_color)
	trend_primary.push_font_size(88)
	
	var text_trend_primary_name = Singleton.active_planet_data.primairy_trend.name
	var text_trend_primary_val = str(floor(Singleton.active_planet_data.primairy_trend.value * 1000))
	
	trend_primary.append_text(text_trend_primary_name)
	trend_primary.newline()
	trend_primary.append_text(text_trend_primary_val)
	
	# secondary
	var secondary_color = Singleton.active_planet_data.secondary_trend.color
	
	trend_secondary.clear()
	trend_secondary.push_font(font)
	trend_secondary.push_color(secondary_color)
	trend_secondary.push_font_size(88)
	
	var text_trend_secondary_name = Singleton.active_planet_data.secondary_trend.name
	var text_trend_secondary_val = str(floor(Singleton.active_planet_data.secondary_trend.value * 1000))
	
	trend_secondary.append_text(text_trend_secondary_name)
	trend_secondary.newline()
	trend_secondary.append_text(text_trend_secondary_val)

func update():
	if Singleton.active_planet_data == null:
		return
	
	update_text()
	
	#primary
	var primary_color = Singleton.active_planet_data.primairy_trend.color
	
	trend_primary_sprite.modulate = primary_color
	trend_primary_selection.color = Color.BLACK
	trend_primary_button.set_color(primary_color)
	
	#secondary
	var secondary_color = Singleton.active_planet_data.secondary_trend.color
	
	trend_secondary_sprite.modulate = secondary_color
	trend_secondary_selection.color = Color.BLACK
	trend_secondary_button.set_color(secondary_color)

func disable_panel():
	disable_buttons()
	null_text()
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func enable_panel():
	enable_buttons()
	update()
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	pass

func disable_buttons():
	trend_primary_button.disable_button()
	trend_secondary_button.disable_button()

func enable_buttons():
	trend_primary_button.enable_button()
	trend_secondary_button.enable_button()

func _button_1_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action("Select"):
		disable_buttons()
		Singleton.minigame_controller.load_minigame(Singleton.active_planet_data.primairy_trend)
		trend_primary_selection.color = Singleton.active_planet_data.primairy_trend.color
		#play trend select sound
		Singleton.audio_manager.play_trend_select_one_sound()
		print("Julian Test Debug: trend selected sound 1")

func _button_2_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action("Select"):
		disable_buttons()
		Singleton.minigame_controller.load_minigame(Singleton.active_planet_data.secondary_trend)
		trend_secondary_selection.color = Singleton.active_planet_data.secondary_trend.color
		#play trend select sound
		Singleton.audio_manager.play_trend_select_two_sound()
		print("Julian Test Debug: trend selected sound 2")
