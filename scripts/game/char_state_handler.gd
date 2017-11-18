var STATES={"IDLE":1,
			"STARTUP":2,
			"ATTACK":3,
			"RECOVER":4,
			"ATTACK_END":5,
			"JUMP":6,
			"JUMP_STARTUP":7,
			"JUMP_ATTACK":8,
			"JUMP_RECOVER":9,
			"JUMP_ATTACK_END":10,
			"BLOCK":11,
			"WALK":12,
			"RUN":13,
			"HURT":14,
			"DOWN":15,
			"GETUP":16}

var currentState
var player

func _init(player):
	self.player = player
	currentState=STATES.IDLE
	pass
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
