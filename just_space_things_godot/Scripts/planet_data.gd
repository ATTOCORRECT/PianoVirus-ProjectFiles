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
	
	var remaining_trends : Array[Trend] = Singleton.trends.duplicate()
	remaining_trends.erase(primairy_trend)
	secondary_trend = remaining_trends[randi_range(0, remaining_trends.size() - 1)]
	
	random_id = key.hash()

func _ready() -> void:
	pass 
