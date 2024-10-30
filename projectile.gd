extends Area2D

@export var speed = 200

var direction:Vector2

func set_direction(projectileDirection):
	direction = projectileDirection
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))
	
func _physics_process(delta):
	global_position += direction * speed * delta
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()
