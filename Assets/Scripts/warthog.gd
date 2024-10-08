extends AnimatedSprite2D

const SPEED = 60
var direction = -1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_down_2: RayCast2D = $RayCastDown2

func _process(delta: float) -> void:
	
	$".".play("move")
	
	if ray_cast_right.is_colliding():
		direction = -1
		$".".flip_h = true	
	elif ray_cast_left.is_colliding():
		direction = 1
		$".".flip_h = false
	elif not ray_cast_down.is_colliding():	
		direction = -1
		$".".flip_h = true	
	elif not ray_cast_down_2.is_colliding():
		direction = 1
		$".".flip_h = false	
		
		
			
	position.x += direction * SPEED * delta
