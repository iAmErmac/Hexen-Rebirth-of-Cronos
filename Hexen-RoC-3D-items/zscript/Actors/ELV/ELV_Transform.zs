// Egg missile --------------------------------------------------------------

class CEggFX : MorphProjectile replaces EggFX
{
	Default
	{
		Radius 8;
		Height 8;
		Speed 18;
		MorphProjectile.PlayerClass "ChickenPlayer";
		MorphProjectile.MonsterClass "Chicken";
		MorphProjectile.MorphStyle MRF_UNDOBYTOMEOFPOWER;
	}
	States
	{
	Spawn:
		PRKE A 4;
		Loop;
	Death:
		FX01 FFGH 3 Bright;
		Stop;
	}
}
	

// Morph Ovum ----------------------------------------------------------------

class CArtiEgg : CustomInventory replaces ArtiEgg
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		+INVENTORY.INVBAR
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTIEGGC";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIEGG";
		Inventory.DefMaxAmount;
		Tag "$TAG_ARTIEGG";
	}
	States
	{
	Spawn:
		PRKE A 6;
		Loop;
	Use:
		TNT1 A 0
		{
			for (double i = -15; i <= 15; i += 7.5)	A_FireProjectile("EggFX", i, false, 0, 0, FPF_AIMATANGLE);
		}
		Stop;
	}
}
	
// Pork missile --------------------------------------------------------------

class CPorkFX : MorphProjectile replaces PorkFX
{
	Default
	{
		Radius 8;
		Height 8;
		Speed 18;
		MorphProjectile.PlayerClass "PigPlayer";
		MorphProjectile.MonsterClass "CPig";
		MorphProjectile.MorphStyle MRF_UNDOBYTOMEOFPOWER|MRF_UNDOBYCHAOSDEVICE;
	}
	States
	{
	Spawn:
		PRKE A 4;
		Loop;
	Death:
		FHFX IJKL 3 Bright;
		Stop;
	}
}

// Porkalator ---------------------------------------------------------------

class CArtiPork : CustomInventory replaces ArtiPork
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		+INVENTORY.INVBAR
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTIPORK";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIEGG2";
		Inventory.DefMaxAmount;
		Tag "$TAG_ARTIPORK";
	}
	States
	{
	Spawn:
		PRKE A 5;
		Loop;
	Use:
		TNT1 A 0
		{
			for (double i = -15; i <= 15; i += 7.5)	A_FireProjectile("PorkFX", i, false, 0, 0, FPF_AIMATANGLE);
		}
		Stop;
	}
}
