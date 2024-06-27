OverwriteTableKeys( ProjectileData, {
	HeraColorProjectile =
	{
		DamageTextStartColor = Color.HeraDamageLight,
		DamageTextColor = Color.HeraDamage,
	},
	HeraDamageShareProjectile = 
	{
		InheritFrom = { "HeraColorProjectile" },
	},
	ProjectileHeraOmega = 
	{
		InheritFrom = { "HeraColorProjectile" },
	},
})