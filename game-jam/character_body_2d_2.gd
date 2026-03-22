extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var timer=0
var change=1
var jumps=0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
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
	
		

	move_and_slide()
