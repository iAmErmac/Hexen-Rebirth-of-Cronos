class CMageBoss : Actor replaces MageBoss
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
		PainSound "PlayerMagePain";
		DeathSound "PlayerMageCrazyDeath";
		Obituary "$OB_MBOSS";
		Tag "$FN_MBOSS";
	}

	States
	{
	Spawn:
		MGTB QRSTUVWXYZ[\] 2 A_Look;
		MGTC ABCDEFGHIJK 2;
		MGTC L 2 A_ClassBossHealth;
		MGTC M 2 A_Look;
		Wait;
	See:
		MGTC NOPQRSTUVWXYZ[\] 1 A_Chase;
		MGTD ABCDE 1 A_FastChase;
		Loop;
	Pain:
		MGTB CDEFGHIJKLMNO 2;
		MGTB P 2 A_Pain;
		Goto See;
	Melee:
	Missile:
		MGTA ABCDEFGHIJKLMN 2 A_FaceTarget;
		MGTA O 2 A_MageAttack;
		MGTA PQRSTUVWXYZ[\] 2 A_FaceTarget;
		MGTB AB 2;
		Goto See;
	Death:
		MGTD F 2 A_Scream;
		MGTD GHIJ 2;
		MGTD K 2 A_NoBlocking;
		MGTD LM 2;
		MGTD N -1;
		Stop;
	/*Burn:
		FDTH E 5 Bright A_StartSound("PlayerMageBurnDeath");
		FDTH F 4 Bright;
		FDTH G 5 Bright;
		FDTH H 4 Bright A_Scream;
		FDTH I 5 Bright;
		FDTH J 4 Bright;
		FDTH K 5 Bright;
		FDTH L 4 Bright;
		FDTH M 5 Bright;
		FDTH N 4 Bright;
		FDTH O 5 Bright;
		FDTH P 4 Bright;
		FDTH Q 5 Bright;
		FDTH R 4 Bright;
		FDTH S 5 Bright A_NoBlocking;
		FDTH T 4 Bright;
		FDTH U 5 Bright;
		FDTH V 4 Bright;
		Stop;*/
	}

	//============================================================================
	//
	// MStaffSpawn2 - for use by mage class boss
	//
	//============================================================================

	void MStaffSpawn2 (double angle)
	{
		Actor mo = SpawnMissileAngleZ (pos.z + 40, "MageStaffFX2", angle, 0.);
		if (mo)
		{
			mo.target = self;
			mo.tracer = RoughMonsterSearch(10, true, true);
		}
	}

	//============================================================================
	//
	// A_MStaffAttack2 - for use by mage class boss
	//
	//============================================================================

	void A_MageAttack()
	{
		if (target == NULL)
		{
			return;
		}
		MStaffSpawn2(angle);
		MStaffSpawn2(angle - 5);
		MStaffSpawn2(angle + 5);
		A_StartSound("MageStaffFire", CHAN_WEAPON);
	}
	
}