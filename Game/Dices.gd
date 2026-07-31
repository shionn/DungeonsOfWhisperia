class_name Dices
extends Object

static var _random = RandomNumberGenerator.new()

static func d6(count: int, threshold:int) -> int :
	var result = 0
	for i in range(0,count) :
		if _random.randi_range(1,6) >= threshold :
			result = result+1
	return result

static func d6s(count, threshold:int) -> Array[int] :
	var results : Array[int] = []
	for i in range(0,count) :
		var dice = _random.randi_range(1,6)
		if dice >= threshold :
			results.append(dice)
	return results
	

static func d3(count: int = 1, threshold:int = 1) -> int :
	var result = 0
	for i in range(0,count) :
		if threshold == 1 : result = result + _random.randi_range(1,3)
		elif _random.randi_range(1,3) >= threshold : result = result+1
	return result
