extends CharacterBody2D

# 移动速度（可在编辑器中调整）
@export var speed: float = 300.0
var can_move: bool = true

func _physics_process(delta: float) -> void:
	# 不能移动时直接返回
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	# 获取输入方向
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.x = Input.get_axis("left", "right")
	input_dir.y = Input.get_axis("up", "down")
	
	# 归一化方向（防止斜向移动速度过快）
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
	
	# 设置速度并移动
	velocity = input_dir * speed
	move_and_slide() 
