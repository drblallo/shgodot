extends Sprite2D

var index 
@export var marine_texture : Texture2D
@export var alien_texture : Texture2D
var unit_size = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if index == null:
		self.visible = false
		return

	visible = true
	var lib = get_parent().lib
	var state = get_parent().state as RLCGame
	var current_unit_size = lib.size(state.get_board().get_units())
	
	if lib.size(state.get_board().get_units()) <= index:
		self.visible = false
		return
	var is_marine = (lib.get(state.get_board().get_units(), index) as RLCUnit).get_kind().get_value() == 1
	if is_marine:
		#modulate = Color.RED
		texture = marine_texture
	else:
		texture = alien_texture
		#modulate = Color.PURPLE
	var x = (lib.get_character_x(state.get_board(), index)) * 31
	var y = (lib.get_character_y(state.get_board(), index)) * 31
	if unit_size == current_unit_size:
		self.position = lerp(self.position, Vector2(x, y), 0.1)
	else:
		self.position = Vector2(x, y)
	unit_size = current_unit_size
