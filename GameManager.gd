extends Node

var words = {
    "عمومی": ["قوری", "هواپیما", "مسواک", "کفش"],
    "سینما": ["جدایی نادر از سیمین", "اخراجی‌ها", "اینتراستلار"],
    "ضرب‌المثل": ["آشپز که دوتا شد", "تخم‌مرغ دزد شتر دزد می‌شود"]
}

var current_category = "عمومی"
var time_left = 60
var score = 0

signal time_updated(value)
signal game_over

func start_game(category):
    current_category = category
    time_left = 60
    score = 0
    $Timer.start()

func _on_timer_timeout():
    if time_left > 0:
        time_left -= 1
        emit_signal("time_updated", time_left)
    else:
        $Timer.stop()
        emit_signal("game_over")

func get_random_word():
    return words[current_category].pick_random()
