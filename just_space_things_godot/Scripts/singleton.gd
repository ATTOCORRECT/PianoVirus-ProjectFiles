extends Node

var trends : Array[Trend]
var active_planet_data : Planet_data
var active_minigame_trend : Trend
var Selected_planet_data : Planet_data

var contacts: Array[Sender]

var minigame_controller : Node
var player : Camera3D
var audio_manager : Node
var engagement : Node
var detail : Control
var map : Node3D
var trend_select : Control

func select_planet(planet_data : Planet_data):
	Selected_planet_data = planet_data
	detail.update_text()

func travel_to_planet(planet_data : Planet_data):
	active_planet_data = planet_data
	trend_select.disable_panel()
	await get_tree().create_timer(3.0).timeout
	if active_planet_data.spent != true:
		trend_select.enable_panel()
	
	#print("-- New Planet --")
	#print("Description")
	#print("  " + active_planet_data.planet_description)
	#print("Trends")
	#print("  " + active_planet_data.primairy_trend.name)
	#print("  " + active_planet_data.secondary_trend.name)
	##print(active_planet_data.tertiary_trend.trend_name)
	#print("ID")
	#print("  " + str(active_planet_data.random_id))
	#print(" ")
