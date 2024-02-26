extends BulletProperty
## Causes bullet to either accelerate or decelerate over time
class_name AccelerationBullet

@export_range(-1000, 1000, 50.0, "or_greater", "or_less", "suffix: p/s") var rate: float = -100
