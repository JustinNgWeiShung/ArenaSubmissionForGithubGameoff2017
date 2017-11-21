extends Control

var stageLock=false
var p1BarNode
var p2BarNode
var timer = 0.0
var ceilNode
var IO_SCRIPT = load("res://scripts/game/io_handler.gd")
var game_input
var STATE_HANDLER_SCRIPT = load("res://scripts/game/game_state_handler.gd")
var game_state
var p1
var p2
var ceilNodePos
var roundStartTime=3
var roundStart=false
var roundTime = 99
var roundTimer
var p1RoundCounter
var p2RoundCounter

var debugLabel 
var debugLabel2
var debugLabel3
var debugLabel4

var endRound = false
var gameOver=false
var gameOverPanel

func _ready():
	debugLabel = get_node("Debug")
	debugLabel2 = get_node("Debug2")
	debugLabel3 = get_node("Debug3")
	debugLabel4 = get_node("Debug4")
	
	#debugLabel.hide()
	#debugLabel2.hide()
	#debugLabel3.hide()
	#debugLabel4.hide()
	
	gameOverPanel = get_node("gameoverpanel")
	
	roundTimer = get_node("clock/VBoxContainer/timeLabel")
	
	game_input = IO_SCRIPT.new()
	game_input.test()
	
	game_state = STATE_HANDLER_SCRIPT.new()
	game_state.test()
	
	p1=get_node("Player1")
	p2=get_node("Player2")
	
	p1BarNode=get_node("p1VBox/p1Bar")
	p2BarNode=get_node("p2VBox/p2Bar")
	
	p1RoundCounter=get_node("p1RoundsLeft")
	p2RoundCounter=get_node("p2RoundsLeft")
	
	ceilNode=get_node("ceil1/collisionShape2d")
	ceilNodePos = ceilNode.get_pos()
	#To disable ceiling
	ceilNode.set_trigger(false)
	
	set_process(true)
	set_process_input(true)
	
	pass
	
func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_RIGHT):
			var name = GLOBAL_SYS.getPlayerName();
			print(name);
			var power = Globals.get("MAX_POWER_LEVEL");
			print(power);
			get_tree().set_input_as_handled()
	pass

func _debug(delta):
	if(GLOBAL_SYS.debug):
		debugLabel.set_text(str(p1.get_pos().x,",",p1.get_pos().y,",",p1.height,",",p1.currentJumpPower))
		#debugLabel2.set_text(p1.state.charState.check())
		#debugLabel3.set_text(p2.state.check())
		debugLabel2.set_text(str(p1.get_z()))
		
		debugLabel3.set_text(str(p2.get_pos().x,",",p2.get_pos().y,",",p2.height,",",p2.currentJumpPower))
		debugLabel4.set_text(str(p2.get_z()))

func _checkGameOver():
	if(GLOBAL_SYS.p1WinRound>=2 && GLOBAL_SYS.p2WinRound>=2):
		gameOverPanel.show()
		GLOBAL_SYS.matchWonBy="draw"
		TRANSITION.fade_to(GLOBAL_SYS.CHAR_SELECT_SCENE_NAME)
		GLOBAL_SYS.p1WinRound=0
		GLOBAL_SYS.p2WinRound=0
		gameOver=true
	elif(GLOBAL_SYS.p1WinRound>=2):
		gameOverPanel.show()
		GLOBAL_SYS.matchWonBy="p1"
		TRANSITION.fade_to(GLOBAL_SYS.CHAR_SELECT_SCENE_NAME)
		GLOBAL_SYS.p1WinRound=0
		GLOBAL_SYS.p2WinRound=0
		gameOver=true
	elif(GLOBAL_SYS.p2WinRound>=2):
		gameOverPanel.show()
		GLOBAL_SYS.matchWonBy="p2"
		TRANSITION.fade_to(GLOBAL_SYS.CHAR_SELECT_SCENE_NAME)
		GLOBAL_SYS.p1WinRound=0
		GLOBAL_SYS.p2WinRound=0
		gameOver=true
	
func _process(delta):
	if(gameOver):
		return
		
	gameOverPanel.hide()
	if(endRound):
		return
		
	_checkRoundStart(delta)
	if(_checkRoundEnd(delta)):
		_handle_round_end()
		
	_roundCounterSet(delta)
	_debug(delta)
	_effectCheck()
	
	if(Input.is_key_pressed(KEY_M) && !stageLock):
		print("Test M")
		#Jump level code
		#GLOBAL_SYS.currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1);
		#GLOBAL_SYS.setScene(GLOBAL_SYS.CHAR_SELECT_SCENE_NAME);
	
	stageLock=Input.is_key_pressed(KEY_M)
	
	GLOBAL_INPUT.setDebug()
	GLOBAL_INPUT.quitGame()
	
	_checkGameOver()

	pass
	
func _roundCounterSet(delta):
	var p1TextCounter = ""
	for i in range(GLOBAL_SYS.p1WinRound):
		p1TextCounter += "|"
		
	p1RoundCounter.set_text(p1TextCounter)
	
	var p2TextCounter = ""
	for i in range(GLOBAL_SYS.p2WinRound):
		p2TextCounter += "|"
		
	p2RoundCounter.set_text(p2TextCounter)

func _updatePlayersLife():
	var p1Life = p1.getLife()
	var p2Life = p2.getLife()
	
	p1BarNode.set_value(p1Life)
	p2BarNode.set_value(p2Life)

func _checkRoundStart(delta):
	roundStartTime-=delta
	if(roundStartTime<0):
		roundStartTime=0;
		roundStart=true
		
	if(roundStart):
		roundTime-=delta
	roundTimer.set_text(str(ceil(roundTime)))
	
func _checkRoundEnd(delta):
	if(roundTime <0):
		#timeup
		roundTime =0
		return true
		
	var p1Life = p1.getLife()
	var p2Life = p2.getLife()
	_updatePlayersLife()
	
	if(p1Life<=0):
		return true
	elif(p2Life<=0):
		return true
	
	return false
	
func _handle_round_end():
	var p1Life = p1.getLife()
	var p2Life = p2.getLife()	
	if(p1Life == p2Life):
		#declare draw
		_handle_round_draw()
	elif(p1Life>0 && p2Life <=0):
		#p1 won
		_handle_round_p1Win()
	elif(p1Life<=0 && p2Life >0):
		#p2 won
		_handle_round_p2Win()
	pass

func _handle_round_p1Win():
	GLOBAL_SYS.p1WinRound+=1
	_restart()
	pass

func _handle_round_p2Win():
	GLOBAL_SYS.p2WinRound+=1
	_restart()
	pass
	
func _handle_round_draw():
	GLOBAL_SYS.p1WinRound+=1
	GLOBAL_SYS.p2WinRound+=1
	_restart()
	pass

func _restart():
	TRANSITION.fade_to(GLOBAL_SYS.GAME_SCENE_NAME)
	endRound=true

func _effectCheck():
	GLOBAL_INPUT.changeEffect();
	
	if(GLOBAL_SYS.effect == 0):
		get_node("overlay").hide()
	else:
		get_node("overlay").show()
		
