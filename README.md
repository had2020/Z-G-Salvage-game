# Z-G-Salvage-game
A Godot 4 Game, Zero Gravity, Io like game

--------------------------------------------
By: Hadrian Lazic Date: 12/10/23
--------------------------------------------
Video Presentation at the end of page, and heavy code analysis available
--------------------------------------------
Itch.io page 
[
](https://had2023.itch.io/z-g-salvagers)
--------------------------------------------

# what is it
Z-G Salavge is a Godot 4 video game, the game is 2D and has a unique set of rules, it is a mix between a IO game and a space game.

<img width="578" alt="Screenshot 2023-12-10 at 12 12 17 PM" src="https://github.com/had2020/Z-G-Salvage-game/assets/59424667/46b84587-cb14-4245-b676-12554758cf69">

--------------------------------------------

# how the game works
The player controls a orb on the screen with W, A, S, and D keys in order to move. When the player moves there ship moves in space, 
but with some drag. The player must use a basic understanding of how space works in order to dodge, floating spikes. The player has a portal 
it works as a shield, but as the player speed up it grows, this creates a problem, since the player is speed ripidly up in a low-friction space,
this makes it harder to dodge spikes in groups. When the player kills a spike by moving there shield, witch is controlled by moving the player's
cursor around, if hit an enemy with your growing shield the enemy dies and respawns, somewhere random around the map, but when you kill an enmey 
the player will grow making harder to dodge enemies, and this will need a bigger shield, meaning you have to speed up, making dodging even harder.

--------------------------------------------

# Code analysis

- Main scene Tree
  <img width="265" alt="Screenshot 2023-12-10 at 12 29 03 PM" src="https://github.com/had2020/Z-G-Salvage-game/assets/59424667/d1c5dd7b-ee32-499c-84de-bdff9e2d7d3f">

-Player / Rigidbody Node
It defines a class that inherits from RigidBody2D, a node that represents a 2D physics object that can collide and move according to forces.
The class has four @export variables: thrust, max_speed, damping, and input_up, input_down, input_left, and input_right. They store the force applied to the body when accelerating, the maximum speed of the body, the damping factor that reduces the body’s velocity over time, and the input actions for controlling the body, respectively. They can be modified in the editor.
The class has one function: _physics_process. This is a built-in function that is called every physics frame. It takes a parameter named delta that represents the elapsed time since the previous frame.
The _physics_process function does the following:
It calculates a times_factor by multiplying the global variable Globals.score by 0.1. This is a value that modifies the body’s scale based on the score.
It creates a vector named myscale with the values 1 and 1 and multiplies it by the times_factor. This represents the body’s scale in the x and y axes.
It sets the body’s scale to the new myscale vector. This updates the body’s appearance in the scene.
It uses the look_at method to make the body look at the global mouse position. This means that the body rotates to face the mouse cursor.
It rotates the body by 90 degrees using the rotate method and the deg_to_rad function. This adjusts the body’s orientation.
It gets the input vector from the keyboard using the Input class and the get_action_strength method. The input vector is a value between -1 and 1 that indicates how much the input action is pressed. The input vector is normalized to have a length of 1.
It applies a force to the body in the direction of its rotation using the apply_central_force method. The force is calculated by rotating the Vector2.UP vector by the body’s rotation and multiplying it by the input vector’s y component and the thrust.
It applies a torque to the body to make it rotate using the apply_torque method. The torque is calculated by multiplying the input vector’s x component by the body’s angular velocity and negating it.
It limits the body’s speed to the maximum value using the linear_velocity property and the length and normalized methods. The speed is a scalar value that represents the magnitude of the linear velocity vector.
It applies a damping factor to the body’s velocity using the linear_velocity property and the *= operator. The damping factor is a value between 0 and 1 that reduces the velocity over time.

-Enemy
It defines a class that inherits from RigidBody2D, a node that represents a 2D physics object that can collide and move according to forces.
The class has four constants: MAX_SPEED, MAX_FORCE, timer, and raycast. They store the maximum speed and force of the RigidBody2D, and the references to the timer and raycast nodes that are children of the RigidBody2D.
The class has a variable named enemy that preloads a scene resource that contains an enemy node.
The class has four functions: respawn, _on_timer_timeout, _integrate_forces, and _on_area_2d_area_entered. These are user-defined functions that perform specific tasks.
The respawn function does the following:
It increases the global variable Globals.score by 1.
It instantiates a new enemy node from the enemy resource and assigns it to a variable named node.
It sets the node’s position to a random vector within a range of (1000, 0) and (0, 0).
It adds the node as a child of the root node of the scene tree.
It frees the current node from the scene tree.
The _on_timer_timeout function is called when the timer node reaches its timeout. It does the following:
It generates a random vector for the force or impulse and normalizes it to have a length of 1.
It applies a central force or impulse to the RigidBody2D using the random vector multiplied by the MAX_FORCE. It can use either the apply_central_force or the apply_central_impulse method, but not both at the same time. The difference is that a force is continuous and an impulse is instantaneous.
It checks if the RigidBody2D is on the ground using the raycast node. If so, it applies a vertical force or impulse to make the RigidBody2D jump.
The _integrate_forces function is a built-in function that is called every physics frame. It takes a parameter named state that represents the current state of the RigidBody2D. It does the following:
It limits the speed of the RigidBody2D by clamping its linear velocity vector to a range of (-MAX_SPEED, -MAX_SPEED) and (MAX_SPEED, MAX_SPEED).
The _on_area_2d_area_entered function is a signal that is emitted when another Area2D node enters the area of the RigidBody2D. It takes a parameter named area that represents the other node. It does the following:
It checks if the area node is in a group named “Boom”. If so, it calls the respawn function. This means that the RigidBody2D is killed when it is inside the mouse boom of doom.

-Enemies
It defines a class that inherits from Node2D, a node that represents a 2D object in a scene.
The class has an @onready variable named scene_res that preloads a scene resource from the given path. The scene resource is a file that contains a node hierarchy and other data for a scene.
The class has three variables: count, radius, and center. They store the number of enemies to spawn, the radius of the circular area where the enemies are spawned, and the center of the circular area, respectively. They are initialized to 10, (1000, 0), and (0, 0). The class has another variable named step that calculates the angle between each enemy on the circle. It is equal to 2 * PI / count, where PI is a constant that represents the ratio of a circle’s circumference to its diameter. The class has two functions: _ready and spawn_nodes. These are user-defined functions that perform specific tasks.
The _ready function is called when the node is added to the scene tree. It sets the count to 200 for the first batch of enemies, and calls the spawn_nodes function.
The spawn_nodes function spawns the enemies based on the count around the center point. It does the following:
It loops through the range of count using a variable named i.
It calculates the spawn position of each enemy by adding the radius vector rotated by the step angle multiplied by i to the center vector. This creates a circular pattern of enemies around the center.
It instantiates a new node from the scene_res resource and assigns it to a variable named node.
It sets the node’s position to the spawn position.
It adds the node as a child of the current node.
It prints the message “spawn func ran” to the console for debugging purposes. This line is commented out and will not execute.

-Mouse Boom / Area 2D
It defines a class that inherits from Node2D, a node that represents a 2D object in a scene.
The class has two variables: input_up and input_down, which store the names of the input actions that control the node’s growth. It also has an @export variable named change_rate of type float that can be modified in the editor. It determines how fast the node’s growth changes over time.The class has another variable named stored_change of type float that stores the current growth factor of the node. It is initialized to 1.
The class has one function: _process. This is a built-in function that is called every frame. It takes a parameter named delta that represents the elapsed time since the previous frame.
The _process function does the following: It calculates the growth_factor by subtracting the input strength of input_down from the input strength of input_up. The input strength is a value between 0 and 1 that indicates how much the input action is pressed. The growth_factor is a value between -1 and 1 that determines how much the node grows or shrinks.
If the growth_factor is 0, it resets the stored_change to 1. This means that the node stops changing its size.
It sets the node’s position to the global mouse position. This means that the node follows the mouse cursor.
It creates a vector named myscale with the values 0.5 and 0.5. This represents the node’s scale in the x and y axes.
It calculates the times_factor by adding the growth_factor to the product of the growth_factor and the stored_change. This is a value that modifies the node’s scale based on the input and the stored change.
It multiplies the myscale vector by the times_factor. This changes the node’s scale according to the input and the stored change.
It sets the node’s scale to the new myscale vector. This updates the node’s appearance in the scene.
It increases the stored_change by the change_rate. This makes the node’s growth change faster over time.
It checks if the stored_change is equal to 10000. If so, it resets it to 1. This prevents the node’s growth from becoming too large or too small.

-Health 
defines a class that inherits from Area2D, a node that represents a 2D area that can detect collisions with other nodes.
The class has a variable named health of type float that stores the current health of the node. It is initialized to 100.
The class has two functions: _on_body_entered and _on_timer_timeout. These are signals that are emitted when certain events occur.
The _on_body_entered function is called when another body (such as a KinematicBody2D or a RigidBody2D) enters the area of the node. It prints the message “player hit” to the console, and reduces the health by a random value between 5 and 25. It also updates the global variable Globals.health with the new value of health. If the health becomes less than or equal to 0, it sets the global variable Globals.score to 1, and reloads the current scene using the get_tree function. The _on_timer_timeout function is called when a Timer node that is a child of the node reaches its timeout. It increases the health by a random value between 1 and 20.

-Laser
Not used in game, and empty 

-Camera / Camera Node with some extra code
It defines a class that inherits from Camera2D, a node that represents a 2D camera that displays a portion of the scene.
The class has six variables: zoomspeed, zoommargin, zoomMin, zoomMax, zoompos, and zoomfactor. They store the effects of zoom speed and smoothness, the zoom limits, the current mouse position, and the current zoom factor, respectively. They are initialized to 100, 0.5, 0.3, 6, (0, 0), and 1.0.
The class has two functions: _process and _input. These are built-in functions that are called every frame and every input event, respectively. They take a parameter named delta and event that represent the elapsed time and the input event, respectively.
The _process function does the following:
It interpolates the zoom values of the camera in the x and y axes using the lerp function, the zoom property, the zoomfactor, and the zoomspeed.
It clamps the zoom values of the camera in the x and y axes to the range of zoomMin and zoomMax using the clamp function and the zoom property.
The _input function does the following:
It resets the zoomfactor to 1.0 if the absolute difference between the zoompos and the global mouse position is greater than the zoommargin in either the x or y axis. This means that the camera stops zooming if the mouse moves too far from the previous position.
It checks if the event is an instance of the InputEventMouseButton class using the is operator. If so, it checks if the event is pressed using the is_pressed method. If so, it does the following:
It decreases the zoomfactor by 0.01 if the event’s button index is equal to the constant MOUSE_BUTTON_WHEEL_UP. This means that the camera zooms in when the mouse wheel is scrolled up.
It increases the zoomfactor by 0.01 if the event’s button index is equal to the constant MOUSE_BUTTON_WHEEL_DOWN. This means that the camera zooms out when the mouse wheel is scrolled down.
It updates the zoompos to the global mouse position using the get_global_mouse_position function. This means that the camera zooms relative to the current mouse position.

--------------------------------------------
# Video Presentation

[https://www.youtube.com/watch?v=ZMj96BteC50](https://www.youtube.com/watch?v=ZMj96BteC50)
