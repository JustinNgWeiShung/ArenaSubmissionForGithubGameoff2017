# Global System functions
extends Node

var gameState
var currentScene
var CHAR_SELECT_SCENE_NAME="res://stages/char_select.tscn"
var TITLE_SCENE_NAME="res://stages/title.tscn"
var GAME_SCENE_NAME="res://stages/game.tscn"
var P1CHAR="p1"
var P2CHAR="p2"
var p1_char="p1"
var p2_char="p2"
var effect = 0;
var debug = false
var p1WinRound=0
var p2WinRound=0
var p2ModeEnable=false
var matchWonBy="none"
var gameTransitionNumber=0

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1);
	#Globals.set("MAX_POWER_LEVEL",9000)
	
func setScene(scenePath):
	currentScene.queue_free()
	var s = ResourceLoader.load(scenePath)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)

func changeEffect():
	effect+=1;
	if(effect>1):
		effect=0;