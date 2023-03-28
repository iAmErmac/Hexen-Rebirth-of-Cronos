class CFighterBoss : Actor replaces FighterBoss
{
	Default
	{
		health 800;
		PainChance 50;
		Speed 9;
		Radius 16;
		Height 64;
		Monster;
		+FLOORCLIP
		+TELESTOMP
		+DONTMORPH
		+INTERPOLATEANGLES
		PainSound "PlayerFighterPain";
		DeathSound "PlayerFighterCrazyDeath";
		Obituary "$OB_FBOSS";
		Tag "$FN_FBOSS";
	}

	States
	{
	Spawn:
		FBTC PQRSTUVWXYZ[\] 2 A_Look;
		FBTD ABCDEFGHIJ 2;
		FBTD K 2 A_ClassBossHealth; 
		FBTD L 2 A_Look;
		Wait;
	See:
		FBTD MNOPQRSTUVWXYZ[\ 1 A_Chase;
		Loop;
	Pain:
		FBTB ] 2;
		FBTC ABCDEFGHIJKLMN 2;
		FBTC O 2 A_Pain;
		Goto See;
	Melee:
	Missile:
		FBTA ABCDEFGHIJKLMN 1 A_FaceTarget;
		FBTA O 1 A_FighterAttack;
		FBTA PQRSTUVWXZ 1 A_FaceTarget;
		Goto See;
	Death:
		FBTA [\] 1;
		FBTB A 1 A_Scream;
		FBTB BCDEFGHIJKLMNOP 1;
		FBTB Q 1 A_NoBlocking;
		FBTB RSTUVWXYZ[ 1;
		FBTB \ -1;
		Stop;
	/*Burn:
		FDTH A 5 Bright A_StartSound("PlayerFighterBurnDeath");
		FDTH B 4 Bright;
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
	// A_FighterAttack
	//
	//============================================================================

	void A_FighterAttack()
	{
		if (!target) return;

		SpawnMissileAngle("FSwordMissile", Angle + (45. / 4), 0);
		SpawnMissileAngle("FSwordMissile", Angle + (45. / 8), 0);
		SpawnMissileAngle("FSwordMissile", Angle, 0);
		SpawnMissileAngle("FSwordMissile", Angle - (45. / 8), 0);
		SpawnMissileAngle("FSwordMissile", Angle - (45. / 4), 0);
		A_StartSound ("FighterSwordFire", CHAN_WEAPON);
	}
}
