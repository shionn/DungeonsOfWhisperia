class_name Dices
extends Object

static var _random = RandomNumberGenerator.new()

static func d6(count: int, threshold:int) -> int :
	var result = 0
	for i in range(0,count) :
		if _random.randi_range(1,6) >= threshold :
			result = result+1
	return result

static func d3(count: int=1, threshold:int=1) -> int :
	var result = 0
	for i in range(0,count) :
		if _random.randi_range(1,3) >= threshold :
			result = result+1
	return result
	
