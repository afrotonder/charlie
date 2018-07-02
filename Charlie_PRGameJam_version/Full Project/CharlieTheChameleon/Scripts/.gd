# Walking Attack Fix
#Try to figure out the air atk
extends RigidBody2D

var inputStates = preload("res://Scripts/InputStates.gd")
var toungue = preload("res://Toungue.xml")
var tArray = []

# Movement
var Charlie_Speed = 200 # Charlie Default speed
var acceleration = 5
var air_acceleration = 2
var Current_Speed = Vector2(0,0) 

var PLAYERSTATE_PREV = ""
var PLAYERSTATE = ""
var PLAYERSTATE_NEXT = "ground"

# Delay
var TimeLeft = 5
var runCond = 1

# Physics
var CharliePos = get_pos()
var extra_gravity = 400
var JumpForce = 300
var RayCastDown = null
var Tcount = 0

# Input
var btn_Right = inputStates.new("CharlieRight")
var btn_Left = inputStates.new("CharlieLeft")
var btn_X = inputStates.new("CharlieJump")
var atkLeft = inputStates.new("CharlieAtk")

func move(speed, acc, delta):
	Current_Speed.x = lerp(Current_Speed.x, speed, acc * delta)
	set_linear_velocity(Vector2(Current_Speed.x, get_linear_velocity().y))
	
func IsOnGround():
	if RayCastDown.is_colliding():
		return true
		
	else:
		return false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	RayCastDown = get_node("RayCast2D")
	RayCastDown.add_exception(self)
	
	set_fixed_process(true)
	set_applied_force(Vector2(0,extra_gravity))
	
func _fixed_process(delta):
	PLAYERSTATE_PREV = PLAYERSTATE
	PLAYERSTATE = PLAYERSTATE_NEXT
	
	if PLAYERSTATE == "ground":
		groundState(delta)
	
	elif PLAYERSTATE == "air":
		airState(delta)
		
	#for t in tArray:
		#var Tpos = get_node(t).get_pos()
		#Tpos.x = Tpos + 50
		#get_node(t).set_pos(Tpos)
	
	TimeLeft = TimeLeft - delta
	

	# Are Left or Right being pressed.

func groundState(delta):
	
	if btn_Right.check() == 2: # If Right is pressed:
		get_node("AnimatedSprite").set_flip_h(false)
		
		if atkLeft.check() == 2:
			get_node("AnimatedSprite").runAtk(delta)
		
		else:	
			get_node("AnimatedSprite")._process(delta)
		
		move(Charlie_Speed, acceleration, delta)
		
	elif btn_Left.check() == 2: # If Left is pressed:
		get_node("AnimatedSprite").set_flip_h(true)
		get_node("AnimatedSprite")._process(delta)
		
		move(-Charlie_Speed,acceleration, delta)
		
	elif atkLeft.check() == 2:
		if runCond:
			Tcount = Tcount + 1
			var toungueInst = toungue.instance()
			toungueInst.set_name("t" + str(Tcount))
			add_child(toungueInst)
			var Tpos = get_node("t"+str(Tcount)).get_pos()
			Tpos.x = CharliePos.x
			Tpos.y = CharliePos.y
			get_node("t"+str(Tcount)).set_pos(Tpos)
			tArray.push_back("t"+str(Tcount))
			#print (tArray)
			get_node("AnimatedSprite").Atk(delta)
			
		
		
	
	
	else: # If nothing is pressed:
		runCond = 1
		if (get_node("AnimatedSprite").is_flipped_h() and TimeLeft < 0):
			
			get_node("AnimatedSprite").Rest(delta)
		elif(not get_node("AnimatedSprite").is_flipped_h() and TimeLeft < 0):
			get_node("AnimatedSprite").Rest(delta)
		TimeLeft = TimeLeft - delta
		
		move(0, acceleration, delta)
	
	if IsOnGround():
		if btn_X.check() == 1:
			set_axis_velocity(Vector2(0,-JumpForce))
			
	else:
		PLAYERSTATE_NEXT = "air"
		get_node("AnimatedSprite").Jump(delta)

func airState(delta):
	runCond = 1
	if btn_Right.check() == 2: # If Right is pressed:
		get_node("AnimatedSprite").set_flip_h(false)
		get_node("AnimatedSprite")._process(delta)
		move(Charlie_Speed, air_acceleration, delta)
		
	elif btn_Left.check() == 2: # If Left is pressed:
		get_node("AnimatedSprite").set_flip_h(true)
		get_node("AnimatedSprite")._process(delta)
		move(-Charlie_Speed, air_acceleration, delta)
	
	else: # If nothing is pressed:
		get_node("AnimatedSprite").set_animation("Rest")
		
		if (get_node("AnimatedSprite").is_flipped_h() and TimeLeft < 0):
			
			get_node("AnimatedSprite").Rest(delta)
		elif(not get_node("AnimatedSprite").is_flipped_h() and TimeLeft < 0):
			get_node("AnimatedSprite").Rest(delta)
		TimeLeft = TimeLeft - delta
		move(0, air_acceleration, delta)
		
	
		
	if IsOnGround():
		PLAYERSTATE_NEXT = "ground"

	else:
		get_node("AnimatedSprite").Jump(delta)
	

