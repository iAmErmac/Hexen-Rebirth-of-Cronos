class CFireball : Actor replaces FireBall
{
	Default
	{
		Speed 2;
		Radius 8;
		Height 8;
		Damage 4;
		DamageType "Fire";
		+NOBLOCKMAP +NOGRAVITY +DROPOFF +MISSILE
		+NOTELEPORT
		+ZDOOMTRANS
		RenderStyle "Add";
		DeathSound "Fireball";
	}
	States
	{
	Spawn:
		FIRB ABCDEFGHIJ 2 Bright;
		Loop;
	Death:
		XPL1 ABCDEF 4 Bright;
		Stop;
	}
}

// Arrow --------------------------------------------------------------------

class CArrow : Actor replaces Arrow
{
	Default
	{
		Speed 6;
		Radius 8;
		Height 4;
		Damage 4;
		+NOBLOCKMAP +NOGRAVITY +DROPOFF +MISSILE
		+NOTELEPORT
	}
	States
	{
	Spawn:
		PROJ A -1;
		Stop;
	Death:
		PROJ A 1;
		Stop;
	}
}

// Dart ---------------------------------------------------------------------

class CDart : Actor replaces Dart
{
	Default
	{
		Speed 6;
		Radius 8;
		Height 4;
		Damage 2;
		+NOBLOCKMAP +NOGRAVITY +DROPOFF +MISSILE
		+NOTELEPORT
	}
	States
	{
	Spawn:
		PROJ A -1;
		Stop;
	Death:
		PROJ A 1;
		Stop;
	}
}

// Poison Dart --------------------------------------------------------------

class CPoisonDart : CDart replaces PoisonDart
{
	Default
	{
		PoisonDamage 20;
	}
}

// Ripper Ball --------------------------------------------------------------

class CRipper : Actor replaces RipperBall
{
	Default
	{
		Speed 6;
		Radius 8;
		Damage 2;
		+NOBLOCKMAP +NOGRAVITY +DROPOFF +MISSILE
		+NOTELEPORT +RIPPER
	}
	States
	{
	Spawn:
		PROJ A 3;
		Loop;
	Death:
		CFCF Q 4 Bright;
		CFCF R 3 Bright;
		CFCF S 4 Bright;
		CFCF T 3 Bright;
		CFCF U 4 Bright;
		CFCF V 3 Bright;
		CFCF W 4 Bright;
		CFCF X 3 Bright;
		CFCF Y 4 Bright;
		CFCF Z 3 Bright;
		Stop;
	}
}

// Projectile Blade ---------------------------------------------------------

class CBolt : Actor replaces ProjectileBlade
{
	Default
	{
		Speed 6;
		Radius 6;
		Height 6;
		Damage 3;
		+NOBLOCKMAP +NOGRAVITY +DROPOFF +MISSILE
		+NOTELEPORT
	}
	States
	{
	Spawn:
		PROJ A -1;
		Stop;
	Death:
		PROJ A 1;
		Stop;
	}
}
