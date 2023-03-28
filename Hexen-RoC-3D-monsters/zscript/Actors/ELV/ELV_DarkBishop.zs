class CBishop : Bishop replaces Bishop
{	
	int missilecount;


	Default
	{
		Health 130;
		Radius 22;
		Height 65;
		Speed 10;
		PainChance 110;
		BloodColor "00FF00";
		Monster;
		+FLOAT +NOGRAVITY +NOBLOOD
		+TELESTOMP
		+DONTOVERLAP
		+NOTARGETSWITCH
		+INTERPOLATEANGLES
		SeeSound "BishopSight";
		AttackSound "BishopAttack";
		PainSound "BishopPain";
		DeathSound "BishopDeath";
		ActiveSound "BishopActiveSounds";
		Obituary"$OB_BISHOP";
		Tag "$FN_BISHOP";
	}

	States
	{
	Spawn:
		DBTC BCDEFGHIJKLMNOPQRSTUVWXYZ[\] 3 A_Look;
		DBTD ABC 3 A_Look;
		Loop;
	See:
		DBTD DEFGHI 1 A_Chase;
        DBTD JKLMNO 1 A_BishopChase;
        DBTD P 1;
        DBTD Q 1;
        DBTD R 1;
        DBTD STUVW 1 A_BishopChase;
        DBTD XY 1 A_BishopDecide;
		Loop;
	Blur:
		DBTD D 2 A_BishopDoBlur;
		DBTD D 4 A_BishopSpawnBlur;
		Wait;
	Pain:
		DBTB Q 1 A_Pain;
        DBTB RST 1;
        DBTB UVW 4 A_BishopPainBlur;
        DBTB X 1;
        DBTB Y 1;
        DBTB Z 1;
        DBTB [ 1;
        DBTB \ 1;
        DBTB ] 1;
        DBTC A 1;
		Goto See;
	Missile:
		DBTA ABCDEFGHIJKLMNOPQRSTU 1 A_FaceTarget;
		DBTA P 2 A_BishopAttack;
		DBTA Q 2 A_BishopAttack2;
		DBTA R 1;
		DBTA S 2 A_BishopAttack;
		DBTA T 2 A_BishopAttack2;
		DBTA U 1;	
		DBTA V 2 A_BishopAttack;
        DBTA W 2 A_BishopAttack2;
		//Wait;
        DBTA X 1;
        DBTA Y 2 A_BishopAttack;
        DBTA Z 2 A_BishopAttack2;
        DBTA [ 1;
        DBTA \ 2 A_BishopAttack;
        DBTA ] 2 A_BishopAttack2;
        DBTB A 1;
        DBTB B 2 A_BishopAttack;
        DBTB C 2 A_BishopAttack2;
        DBTB D 1;
        DBTB E 2 A_BishopAttack;
        DBTB F 2 A_BishopAttack2;
        DBTB G 1;
        DBTB H 2 A_BishopAttack;
        DBTB I 2 A_BishopAttack2;
        DBTB JKLMNOP 1 A_FaceTarget;
		Goto See;
	Death:	
		BSHX A 2 A_Scream;
        BSHX E 2 A_NoBlocking;
        BSHX I 2;
        BSHX M 2 A_Explode(random[BishopBoom](25,40));
        BSHX Q 2 A_SpawnItemEx("BSHFog",random(0,8),0,24,frandom(0.3,1.0),0,0,random(0,360));
        BSHX U 2 A_SpawnItemEx("BishopPuff", 0,0,40, 0,0,0.5);
        BSHX Y 2 A_SpawnItemEx("BSHFog",random(0,8),0,24,frandom(0.3,1.0),0,0,random(0,360));
        BSHX ] 2 A_SpawnItemEx("BishopPuff", 0,0,40, 0,0,0.5);
        BSHY A 2 A_SpawnItemEx("BSHFog",random(0,8),0,24,frandom(0.3,1.0),0,0,random(0,360));
        BSHY E 2;
        BSHY I 2 A_SpawnItemEx("BSHFog",random(0,8),0,24,frandom(0.3,1.0),0,0,random(0,360));
        BSHY M 2;
        BSHY Q 2;
        BSHY U 2;
        BSHY Y 2;
        BSHY ] 2;
        BSHZ A 2;
        BSHZ E 2;
        BSHZ I 1;
	
	
		/*DBTB T 0 A_Scream;
        DBTB U 0 A_NoBlocking;
		DBTB V 0;
		DBTB W 0;
        DBTB X 0 A_Explode(random[BishopBoom](25,40));
        DBTB Y 0 A_SpawnItemEx("BishopPuff", 0,0,40, 0,0,0.5);
        DBTB Z 0;
        DBTB [ 0 A_SpawnItemEx("BishopPuff", 0,0,40, 0,0,0.5);
        DBTB \] 1;*/
		Stop;
	Ice:
		DBTD Z 10 A_FreezeDeath;
		DBTD Z 1 A_FreezeDeathChunks;
		Wait;
	}
}

class BSHFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.1;
	Scale 0.2;
	+CLIENTSIDEONLY;
	+FORCEXYBILLBOARD;
	+DONTSPLASH;
	+NOTELEPORT;
	+THRUACTORS;
	+BRIGHT;
	}
    States
    {
    Spawn:
		IFOG C 0;
		IFOG CCCCCC 1 A_FadeIn(0.05);
        IFOG C 1;
		Goto FadeOut;
	FadeOut:
		IFOG C 1 A_FadeOut(0.005);
        Loop;
    }
}

class CBishopBlur : Actor replaces BishopBlur
{
	Default
	{
		+NOBLOCKMAP +NOGRAVITY
		RenderStyle "Translucent";
		Alpha 0.6;
	}
	States
	{
	Spawn:
		DBTD D 16;
		DBTD D 8 A_SetTranslucent(0.4);
		Stop;
	}
}

class CBishopPainBlur : Actor replaces BishopPainBlur
{
	Default
	{
		+NOBLOCKMAP +NOGRAVITY
		RenderStyle "Translucent";
		Alpha 0.6;
	}
	States
	{
	Spawn:
		DBTB Q 1;
        DBTB RST 1;
        DBTB UVW 4;
        DBTB X 1;
        DBTB Y 1;
        DBTB Z 1 A_SetTranslucent(0.4);
        DBTB [ 1;
        DBTB \ 1;
        DBTB ] 1;
        DBTC A 1;
		Stop;
	}
}