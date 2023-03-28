class CChaosSerpent : Actor replaces Demon1
{
	Default
	{
		Health 250;
		Painchance 50;
		Speed 4;
		Radius 32;
		Height 64;
		Mass 220;
		Monster;
		+TELESTOMP
		+FLOORCLIP
		+INTERPOLATEANGLES
		SeeSound "DemonSight";
		AttackSound "DemonAttack";
		PainSound "DemonPain";
		DeathSound "DemonDeath";
		ActiveSound "DemonActive";
		Obituary "$OB_DEMON1";
		Tag "$FN_DEMON1";
	}
	
	const ChunkFlags = SXF_TRANSFERTRANSLATION | SXF_ABSOLUTEVELOCITY;
	
	States
	{
	Spawn:
		SATB BCDEFGHIJKLMNOPQRSTUVWXYZ[ 3 A_Look;
		Loop;
	See:
		SATC TUVWXYZ[\] 1 A_Chase;
        SATD ABCDEFGHIJK 1 A_Chase;
		Loop;
	Pain:
		SATA Q 1 A_Pain;
        SATA RSTUVWXYZ[\] 1;
        SATB A 1;
		Goto See;
	Melee:
		SATA ABCDEFGHI 1 A_FaceTarget;
		SATA J 1 A_CustomMeleeAttack(random[DemonAttack1](1,8)*2);
		SATA KLMNOP 1;
		Goto See;
	Missile:
		SATB \] 1 A_FaceTarget;
        SATC ABCDEFGHIJKL 1 A_FaceTarget;
		SATC M 1 A_SpawnProjectile("Demon1FX1", 62, 0);
		SATC NOPQRS 1 A_FaceTarget;
		Goto See;
	Death:
		SATD L 1 A_Scream;
        SATD MNOPQRSTUV 1;
        SATD W 1 A_NoBlocking;
        SATD XZ\ 1;
        SATE A 1 A_QueueCorpse;
        //SATE BCDEFGHIJKLMNOPQR 1;
        SATE BDFH 1;
		SATE S -1 Offset (0, -10);
		Stop;
	XDeath:
		SXDA A 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        SXDA C 1 A_Scream;
        SXDA E 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        SXDA G 1 A_NoBlocking;
        SXDA I 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        SXDA K 1 A_QueueCorpse;
        SXDA MOQSUWY[] 1;
        SXDB ACEG 1;
		SXDB I -1;
        Stop;
	}
}

class CSerpent : Actor replaces Demon2
{
	Default
	{
		Health 250;
		Painchance 50;
		Speed 4;
		Radius 32;
		Height 64;
		Mass 220;
		Monster;
		+TELESTOMP
		+FLOORCLIP
		+INTERPOLATEANGLES
		SeeSound "DemonSight";
		AttackSound "DemonAttack";
		PainSound "DemonPain";
		DeathSound "DemonDeath";
		ActiveSound "DemonActive";
		Obituary "$OB_DEMON2";
		Tag "$FN_DEMON2";
	}
	
	const ChunkFlags = SXF_TRANSFERTRANSLATION | SXF_ABSOLUTEVELOCITY;
	
	States
	{
	Spawn:
		SATB BCDEFGHIJKLMNOPQRSTUVWXYZ[ 3 A_Look;
		Loop;
	See:
		SATC TUVWXYZ[\] 1 A_Chase;
        SATD ABCDEFGHIJK 1 A_Chase;
		Loop;
	Pain:
		SATA Q 1 A_Pain;
        SATA RSTUVWXYZ[\] 1;
        SATB A 1;
		Goto See;
	Melee:
		SATA ABCDEFGHI 1 A_FaceTarget;
		SATA J 1 A_CustomMeleeAttack(random[DemonAttack1](1,8)*2);
		SATA KLMNOP 1;
		Goto See;
	Missile:
		SATB \] 1 A_FaceTarget;
        SATC ABCDEFGHIJKL 1 A_FaceTarget;
		SATC M 1 A_SpawnProjectile("Demon2FX1", 62, 0);
		SATC NOPQRS 1 A_FaceTarget;
		Goto See;
	Death:
		SATD L 1 A_Scream;
        SATD MNOPQRSTUV 1;
        SATD W 1 A_NoBlocking;
        SATD XZ\ 1;
        SATE A 1 A_QueueCorpse;
        //SATE BCDEFGHIJKLMNOPQR 1;
        SATE BDFH 1;
		SATE S -1;
		Stop;
	XDeath:
		SXDA A 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        SXDA C 1 A_Scream;
        SXDA E 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        SXDA G 1 A_NoBlocking;
        SXDA I 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        SXDA K 1 A_QueueCorpse;
        SXDA MOQSUWY[] 1;
        SXDB ACEG 1;
		SXDB I -1;
        Stop;
	}
}
