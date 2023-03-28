class CEttin : Actor replaces Ettin
{
	Default
	{
		Health 175;
		Radius 25;
		Height 68;
		Mass 175;
		Speed 4;
		Damage 3;
		Painchance 60;
		Monster;
		+FLOORCLIP
		+TELESTOMP
		+INTERPOLATEANGLES
		SeeSound "EttinSight";
		AttackSound "EttinAttack";
		PainSound "EttinPain";
		DeathSound "EttinDeath";
		ActiveSound "EttinActive";
		HowlSound "PuppyBeat";
		Obituary "$OB_ETTIN";
		Tag "$FN_ETTIN";
	}
	States
	{
	Spawn:
		EATC LMNOPQRSTUVWXYZ[\] 3 A_Look;
		Loop;
	See:
		EATD BCDEFGHIJKLMNOPQRSTUVWXYZ[ 1 A_Chase;
		Loop;
	Pain:
		EATB W 1 A_Pain;
		EATB XYZ[\] 1;
        EATC ABCDEFGHIJK 1;
		Goto See;
	Melee:
		EATD \] 1 A_FaceTarget;
        EATE ABCDEF 1 A_FaceTarget;
		EATE G 1 A_CustomMeleeAttack(random[EttinAttack](1,8)*2);
        EATE HIJKLMNOPQRSTUVWXYZ[\ 1 A_FaceTarget;
		Goto See;
	Death:
		EATA A 1 A_Scream;
		EATA BCDEFGHI 1;
        EATA JKLMNOPQRSTUVWXYZ[\] 1 A_NoBlocking;
        EATB A 1 A_QueueCorpse;
        EATB BCDEFGHIJKLMNOPQRSTU 1;
        EATB V -1;
		Stop;
	XDeath:
		EATX A 2 A_SpawnItemEx("GibletsSpawnerDirectional");
		EATX B 2 A_NoBlocking;
		EATX C 2 A_SpawnItemEx("GibletsSpawnerDirectional");
		EATX D 2 A_Scream;
		EATX E 2 A_QueueCorpse;
		EATX FGHIJKLMNOP 2;
        EATX Q -1;
		Stop;
	}
}