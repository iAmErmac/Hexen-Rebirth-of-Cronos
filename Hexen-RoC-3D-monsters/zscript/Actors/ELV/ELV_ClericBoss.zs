class CClericBoss : Actor replaces ClericBoss
{
	Default
	{
		Health 800;
		PainChance 50;
		Speed 9;
		Radius 16;
		Height 64;
		Monster;
		+FLOORCLIP +TELESTOMP
		+DONTMORPH
		+INTERPOLATEANGLES
		PainSound "PlayerClericPain";
		DeathSound "PlayerClericCrazyDeath";
		Obituary "$OB_CBOSS";
		Tag "$FN_CBOSS";
	}

	States
	{
	Spawn:
		CBTC XYZ[\] 2 A_Look;
		CBTD ABCDEFGHIJKLMNOPQR 2 A_Look;
		CBTD S 2 A_ClassBossHealth;
		CBTD T 2 A_Look;
		Wait;
	See:
		CBTE FGHIJKLMNOPQRSTUVWXYZ 2 A_Chase;
		Loop;
	Pain:
		CBTC CDEFGHIJKLMNOPQRSTUV 2;
		CBTC W 2 A_Pain;
		Goto See;
	Melee:
	Missile:
		CBTA ABCDEFGHIJKLMN 1 A_FaceTarget;
		CBTA O 1 A_ClericAttack;
		CBTA PQRSTUVWXYZ 1;
		Goto See;
	Death:
		CBTA [\] 2;
		CBTB A 2 A_Scream;
		CBTB BCDEFGHIJKLMNOPQRS 2;
		CBTB S 2 A_NoBlocking;
		CBTB TUVXYZ[\] 2;
		CBTC A 2;
		CBTC B -1;
		Stop;
	/*Burn:
		CLER C 5 Bright A_StartSound("PlayerClericBurnDeath");
		FDTH D 4 Bright ;
		FDTH G 5 Bright ;
		FDTH H 4 Bright A_Scream;
		FDTH I 5 Bright ;
		FDTH J 4 Bright ;
		FDTH K 5 Bright ;
		FDTH L 4 Bright ;
		FDTH M 5 Bright ;
		FDTH N 4 Bright ;
		FDTH O 5 Bright ;
		FDTH P 4 Bright ;
		FDTH Q 5 Bright ;
		FDTH R 4 Bright ;
		FDTH S 5 Bright A_NoBlocking;
		FDTH T 4 Bright ;
		FDTH U 5 Bright ;
		FDTH V 4 Bright ;
		Stop;*/
	}
		
	//============================================================================
	//
	// A_ClericAttack
	//
	//============================================================================

	void A_ClericAttack()
	{
		if (!target) return;

		Actor missile = SpawnMissileZ (pos.z + 40., target, "HolyMissile");
		if (missile != null) missile.tracer = null;	// No initial target
		A_StartSound ("HolySymbolFire", CHAN_WEAPON);
	}
}
