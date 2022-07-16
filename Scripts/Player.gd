extends KinematicBody2D

class_name Player

signal heal_resource_update(new_heal_resources)
signal treasure_update(treasure_found)

export var movementSpeed: int = 100
export var projectileScene: PackedScene
export var healing_projectile_scene: PackedScene
export var healing_area_scene: PackedScene

export var max_heal_resources: int = 250

var heal_resources: int = 0
var treasure_found: int = 0

var time: float
var last_time_healing_area: float
var last_time_thrown_heal: float

var near_chest: TreasureChest = null
var near_vase: Node2D = null

func _ready():
	$HealthBar.hide()
	time = 0

		
func restart_game():
	heal_resources = 0
	treasure_found = 0
	$HealthSystem.reset()

func get_movedir():
	var moveDir: Vector2 = Vector2(0,0)
	if(Input.is_action_pressed("ui_down")):
		moveDir += Vector2(0,1)
	if(Input.is_action_pressed("ui_up")):
		moveDir += Vector2(0,-1)
	if(Input.is_action_pressed("ui_left")):
		moveDir += Vector2(-1, 0)
	if(Input.is_action_pressed("ui_right")):
		moveDir += Vector2(1, 0)
	moveDir = moveDir.normalized()
	return moveDir
	
func set_anim(moveDir: Vector2):
	$AnimatedSprite.playing = true
	if(moveDir.x == 0 && moveDir.y == 0):
		$AnimatedSprite.animation = "Walk_Down"
		$AnimatedSprite.frame = 0
		$AnimatedSprite.playing = false	
		$FootstepSound.stop()
		return
		
	$FootstepSound.start()
		
	if(moveDir.x > 0):
		$AnimatedSprite.animation = "Walk_Right"
		return
	elif(moveDir.x < 0):
		$AnimatedSprite.animation = "Walk_Left"
		return
	if(moveDir.y > 0):
		$AnimatedSprite.animation = "Walk_Down"
		return
	elif(moveDir.y < 0):
		$AnimatedSprite.animation = "Walk_Up"
		return

func movement():
	var moveDir: Vector2 = get_movedir()
	set_anim(moveDir)
	return moveDir
	
func _physics_process(delta):
	move_and_slide(movement() * movementSpeed)
			
func spawn_healing_area():
	if heal_resources < 50:
		return
	if Input.is_key_pressed(KEY_1):
		if time - last_time_healing_area > 1:
			var ha: Node2D = healing_area_scene.instance()
			ha.position = get_global_mouse_position()
			get_tree().get_root().add_child(ha)
			last_time_healing_area = time
			heal_resources -= 50
			emit_signal("heal_resource_update", heal_resources)
	
func throw_healing_bones():
	if(heal_resources < 25):
		return
	if Input.is_key_pressed(KEY_2) && (time - last_time_thrown_heal > 1):
		var healing_bone_1 = create_healing_bone(-1)
		var healing_bone_2 = create_healing_bone(1)
		get_parent().add_child(healing_bone_1)
		get_parent().add_child(healing_bone_2)
		last_time_thrown_heal = time
		heal_resources -= 25
		emit_signal("heal_resource_update", heal_resources)
	
func create_healing_bone(move_dir_offset):
	var healing_bone: Node2D = healing_projectile_scene.instance()
	healing_bone.position = position
	var dir: Vector2 = get_global_mouse_position() - position
	dir = dir.normalized()
	healing_bone.move_dir = dir
	healing_bone.move_dir_offset = move_dir_offset
	return healing_bone
	
func _process(delta):
	spawn_healing_area()
	throw_healing_bones()
	time += delta
	
	if Input.is_action_just_pressed("action"):
		if near_chest:
			near_chest.open_chest()
			near_chest = null
			$ChestSound.play()
		if near_vase:
			near_vase.break_vase()
			near_vase = null
			$VaseSound.set_random_sound()
			$VaseSound.play()

func _on_HealthSystem_died():
	pass

func _on_HealthSystem_health_update(new_health):
	$HealthBar.show()

func _on_Area2D_area_entered(area):
	if area.is_in_group("HealthPickup"):
		pick_up_health_pickup(area)
	elif area.is_in_group("TreasurePickup"):
		var treasure: TreasurePickup = area as TreasurePickup
		treasure_found += treasure.treasure_value
		emit_signal("treasure_update", treasure_found)
		area.queue_free()
		$CoinSound.play()
	elif area.is_in_group("TreasureChest"):
		near_chest = area as TreasureChest
	elif area is Vase:
		near_vase = area as Vase

func pick_up_health_pickup(pickup):
		if heal_resources >= max_heal_resources:
			return
		var health_pickup: HealthPickup = pickup as HealthPickup
		heal_resources += health_pickup.health_value
		emit_signal("heal_resource_update", heal_resources)
		pickup.queue_free()
		$HealthPickupSound.play()

func _on_Area2D_area_exited(area):
	if area.is_in_group("TreasureChest"):
		near_chest = null
	if area is Vase:
		near_vase = null
