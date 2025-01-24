extends Resource
class_name Planet_data

@export var primairy_trend  : Trend
@export var secondary_trend : Trend
@export var tertiary_trend  : Trend

@export var planet_description : String

var random_id : int

func _init(in_primairy_trend : Trend, in_planet_description : String) -> void:
	primairy_trend = in_primairy_trend
	planet_description = in_planet_description
	
	secondary_trend = primairy_trend
	while secondary_trend == primairy_trend:
		secondary_trend = Singleton.trends[randi_range(0, Singleton.trends.size() - 1)]
		pass
	
	random_id = randi()

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass
