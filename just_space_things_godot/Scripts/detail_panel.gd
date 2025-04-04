extends Control

@export var planet_name : RichTextLabel
@export var planet_trend : RichTextLabel
@export var planet_trend_sprite : TextureRect
@export var planet_display_ui : Control

var font = load("res://Assets/Fonts/terminal-grotesque.ttf")
var font_2 = load("res://Assets/Fonts/JustSpaceThings_Draft1-Regular.ttf")
var null_sprite = load("res://Assets/Textures/Trend icons/nullicon.png")

func _enter_tree() -> void:
	Singleton.detail = self

func _ready() -> void:
	null_text()
	slow_process()
	pass # Replace with function body.

func slow_process():
	while true:
		await get_tree().create_timer(1.0).timeout
		update_text()

func null_text():
	#planet name
	planet_name.clear()
	planet_name.push_font(font)
	planet_name.push_font_size(96)
	
	var text_planet_name = "Select a Planet"
	planet_name.append_text(text_planet_name)
	
	#planet trend
	planet_trend.clear()
	planet_trend.push_font(font)
	planet_trend.push_font_size(96)
	
	var text_trend_name = "No Selection"
	planet_trend.append_text(text_trend_name)
	
	var trend_color = Color.GRAY
	planet_trend_sprite.modulate = trend_color
	planet_trend_sprite.texture = null_sprite

func update_text():
	if Singleton.Selected_planet_data == null:
		null_text()
		return
	
	#planet name
	planet_name.clear()
	planet_name.push_font(font_2)
	planet_name.push_font_size(128)
	
	var text_planet_name = str(Singleton.Selected_planet_data.random_id) # change for later
	planet_name.append_text(text_planet_name)
	
	planet_display_ui.update_planet_textures(Singleton.Selected_planet_data.planet_asset)
	
	#planet trend
	if Singleton.Selected_planet_data.spent == false:
		
		var trend_color = Singleton.Selected_planet_data.primairy_trend.color
		planet_trend_sprite.modulate = trend_color
		planet_trend_sprite.texture = Singleton.Selected_planet_data.primairy_trend.icon
		
		planet_trend.clear()
		planet_trend.push_font(font)
		planet_trend.push_font_size(96)
		planet_trend.push_color(trend_color)
		
		var text_trend_name = Singleton.Selected_planet_data.primairy_trend.name
		var text_trend_val = str(floor(Singleton.Selected_planet_data.primairy_trend.value * 1000))
		
		planet_trend.append_text("Detected Trend:")
		planet_trend.newline()
		planet_trend.append_text(text_trend_name)
		planet_trend.newline()
		planet_trend.append_text(text_trend_val)
	else:
		var trend_color = Color.GRAY
		planet_trend_sprite.modulate = trend_color
		planet_trend_sprite.texture = null_sprite
		
		planet_trend.clear()
		planet_trend.push_font(font)
		planet_trend.push_font_size(96)
		planet_trend.push_color(trend_color)
		
		var text_trend_name = "None"
		var text_trend_val = "0"
		
		planet_trend.append_text("Detected Trend:")
		planet_trend.newline()
		planet_trend.append_text(text_trend_name)
		planet_trend.newline()
		planet_trend.append_text(text_trend_val)
	
