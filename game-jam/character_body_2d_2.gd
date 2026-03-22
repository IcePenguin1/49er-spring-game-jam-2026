extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var timer=100
var change=1
var jumps=0
var is_dead=false

func _ready() -> void:
	get_node("CollisionShape2D/AnimatedSprite2D").play("spawn")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if get_node("CollisionShape2D/AnimatedSprite2D").is_playing():
			get_node("CollisionShape2D/AnimatedSprite2D").play("jump")
	else:
		get_node("CollisionShape2D/AnimatedSprite2D").play("idle")
		timer=timer-1
		if timer<0:
			velocity.y+=JUMP_VELOCITY
			
			var directiontoplayer = position.direction_to(get_node("../player").position)
			if directiontoplayer.x>0:
				change=1
			else:
				change=-1
			velocity.x+=50*change
			timer=100
			jumps+=1
			if jumps==3:
				await get_tree().create_timer(2.5).timeout
				queue_free()
		else:
			velocity.x=0
		
		if is_dead:
			var char = get_node("../player")
			char.velocity.y=-600
			queue_free()
		

	move_and_slide()
