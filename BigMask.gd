class_name BigMask
extends Reference

const MASK_SIZE := 32
var bitmasks: PoolIntArray = []
var bits: int

func _init(size: int, default_state: bool = false, enforce_soft_size: bool = true) -> void:
	resize(size, default_state, enforce_soft_size)

func resize(size: int, default_state: bool = false, enforce_soft_size: bool = true) -> void:
	assert(size >= 0)
	var old_masks := bitmasks.size()
	bitmasks.resize(ceil(size / float(MASK_SIZE)))
	bits = size if enforce_soft_size else bitmasks.size() * MASK_SIZE
	for i in range(old_masks, bitmasks.size()):
		bitmasks[i] = ~0 if default_state else 0

func check_bit(index: int) -> bool:
	assert(index < bits)
	return bitmasks[index / MASK_SIZE] & (1 << (index % MASK_SIZE)) != 0

func set_bit(index: int, state: bool) -> void:
	assert(index < bits)
	if state:
		bitmasks[index / MASK_SIZE] |= (1 << (index % MASK_SIZE))
	else:
		bitmasks[index / MASK_SIZE] &= ~(1 << (index % MASK_SIZE))

func print_bits(multiline: bool = true) -> void:
	if multiline:
		for i in range(bits):
			print("bit " + String(i) + ": " + String(check_bit(i)))
	else:
		var output := ""
		for i in range(bits):
			output += '1' if check_bit(i) else '0'
		print(output)
