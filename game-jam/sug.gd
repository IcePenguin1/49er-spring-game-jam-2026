extends CharacterBody2D
var timer = 10
var sleep = true
var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("CollisionShape2D/AnimatedSprite2D").play()
	if get_node("../player").facing_right :
		get_node("CollisionShape2D/AnimatedSprite2D").rotation_degrees-=180
	await get_tree().create_timer(.04).timeout
	var collisions = get_node("SugArea2D").get_overlapping_bodies()
	for col in collisions:
		if col.has_meta("player"):
			queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer-=delta
	if timer<=0 or is_dead:
		queue_free()
	
