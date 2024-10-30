extends Sprite2D

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null:
		self.visible = true
		self.position = lerp(position, target, 0.1)
		if position.distance_to(target) < 0.1:
			target = null
	else:
		self.visible = false
