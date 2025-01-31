extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Singleton.active_planet_data != null:
		$PlanetNameLabel.text = Singleton.active_planet_data.planet_name
		$PrimaryTrendLabel.text = Singleton.active_planet_data.primairy_trend.name
		$SecondaryTrendLabel.text = Singleton.active_planet_data.secondary_trend.name
		$PlanetDescriptionLabel.text = Singleton.active_planet_data.planet_description
