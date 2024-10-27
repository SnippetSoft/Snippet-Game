class_name Player extends CharacterBody2D

@export var inputEnabled:bool = true
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var navAgent = $NavigationAgent2D as NavigationAgent2D

var clickPos = Vector2()
var lastPos = Vector2()
var lastPos2 = Vector2()

var move_dir = Vector2()
const SPEED = 75.0

func _ready():
	clickPos = position

func _physics_process(delta):
	if position.distance_to(clickPos) > 1:
		var dir = to_local(navAgent.get_next_path_position()).normalized()
		velocity = dir * SPEED
		move_and_slide()
		# Temporary, just because I keep getting stuck on walls.
		if lastPos2 == position:
			clickPos = position
			animatedSprite.play("idle")
		else:
			lastPos2 = lastPos
			lastPos = position
	
	#if position.distance_to(clickPos) > 1:
		#targetPos = (clickPos - position).normalized()
		#velocity = targetPos * SPEED
		#move_and_slide()
		#if position.distance_to(clickPos) <= 1:
			#print(clickPos - position)

func makepath(targetPos):
	navAgent.target_position = targetPos

func _input(event):
	if inputEnabled and Input.is_action_just_pressed("ui_leftMouseClick"):
		clickPos = get_global_mouse_position()
		if clickPos.y > 16:
			animatedSprite.play("move")
			makepath(clickPos)

func disable():
	inputEnabled = false
	
func enable():
	inputEnabled = true
	visible = true


func _on_navigation_agent_2d_target_reached() -> void:
	animatedSprite.play("idle")
