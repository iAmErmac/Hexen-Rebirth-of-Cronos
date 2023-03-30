class CPig : MorphedMonster replaces Pig
{
	Default
	{
		Health 25;
		Painchance 128;
		Speed 10;
		Radius 12;
		Height 22;
		Mass 60;
		Monster;
		-COUNTKILL
		+WINDTHRUST
		+DONTMORPH
		+INTERPOLATEANGLES
		SeeSound "PigActive1";
		PainSound "PigPain";
		DeathSound "PigDeath";
		ActiveSound "PigActive1";
	}
	
	action void A_SpawnGiblet()
	{
		string gsClassName = "GibletsSpawnerDirectional";
		class<Actor> gibletSpawnerLoaded = gsClassName;
		
		if(gibletSpawnerLoaded)
			invoker.A_SpawnItemEx(gsClassName);
	}

	States
	{
	Spawn:
		PGTA A 10 A_Look;
		Loop;
	See:
		PGTA ABCDEFGHIJKLMN 2 A_Chase;
		Loop;
	Melee:
		PGTA A 5 A_FaceTarget;
		PGTA A 10 A_CustomMeleeAttack(random[PigAttack](2,3), "PigAttack");
		Goto See;
	Pain:
		PGTA F 2 A_PigPain;
		Goto See;
	Death:
		PGTA F 1 A_Scream;
		PGTA F 0 A_NoBlocking;
		
		PIXA A 1 A_Scream;
        PIXA B 1 A_SpawnGiblet();
        PIXA C 1 A_NoBlocking;
        PIXA D 1 A_SpawnGiblet();
        PIXA E 1 A_SpawnGiblet();
        PIXA F 1 A_QueueCorpse;
        PIXA G 1;
        PIXA H 1;
        PIXA I 1;
        PIXA J 1;
        PIXA K 1;
        PIXA L 1;
        PIXA M 1;
        PIXA N 1;
        PIXA O 1;
        PIXA P 1;
        PIXA Q 1;
        PIXA R 1;
        PIXA S 1;
        PIXA T 1;
        PIXA U 1;
        PIXA V 1;
        PIXA W 1;
        PIXA X 1;
        PIXA Y 1;
        PIXA Z 1;
        PIXA [ 1;
        PIXA \ 1;
        PIXA ] 1;
        PIXB A 1;
        PIXB B 1;
        PIXB C 1;
        PIXB D 1;
        PIXB E 1;
        PIXB F 1;
        PIXB G 1;
        PIXB H 1;
        PIXB I -1;
		Stop;
	}
	void A_PigPain ()
	{
		A_Pain();
		if (pos.z <= floorz)
		{
			Vel.Z = 3.5;
		}
	}
}