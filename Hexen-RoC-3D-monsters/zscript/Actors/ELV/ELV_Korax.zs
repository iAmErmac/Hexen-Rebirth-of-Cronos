class CKorax : Korax replaces Korax
{

	const KORAX_ARM_EXTENSION_SHORT	= 40;
	const KORAX_ARM_EXTENSION_LONG	= 55;

	const KORAX_ARM1_HEIGHT			= 108;
	const KORAX_ARM2_HEIGHT			= 82;
	const KORAX_ARM3_HEIGHT			= 54;
	const KORAX_ARM4_HEIGHT			= 104;
	const KORAX_ARM5_HEIGHT			= 86;
	const KORAX_ARM6_HEIGHT			= 53;

	const KORAX_FIRST_TELEPORT_TID	= 248;
	const KORAX_TELEPORT_TID		= 249;

	const KORAX_DELTAANGLE			= 85;

	const KORAX_COMMAND_HEIGHT	= 120;
	const KORAX_COMMAND_OFFSET	= 27;

	const KORAX_SPIRIT_LIFETIME = 5*TICRATE/5;	// 5 seconds
	
	Default
	{
		Health 5000;
		Painchance 20;
		Speed 3;
		Radius 65;
		Height 115;
		Mass 2000;
		Damage 15;
		Monster;
		+BOSS
		+FLOORCLIP
		+TELESTOMP
		+DONTMORPH
		+NOTARGET
		+NOICEDEATH
		+INTERPOLATEANGLES
		SeeSound "KoraxSight";
		AttackSound "KoraxAttack";
		PainSound "KoraxPain";
		DeathSound "KoraxDeath";
		ActiveSound "KoraxActive";
		Obituary "$OB_KORAX";
		Tag "$FN_KORAX";
	}

	States
	{
	Spawn:
		KXTB KLMNOPQRSTUVWXYZ[\] 2 A_Look;
		KXTC ABCDEFG 2 A_Look;
		Loop;
	See:
		KXTD H 2 A_KoraxStep;
		KXTD IJKL 2 A_KoraxChase;
		KXTD MNOPQ 2 A_Chase;
		KXTD R 2 A_KoraxStep;
		KXTD STUV 2 A_KoraxChase; 
		KXTD WXYZ[\ 2 A_Chase;
		Loop;
	Pain:
		KXTA Y 2 A_Pain;
		KXTA Z[\] 2;
		KXTB ABCDEFGHIJ 2;
		Goto See;
	Missile:
		KXTC H 2 A_FaceTarget;
		KXTC H 2 A_KoraxDecide;
		Wait;
	Death:
		KXTD ] 1;
		KXTE A 2;
		KXTE BC 2 A_FaceTarget;
		KXTE D 2 A_Scream;
		KXTE EF 2;
		KXTE G 2 A_KoraxBonePop;
		KXTE H 2 A_NoBlocking;
		KXTE IJKLMNOPQ 2;
		KXTE R -1;
		/*KORX I 5;
		KORX J 5 A_FaceTarget;
		KORX K 5 A_Scream;
		KORX LMNOP 5;
		KORX Q 10;
		KORX R 5 A_KoraxBonePop;
		KORX S 5 A_NoBlocking;
		KORX TU 5;
		KORX V -1;*/
		Stop;
	Attack:
		KXTA ABCDEFGHIJKLM 2 A_FaceTarget;
		KXTA N 2 A_KoraxMissile;
		KXTA OPQRSTUVWX 2;
		Goto See;
	Command:
		KXTC HIJKLMNOPQRST 2 A_FaceTarget;
		KXTC U 2 A_KoraxCommand;
		KXTC VWXYZ[\] 2;
		KXTD ABCDEFG 2;
		Goto See;
	}
}