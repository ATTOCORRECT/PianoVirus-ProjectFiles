extends Node3D

var chunk_size = Vector3i(16, 16, 16)

var area_size = Vector3i(10, 2, 10)
var area_row    = area_size.x
var area_slice  = area_size.x * area_size.y
var area_volume = area_size.x * area_size.y * area_size.z

var noise = FastNoiseLite.new()
var chunks = {}
var unready_chunks = {}
var thread : Thread

var chunks_generated = 0

func _ready():
	# Configure
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.02
	noise.fractal_octaves = 4
	
	thread = Thread.new()

func _process(_delta):
	update_chunks()
	clean_up_chunks()
	reset_chunks()

func add_chunk(chunk_position: Vector3i):
	var key = (str(chunk_position.x) 
	   + "," + str(chunk_position.y) 
	   + "," + str(chunk_position.z))
	
	if chunks.has(key) or unready_chunks.has(key): # why isnt this working??
		return
	
	if not thread.is_started():
		thread.start(load_chunk.bind([thread, chunk_position]))
		unready_chunks[key] = 1

func load_chunk(parameters):
	var thread = parameters[0]
	var chunk_position = parameters[1]
	
	var chunk = Chunk.new(noise, chunk_position, chunk_size)
	
	call_deferred("load_done", chunk, thread)

func load_done(chunk : Chunk, thread):
	add_child(chunk)
	var chunk_position = chunk.chunk_position
	var key = (str(chunk_position.x) 
	   + "," + str(chunk_position.y) 
	   + "," + str(chunk_position.z))
	chunks[key] = chunk
	unready_chunks.erase(key)
	
	chunks_generated += 1
	
	thread.wait_to_finish()

func load_finish():
	
	pass

func update_chunks():
	var camera = get_viewport().get_camera_3d()
	var camera_forward = -camera.global_basis.z
	var t = -camera.global_position.y / camera_forward.y
	var update_center = camera.global_position + camera_forward * t
	
	var update_chunk_center = Vector3i(update_center) / chunk_size
	
	for i in area_volume:
		var x =  i               % area_size.x - (area_size.x / 2)
		var y = (i / area_row  ) % area_size.y
		var z = (i / area_slice) % area_size.z - (area_size.z / 2)
		var chunk_position = Vector3i(x,y,z) + update_chunk_center
		add_chunk(chunk_position)
		var chunk = get_chunk(chunk_position)
		if chunk != null:
			chunk.should_remove = false

func clean_up_chunks():
	for key in chunks:
		var chunk = chunks[key]
		if chunk.should_remove:
			chunk.queue_free()
			chunks.erase(key)

func reset_chunks():
	for key in chunks:
		chunks[key].should_remove = true

func get_chunk(chunk_position):
	var key = (str(chunk_position.x) 
	   + "," + str(chunk_position.y) 
	   + "," + str(chunk_position.z))
	if chunks.has(key):
		return chunks.get(key)
	return null
