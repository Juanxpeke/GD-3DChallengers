extends StaticBody

var hit_counter = 0

func projectile_hit(damage, transform):
	hit_counter += 1
	print("Hit number " + str(hit_counter) + "!!!")
