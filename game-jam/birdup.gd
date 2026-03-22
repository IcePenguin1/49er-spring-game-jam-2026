extends CharacterBody2D
@export var speed=100
var timer=3
var sleep=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sleep:
		var dirtoplayer=(position.direction_to(get_node("%player").position)).angle()
		rotation=(dirtoplayer)
		await get_tree().create_timer(1).timeout
		velocity=transform.x*Vector2(speed,speed)
		sleep=false
	move_and_slide()
	for i in get_slide_collision_count():
		var collision=get_slide_collision(i)
		if collision.get_collider().has_meta("ground"):
			queue_free()
	timer-=delta
	if timer <=0:
		queue_free()
	
	
	
