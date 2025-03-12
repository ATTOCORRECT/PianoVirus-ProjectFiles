extends Control

@export var planet_name : RichTextLabel
@export var planet_trend : RichTextLabel
@export var planet_trend_sprite : TextureRect
@export var planet_description : RichTextLabel

var font = load("res://Assets/Fonts/terminal-grotesque.ttf")

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
	planet_trend.push_font_size(64)
	
	var text_trend_name = "No Selection"
	planet_trend.append_text(text_trend_name)
	
	#planet description
	planet_description.clear()
	planet_description.push_font(font)
	planet_description.push_font_size(64)
	
	var text_description = "No Selection"
	planet_description.append_text(text_description)
	
func update_text():
	if Singleton.Selected_planet_data == null:
		null_text()
		return
	
	#planet name
	planet_name.clear()
	planet_name.push_font(font)
	planet_name.push_font_size(112)
	
	var text_planet_name = str(Singleton.Selected_planet_data.random_id) # change for later
	planet_name.append_text(text_planet_name)
	
	#planet trend
	var trend_color = Singleton.Selected_planet_data.primairy_trend.color
	planet_trend_sprite.modulate = trend_color
	
	planet_trend.clear()
	planet_trend.push_font(font)
	planet_trend.push_font_size(64)
	planet_trend.push_color(trend_color)
	
	var text_trend_name = Singleton.Selected_planet_data.primairy_trend.name
	var text_trend_val = str(floor(Singleton.Selected_planet_data.primairy_trend.value * 1000))
	
	planet_trend.append_text(text_trend_name)
	planet_trend.newline()
	planet_trend.append_text(text_trend_val)
	
	#planet description
	planet_description.clear()
	planet_description.push_font(font)
	planet_description.push_font_size(64)
	
	
	planet_description.append_text("Planet Description:")
	planet_description.newline()
	
	#planet_description.pop()
	
	var text_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut"
	planet_description.append_text(text_description)
