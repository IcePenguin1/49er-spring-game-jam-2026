extends CharacterBody2D
var cards=[]
@export
var SPEED = 50.0
@export
var JUMP_VELOCITY = -400.0
@export
var spawn_point = Vector2(0, 0)
@export
var attack_cooldown = 0.5
var selected = 1
var facing_right = true
var attacking = false;
var time = 0
var aim_length: float = 30
var mouseDirection=Vector2(0,0)
var currentCardNum = 0
var slime = load("res://Enemy.tscn")
var bird = load("res://birdup.tscn")
var sug = load("res://sug.tscn")

func _ready() -> void:
	get_node("%PlayerAnimations").play("default")
	get_node("%PlayerAnimations").offset.x = 0
	get_node("%PlayerAnimations").offset.y = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x,direction * SPEED,40)
	else:
		velocity.x = move_toward(velocity.x, 0, 40)
	
	if Input.is_action_pressed("up") and Input.is_action_just_pressed("attack") and !attacking:
		self.get_node("attack_up").set_process(true)
		attacking = true
		get_node("%PlayerAnimations").play("attack_up")
		get_node("%PlayerAnimations").offset.y = -15
	elif Input.is_action_pressed("down") and Input.is_action_just_pressed("attack") and !attacking:
		self.get_node("attack_down").set_process(true)
		attacking = true
		get_node("%PlayerAnimations").play("attack_down")
		get_node("%PlayerAnimations").offset.y = 15
	elif Input.is_action_just_pressed("attack") and !attacking:
		self.get_node("attack_front").set_process(true)
		attacking = true
		get_node("%PlayerAnimations").play("attack_forward")
		get_node("%PlayerAnimations").offset.x = 32
	elif attacking:
		time += delta
		if(time >= attack_cooldown):
			attacking = false
			self.get_node("attack_front").set_process(false)
			self.get_node("attack_up").set_process(false)
			self.get_node("attack_down").set_process(false)
			get_node("%PlayerAnimations").play("default")
			get_node("%PlayerAnimations").offset.x = 0
			get_node("%PlayerAnimations").offset.y = 0
			time = 0
	

	mouseDirection = global_position - get_global_mouse_position();
	get_node("Aim").global_position = global_position + (mouseDirection.normalized() * -aim_length);
	if sign(direction) > 0:
		if !facing_right:
			get_node("attack_front").position += Vector2(40, 0)
			get_node("Aim").position *= -1
		if sign(get_node("%PlayerAnimations").scale.x) < 0:
			get_node("%PlayerAnimations").scale.x *= -1
		facing_right = true
	if sign(direction) < 0:
		if facing_right:
			get_node("attack_front").position -= Vector2(40, 0)
			get_node("Aim").position *= -1
		if sign(get_node("%PlayerAnimations").scale.x) > 0:
			get_node("%PlayerAnimations").scale.x *= -1
		facing_right = false
	move_and_slide()
	for i in get_slide_collision_count():
		var collision=get_slide_collision(i)
		if collision.get_collider().has_meta("enemy"):
			if get_tree() :
				get_tree().reload_current_scene()
			
	#if you have cards, do card stuff
	var card = get_node("Camera2D/cardSelected")
	if (cards.size()!=0) :
		card.set_visible(true)
		card.set_process(true)
		if Input.is_action_just_pressed("pressQ"):
			if currentCardNum==cards.size()-1 :
				currentCardNum=0
			else:
				currentCardNum+=1
		if Input.is_action_just_pressed("summon"):
			get_node("Aim").set_process(true)
		elif Input.is_action_pressed("summon"):
			aim_length += 100 * delta
		elif Input.is_action_just_released("summon"):
			selected = cards[currentCardNum]
			if selected == "birdCard" :
				var spawn = bird.instantiate()
				get_parent().add_child(spawn)
				spawn.position = get_node("Aim").global_position
			elif selected == "slimCard" :
				var spawn = slime.instantiate()
				get_parent().add_child(spawn)
				spawn.position = get_node("Aim").global_position
			elif selected == "sugCard" :
				var collisions = get_node("Aim/Area2D").get_overlapping_bodies()
				for col in collisions:
					if col.has_meta("ground"):
						var spawn = sug.instantiate()
						get_parent().add_child(spawn)
						if facing_right :
							spawn.position = get_node("Aim").global_position-Vector2(60,0)
						else :
							spawn.position = get_node("Aim").global_position+Vector2(60,0)

			
			aim_length = 30
			get_node("Aim").set_process(false)
		if not Input.is_action_pressed("summon"):
			aim_length = 30
	else :
		card.set_visible(false)
		card.set_process(false)
		
