extends Node

var trends : Array[Trend]
var active_planet_data : Planet_data

var contacts: Array[Sender]

var minigame_controller : Node
var player : Camera3D

func travel_to_planet(planet_data : Planet_data):
	active_planet_data = planet_data
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
