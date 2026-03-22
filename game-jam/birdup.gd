extends CharacterBody2D
@export var speed=300
var timer=3
var is_dead=false
var sleep=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("CollisionShape2D/AnimatedSprite2D").play()
	
	await get_tree().create_timer(1).timeout
	velocity=transform.x*Vector2(speed,speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sleep: 
		var dirtoplayer=(get_node("../player").global_position-global_position).angle()
		rotation=(dirtoplayer)
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
			char.velocity.x+=1000
		else:
			char.velocity.x-=1000
		queue_free()
	

	
	
	
