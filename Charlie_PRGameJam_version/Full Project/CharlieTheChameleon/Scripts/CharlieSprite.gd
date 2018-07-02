
extends AnimatedSprite

var TimeElapsed = 0
var tim = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
	
func _process(delta):
	TimeElapsed = TimeElapsed + delta
	set_animation("Walk")
	
	if TimeElapsed > 0.1:
			if(get_frame() == get_sprite_frames().get_frame_count("Walk") - 1):
				set_frame(0)
			
			else:
				self.set_frame(get_frame() + 1)
			
			
			TimeElapsed = 0
			
func Rest(delta):
	
	set_animation("Rest")
	
	if(get_frame() == get_sprite_frames().get_frame_count("Rest") -1 ):
		set_frame(0)
		get_node("..").TimeLeft = 5
		
	else:
		set_frame(get_frame() + 1)
	

func Jump(delta):
	set_animation("Jump")
	
func Atk(delta):
	set_animation("Atk")
	
	if(get_frame() == get_sprite_frames().get_frame_count("Atk") - 1):
				set_frame(0)
				get_node("..").runCond = 0
			
	else:
		self.set_frame(get_frame() + 1)
	
func Atk_air(delta):
	set_animation("AtkAir")
	
	if(get_frame() == get_sprite_frames().get_frame_count("AtkAir") - 1):
				set_frame(0)
				get_node("..").runCond = 0
			
	else:
		self.set_frame(get_frame() + 1)
	
func runAtk(delta):
	set_animation("AtkRun")
	
	if(get_frame() == get_sprite_frames().get_frame_count("AtkRun") - 1):
				set_frame(0)
				get_node("..").runCond = 0
	
	
	
	


	


