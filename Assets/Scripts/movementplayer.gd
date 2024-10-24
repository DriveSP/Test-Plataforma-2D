extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim_tree: AnimationTree = %AnimationTreePlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum {IDLE, RUN}
var currentAnim;

func _physics_process(delta: float) -> void:
	
	animations_manager()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		velocity.x = direction * SPEED
		$PlayerSprite.flip_h = false
	elif direction < 0:
		velocity.x = direction * SPEED
		$PlayerSprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction == 0:
			currentAnim = IDLE
		else:
			currentAnim = RUN
	else:
		jump()
	move_and_slide()

func animations_manager():
	match currentAnim:
		IDLE:
			anim_tree.set("parameters/Movement/transition_request", "Idle")
		RUN:
			anim_tree.set("parameters/Movement/transition_request", "Running")
			
func jump():
	anim_tree.set("parameters/Jump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func attack():
	anim_tree.set("parameters/Attack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
