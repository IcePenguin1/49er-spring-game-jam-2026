extends CharacterBody2D
var timer = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("CollisionShape2D/AnimatedSprite2D").play()
	if get_node("../player").facing_right :
		scale.x=-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer-=delta
	if timer<=0:
		queue_free()
