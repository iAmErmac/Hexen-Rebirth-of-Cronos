class CHolySpirit : HolySpirit replaces HolySpirit
{
	Default
	{
		Health 105;
		Speed 12;
		Radius 10;
		Height 6;
		Damage 3;
		Projectile;
		+RIPPER +SEEKERMISSILE
		+FOILINVUL +SKYEXPLODE +NOEXPLODEFLOOR +CANBLAST
		+EXTREMEDEATH +NOSHIELDREFLECT
		+INTERPOLATEANGLES
		RenderStyle "Translucent";
		Alpha 0.4;
		DeathSound "SpiritDie";
		Obituary "$OB_MPCWEAPWRAITHVERGE";
	}

	States
	{
	Spawn:
		WRTA ABCDEFGHIJKLM 2 A_CHolySeek;
		WRTA N 2 A_CHolyCheckScream;
		Loop;
	Death:
		WRTA O 4;
		WRTA PQRSTUVWXYZ[\] 2;
		WRTB A 2 A_Scream;
		WRTB B 2 A_SetTranslucent(0.66, 0);
		WRTB C 2 A_SetTranslucent(0.33, 0);
		WRTB C 2 A_SetTranslucent(0.0, 0);
		Stop;
	}
	
	//============================================================================
	//
	//
	//
	//============================================================================
}

class CKoraxSpirit : KoraxSpirit replaces KoraxSpirit
{
	Default
	{
		Speed 8;
		Projectile;
		+NOCLIP
		-ACTIVATEPCROSS
		-ACTIVATEIMPACT
		+INTERPOLATEANGLES
		RenderStyle "Translucent";
		Alpha 0.4;
	}
	
	States
	{
	Spawn:
		WRTA ABCDEFGHIJKLMN 2 A_KSpiritRoam;
		Loop;
	Death:
		WRTA O 4;
		WRTA PQRSTUVWXYZ[\] 2;
		WRTB A 2;
		WRTB B 2 A_SetTranslucent(0.66, 0);
		WRTB C 2 A_SetTranslucent(0.33, 0);
		WRTB C 2 A_SetTranslucent(0.0, 0);
		Stop;
	}
}
