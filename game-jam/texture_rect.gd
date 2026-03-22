extends TextureRect
var selected=""
var birdSprite=load("res://Assets/birdCardSprite.png")
var slimeSprite=load("res://Assets/slimCardSprite.png")
var sugSprite=load("res://Assets/slugCardSprite.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var char=get_node("%player")
	if (char.cards.size()!=0) :
		selected = char.cards[char.currentCardNum]
		if selected == "birdCard" :
			texture=birdSprite
		elif selected == "slimCard" :
			texture = slimeSprite
		elif selected == "sugCard" :
			texture = sugSprite
		
		
