extends KinematicBody2D
const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTION = 10

#basically Vector2 is used to represent position in x and y
#Vector2.ZERO basically means default value of both x and y is 0

var velocity = Vector2.ZERO

#delta is basically time elasped from the last frame
#PRO_TIP-if something in our code changes over time and is connected to framerates multiply it by delta
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#so normally the diagonal distance is more as compared to straight distace.
	#normalised just makes that distance equal so that our character moves in all direction at the same speed
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED*delta)
	else:
		#We took the velocity gave it this function move towards
		#move towards basically adds friction then we gave it two parameters
		#a vector and another friction which is tied to the framerates by delta
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)	
		
#multiplied delta because if the frame drops our velocity will increase
#by that much factor
#changed later since already multiplied maxspeed with delta in line 25
	move_and_collide(velocity)   
