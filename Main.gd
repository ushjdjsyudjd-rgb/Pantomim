extends Control

@onready var word_label = $MainPanel/WordLabel
@onready var timer_label = $TopBar/TimerLabel
@onready var score_label = $TopBar/ScoreLabel
@onready var progress_bar = $MainPanel/TimerProgress

# ارجاع ایمن به GameManager برای جلوگیری از ارور در محیط بیلد
@onready var gm = get_node("/root/GameManager")

func _ready():
	apply_visual_style()
	next_round()

func apply_visual_style():
	var style = StyleBoxFlat.new()
	style.bg_color = Color("#1a1a2e")
	style.border_width_all = 4
	style.border_color = Color("#ff00ff")
	style.corner_radius_top_left = 30
	style.corner_radius_bottom_right = 30
	style.shadow_size = 20
	style.shadow_color = Color(1, 0, 1, 0.2)
	$MainPanel.add_theme_stylebox_override("panel", style)

func _process(delta):
	if gm.time_left > 0:
		gm.time_left -= delta
		update_ui()
	else:
		on_time_up()

func update_ui():
	timer_label.text = str(ceil(gm.time_left))
	score_label.text = "امتیاز: " + str(gm.score)
	progress_bar.value = (gm.time_left / 60.0) * 100

func next_round():
	gm.time_left = 60
	word_label.text = gm.get_random_word()
	var tween = create_tween()
	word_label.scale = Vector2(0.8, 0.8)
	tween.tween_property(word_label, "scale", Vector2(1.0, 1.0), 0.3)

func on_time_up():
	word_label.text = "وقت تمام شد!"
	if OS.has_feature("mobile"):
		Input.vibrate_handheld(500)

func _on_correct_pressed():
	gm.score += 10
	next_round()

func _on_wrong_pressed():
	next_round()
