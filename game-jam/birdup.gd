extends CharacterBody2D
@export var speed=100
var timer=3
var sleep=true
var is_dead=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("CollisionShape2D/AnimatedSprite2D").play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sleep:
		var dirtoplayer=(get_node("../player").position-position).angle()
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
	if is_dead:
		var char = get_node("../player")
		if char.facing_right:
			char.velocity.x+=600
		else:
			char.velocity.x-=600
		queue_free()
	

	
	
	
