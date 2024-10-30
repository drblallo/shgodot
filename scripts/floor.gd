extends Sprite2D

var x
var y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if x == null:
		self.visible = false
	var lib = get_parent().lib
	var state = get_parent().state

	
	if lib.is_closed_door(state.get_board(), x, y):
		modulate = Color.BLACK
	elif lib.is_spawn_point(state.get_board(), x, y):
		modulate = Color.DARK_BLUE
	else:
		modulate = Color.GRAY

