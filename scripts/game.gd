extends Node2D

var lib = RLCLib.new()
var state = lib.play() 
var trace
var current = 0
var frame = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var char = get_child(2)
	var i = 0
	while i != 29:
		var j = 0
		while j != 28:
			if lib.is_wall(state.get_board(), i, j):
				j = j + 1
				continue
			var new_node = get_child(1).duplicate() as Sprite2D
			add_child(new_node)
			new_node.position = (Vector2((new_node.transform.get_scale().x + 1) * i, (new_node.transform.get_scale().y + 1) * j))
			new_node.y = j
			new_node.x = i
			j = j + 1
	
		i = i + 1
		
	i = 0
	while i!= 30:
		var new_node = char.duplicate() as Sprite2D
		new_node.index = i
		add_child(new_node)
		i = i + 1
	trace = RLCVectorTalt_GamePlaceBlip_or_GameBeginMove_or_GameTurn_or_GameMove_or_GameEndMove_or_GameShoot_or_GameRollDice_or_GameDoNothing_or_GameOverwatch_or_GameGuard_or_GameAssault_or_GameGuardReroll_or_GameFaceAttacker_or_GameClearJamming_or_GameToggleDoor_or_GamePassTurn_or_GameQuitT.make()
	lib.load_action_vector_file(lib.s("/home/massimo/file.txt"), trace)


	pass # Replace with function body.


func next():
	if current == lib.size(trace):
		return

	if not lib.can_apply(lib.get(trace, current), state) :
		print("could not appl")
		return
	var current_action = lib.get(trace, current)
	var action = current_action.get_GameShoot() as RLCGameShoot
	if action:
		var target_index = action.get_target_id().get_value()
		var x = (lib.get_character_x(state.get_board(), target_index)) * 31
		var y = (lib.get_character_y(state.get_board(), target_index)) * 31
		get_child(4).target = Vector2(x, y)
		
		target_index = action.get_unit_id2().get_value()
		x = (lib.get_character_x(state.get_board(), target_index)) * 31
		y = (lib.get_character_y(state.get_board(), target_index)) * 31
		
		
		get_child(4).position = Vector2(x, y)
		
	lib.apply(current_action, state)
	get_child(3).text = lib.convert_string(lib.to_string(lib.get(trace, current)))

	current = current + 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame = frame + 1
	if frame % 15 == 0 and Input.is_action_pressed("ui_accept"):
		next()
	pass
	
