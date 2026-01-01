extends Node

# دیتابیس کلمات
var words = {
    "آسان": ["خیار", "شانه", "مسواک", "فوتبال", "بستنی", "گربه", "تلفن"],
    "متوسط": ["مترو", "همبرگر", "کوهنوردی", "تلسکوپ", "آسانسور", "رنگین کمان"],
    "سخت": ["فرش فانتزی", "دیپلماسی", "نوستالژی", "پارادوکس", "اقتصاد مقاومتی"],
    "ضرب‌المثل": ["کوه به کوه نمیرسه", "جوجه را آخر پاییز میشمارند", "آشپز که دوتا شد"]
}

var current_category = "آسان"
var current_word = ""
var score = 0
var time_left = 60

func get_random_word():
    var category_words = words[current_category]
    current_word = category_words[randi() % category_words.size()]
    return current_word
