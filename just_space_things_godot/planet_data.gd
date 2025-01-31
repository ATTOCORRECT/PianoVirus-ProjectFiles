extends Resource
class_name Planet_data

@export var primairy_trend  : Trend
@export var secondary_trend : Trend
@export var tertiary_trend  : Trend

@export var planet_description : String
@export var planet_name : String = "TestPlanetName"

var key
var random_id

func _init(in_key : String, in_primairy_trend : Trend, in_planet_description : String) -> void:
	
	key = in_key
	primairy_trend = in_primairy_trend
	planet_description = in_planet_description
	
	secondary_trend = primairy_trend
	while secondary_trend == primairy_trend:
		#seed(key.hash())
		secondary_trend = Singleton.trends[randi_range(0, Singleton.trends.size() - 1)]
		pass
	
	random_id = key.hash()

func _ready() -> void:
	pass 
