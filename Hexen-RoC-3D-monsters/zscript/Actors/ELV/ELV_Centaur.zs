class CCentaur : Actor replaces Centaur
{
	Default
	{
		Health 200;
		Painchance 135;
		Speed 4;
		Height 64;
		Mass 120;
		Monster;
		+FLOORCLIP
		+TELESTOMP
		+SHIELDREFLECT
		+INTERPOLATEANGLES
		SeeSound "CentaurSight";
		AttackSound "CentaurAttack";
		PainSound "CentaurPain";
		DeathSound "CentaurDeath";
		ActiveSound "CentaurActive";
		HowlSound "PuppyBeat";
		Obituary "$OB_CENTAUR";
		DamageFactor "Electric", 3;
		Tag "$FN_CENTAUR";
	}
	States
	{
	Spawn:
		CATD B 3 A_Look;
        CATD C 3 A_Look;
        CATD D 3 A_Look;
        CATD E 3 A_Look;
        CATD F 3 A_Look;
        CATD G 3 A_Look;
        CATD H 3 A_Look;
        CATD I 3 A_Look;
        CATD J 3 A_Look;
        CATD K 3 A_Look;
        CATD L 3 A_Look;
        CATD M 3 A_Look;
        CATD N 3 A_Look;
        CATD O 3 A_Look;
        CATD P 3 A_Look;
        CATD Q 3 A_Look;
        CATD R 3 A_Look;
        CATD S 3 A_Look;
        CATD T 3 A_Look;
        CATD U 3 A_Look;
        CATD V 3 A_Look;
        CATD W 3 A_Look;
        CATD X 3 A_Look;
        CATD Y 3 A_Look;
        CATD Z 3 A_Look;
        CATD [ 3 A_Look;
		Loop;
	See:
		CATE [\] 1 A_Chase;
        //CATE \ 1 A_Chase;
        //CATE ] 1 A_Chase;
        CATF ABCDEFGHIJKLMNOPQR 1 A_Chase;
        //CATF B 1 A_Chase;
        //CATF C 1 A_Chase;
        //CATF D 1 A_Chase;
        //CATF E 1 A_Chase;
        //CATF F 1 A_Chase;
        //CATF G 1 A_Chase;
        //CATF H 1 A_Chase;
        //CATF I 1 A_Chase;
        //CATF J 1 A_Chase;
        //CATF K 1 A_Chase;
        //CATF L 1 A_Chase;
        //CATF M 1 A_Chase;
        //CATF N 1 A_Chase;
        //CATF O 1 A_Chase;
        //CATF P 1 A_Chase;
        //CATF Q 1 A_Chase;
        //CATF R 1 A_Chase;
		Loop;
	Pain:
		CATC Q 1 A_Pain;
        CATC R 1;
        CATC S 1;
        CATC T 1;
        CATC U 1 A_SetReflectiveInvulnerable;
        CATC V 1;
        CATC W 1;
        CATC X 1;
        CATC Y 1;
        CATC Z 1;
        CATC [ 1;
        CATC \ 1;
        CATC ] 1;
        CATD A 1;
		CATB W 1;
        CATB X 1;
        CATB Y 1;
        CATB Z 1;
        CATB [ 1;
        CATB \ 1;
        CATB ] 1;
        CATC A 1;
        CATC B 1;
        CATC C 1;
        CATC DCBABCDCBABCDCBABCD 6 A_CentaurDefend;
        CATC E 1 A_UnsetReflectiveInvulnerable;
        CATC F 1;
        CATC G 1;
        CATC H 1;
        CATC I 1;
        CATC J 1;
        CATC K 1;
        CATC L 1;
        CATC M 1;
        CATC N 1;
        CATC O 1;
        CATC P 1;
		Goto See;
	Melee:
		CATA A 1 A_FaceTarget;
        CATA B 1 A_FaceTarget;
        CATA C 1 A_FaceTarget;
        CATA D 1 A_FaceTarget;
        CATA E 1 A_FaceTarget;
        CATA F 1 A_FaceTarget;
        CATA G 1 A_FaceTarget;
        CATA H 1 A_FaceTarget;
        CATA I 1 A_FaceTarget;
        CATA J 1 A_FaceTarget;
        CATA K 1 A_FaceTarget;
        CATA L 1 A_FaceTarget;
        CATA M 1 A_CustomMeleeAttack(random[CentaurAttack](3,9));
        CATA N 1 A_FaceTarget;
        CATA O 1 A_FaceTarget;
        CATA P 1 A_FaceTarget;
        CATA Q 1 A_FaceTarget;
        CATA R 1 A_FaceTarget;
        CATA S 1 A_FaceTarget;
        CATA T 1 A_FaceTarget;
        CATA U 1 A_FaceTarget;
        CATA V 1 A_FaceTarget;
        CATA W 1 A_FaceTarget;
        CATA X 1 A_FaceTarget;
        CATA Y 1 A_FaceTarget;
        CATA Z 1 A_FaceTarget;
        CATA [ 1 A_FaceTarget;
        CATA \ 1 A_FaceTarget;
		Goto See;
	Death:
		CATA ] 1;
        CATB A 1 A_Scream;
        CATB B 1;
        CATB C 1;
        CATB D 1;
        CATB E 1;
        CATB F 1;
        CATB G 1;
        CATB H 1;
        CATB I 1;
        CATB J 1;
        CATB K 1;
        CATB L 1;
        CATB M 1;
        CATB N 1;
        CATB O 1;
        CATB P 1;
        CATB Q 1;
        CATB R 1;
        CATB S 1;
        CATB T 1 A_NoBlocking;
        CATB U 1 A_QueueCorpse;
        CATB V -1;
		Stop;
	XDeath:
		CEXA A 2 A_SpawnItemEx("GibletsSpawnerDirectional");
        CEXA C 1 A_Scream;
        CEXA E 2 A_SpawnItemEx("GibletsSpawnerDirectional");
        CEXA G 1 A_NoBlocking;
        CEXA I 2;
        CEXA K 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        CEXA M 2 A_QueueCorpse;
        CEXA O 1;
        CEXA Q 2;
        CEXA S 1;
        CEXA U 2;
        CEXA W 1;
        CEXA Y 2;
        CEXA [ 1;
        CEXA ] 2;
        CEXB A 1;
        CEXB C 2;
        CEXB E 1;
        CEXB G 2;
        CEXB I 1;
        CEXB K 2;
        CEXB M 1;
        CEXB O 2;
        CEXB Q 1;
        CEXB S 2;
        CEXB U -1;
		Stop;
	//Ice:
		//CENT U 5 A_FreezeDeath;
		//CENT U 1 A_FreezeDeathChunks;
		//Wait;
	}	
}

class CCentaurLeader : CCentaur replaces CentaurLeader
{
	Default
	{
		Health 250;
		PainChance 96;
		Speed 4;
		+INTERPOLATEANGLES
		Obituary "$OB_SLAUGHTAUR";
		HitObituary "$OB_SLAUGHTAURHIT";
		Tag "$FN_SLAUGHTAUR";
	}
	States
	{
	Missile:
		CATD \ 1 A_FaceTarget;
        CATD ] 1 A_FaceTarget;
        CATE A 1 A_FaceTarget;
        CATE B 1 A_FaceTarget;
        CATE C 1 A_FaceTarget;
        CATE D 1 A_FaceTarget;
        CATE E 1 A_FaceTarget;
        CATE F 1 A_FaceTarget;
        CATE G 1 A_FaceTarget;
        CATE H 1 A_FaceTarget;
        CATE I 1 A_FaceTarget;
        CATE J 1 A_FaceTarget;
        CATE K 1 A_FaceTarget;
        CATE L 1 A_SpawnProjectile("CentaurFX", 45, 0, 0, CMF_AIMOFFSET);
        CATE M 1 A_SpawnProjectile("CentaurFX", 45, 0, 0, CMF_AIMOFFSET);
        CATE N 1 A_FaceTarget;
        CATE O 1 A_FaceTarget;
        CATE P 1 A_FaceTarget;
        CATE Q 1 A_FaceTarget;
        CATE R 1 A_FaceTarget;
        CATE S 1 A_FaceTarget;
        CATE T 1 A_FaceTarget;
        CATE U 1 A_FaceTarget;
        CATE V 1 A_FaceTarget;
        CATE W 1 A_FaceTarget;
        CATE X 1 A_FaceTarget;
        CATE Y 1 A_FaceTarget;
        CATE Z 1 A_FaceTarget;
		Goto See;
	}
}	