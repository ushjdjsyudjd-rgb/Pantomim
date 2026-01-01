extends Node

var score = 0
var time_left = 60
var current_words_pool = [] # مخزن کلمات باقی‌مانده

var word_database = {
    "آسان": ["قاشق", "مسواک", "بستنی", "ماشین", "درخت", "کفش", "عینک", "ساعت"],
    "متوسط": ["آسانسور", "تلسکوپ", "کوهنوردی", "رنگین‌کمان", "ترافیک", "سینما"],
    "سخت": ["دیپلماسی", "پارادوکس", "نوستالژی", "فتوسنتز", "جاذبه", "کوانتوم"],
    "ضرب‌المثل": ["کوه به کوه نمی‌رسه", "جوجه رو آخر پاییز می‌شمارن", "مرغ همسایه غازه"]
}

func get_random_word():
    # اگر مخزن خالی بود، دوباره آن را پر کن
    if current_words_pool.is_empty():
        for cat in word_database:
            current_words_pool.append_array(word_database[cat])
        current_words_pool.shuffle() # مخلوط کردن کلمات
    
    # برداشتن یک کلمه و حذف آن از مخزن
    return current_words_pool.pop_back()

func reset_game():
    score = 0
    time_left = 60
    current_words_pool.clear()
