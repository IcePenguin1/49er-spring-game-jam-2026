extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collisions = get_overlapping_bodies()
	for col in collisions:
		if col.has_meta("player") and Input.is_action_just_pressed("pressE"):
			col.cards.append("slimCard")
			get_parent().queue_free()
