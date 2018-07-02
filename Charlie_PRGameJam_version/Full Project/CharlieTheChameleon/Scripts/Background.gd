
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_fixed_process(true)

	
	
func _fixed_process(delta):
	set_pos(Vector2(get_node("../Player").get_pos().x,get_pos().y))


