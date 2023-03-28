class CStalker : Actor replaces Serpent
{
	Default
	{
		Health 90;
		PainChance 96;
		Speed 4;
		Radius 32;
		Height 70;
		Mass 0x7fffffff;
		Monster;
		-SHOOTABLE
		+NOBLOOD
		+CANTLEAVEFLOORPIC +NONSHOOTABLE
		+STAYMORPHED +DONTBLAST +NOTELEOTHER
		+INVISIBLE
		+INTERPOLATEANGLES
		SeeSound "SerpentSight";
		AttackSound "SerpentAttack";
		PainSound "SerpentPain";
		DeathSound "SerpentDeath";
		HitObituary "$OB_SERPENTHIT";
		Tag "$FN_SERPENT";
	}

	States
	{
	Spawn:
		STTA X 10 A_Look;
		Loop;
	See:
		STTA XX 1 A_Chase("Melee", null, CHF_NIGHTMAREFAST|CHF_NOPLAYACTIVE);
		STTA X 2 A_SerpentHumpDecide;
		Loop;
	Pain:
		STTD IJKLMNOPQR 2;
		STTD S 2 A_Pain;
		Goto DiveDown;
	Dive:
		STTA X 1;
		STTA Y 1 A_UnSetShootable;
		STTA Z 2 A_StartSound ("SerpentActive", CHAN_BODY);
		STTA [\] 2;
		STTB ABCDEFGHIJKLMN 2;
		STTB OPQRSTUVWXYZ[\] 2;
		STTC ABCD 2;
		STTC E 3 A_SerpentHide;
		Goto See;
	Melee:
		STTA X 1 A_UnHideThing;
		STTA Y 1 A_StartSound ("SeprentBirth", CHAN_BODY);
		STTA Z 2 A_SetShootable;
		STTA [\] 2;
		STTB ABCDEFGHIJKLMN 2;
		STTB O 4 A_SerpentCheckForAttack;
		Goto Dive;
	Death:
		STTG A 1 A_Scream;
		STTG BCDEFGHIJKLM 1;
		STTG M 1 A_NoBlocking;
		STTG NOPQRSTU 1;
		Stop;
	XDeath:
		/*STTG A 1 A_Scream;
		STTG BCDEFGHIJKLM 1;
		STTG M 1 A_NoBlocking;
		STTG NOPQRSTU 1;*/
		
		STXA A 1 A_Scream;
        STXA B 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA C 1 A_NoBlocking;
        STXA D 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA E 1 A_QueueCorpse;
        STXA F 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA G 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA H 1;
        STXA I 1;
        STXA J 1;
        STXA K 1;
        STXA L 1;
        STXA M 1;
        STXA N 1;
        STXA O 1;
        STXA P 1;
        STXA Q 1;
        STXA R 1;
        STXA S 1;
        STXA T 1;
        STXA U 1;
        STXA V 1;
        STXA W 1;
        STXA X 1;
        STXA Y 1;
        STXA Z 1;
        STXA [ 1;
        STXA \ 1;
        STXA ] 1;
        STXB A 1;
        STXB B 1;
        STXB C 1;
        STXB D 1;
        STXB E 1;
        STXB F 1;
        STXB G 1;
        STXB H 1;
        STXB I 1;
        STXB J -1;
		Stop;
	Walk:
		STTF NOPQRSTUVWXYZ[\ 2 A_Chase("Attack", null, CHF_NIGHTMAREFAST);
		STTF ] 5 A_SerpentCheckForAttack;
		Goto DiveDown;
	Hump:
		STTE L 3 A_SerpentUnHide;
		STTE MNOPQRSTUVWXYZ[\] 2;
		STTF ABCDEFGHIJKL 2;
		STTF M 2 A_SerpentHide;
		Goto See;
	Attack:
		STTA A 6 A_FaceTarget;
		STTA B 5 A_SerpentChooseAttack;
		Goto MeleeAttack;
	MeleeAttack:
		STTA ABCDEFGHIJKLM 1;
		STTA N 1 A_SerpentMeleeAttack;
		STTA OPQRSTUV 1;
		Goto DiveDown;
	DiveDown:
		STTB PQRSTUVWXYZ[\] 2;
		STTC ABCDE 2;
		Goto Dive;
	}
	
	//============================================================================
	//
	// A_SerpentUnHide
	//
	//============================================================================

	void A_SerpentUnHide()
	{
		bInvisible = false;
		Floorclip = 24;
	}

	//============================================================================
	//
	// A_SerpentHide
	//
	//============================================================================

	void A_SerpentHide()
	{
		bInvisible = true;
		Floorclip = 0;
	}

	//============================================================================
	//
	// A_SerpentRaiseHump
	// 
	// Raises the hump above the surface by raising the floorclip level
	//============================================================================

	void A_SerpentRaiseHump()
	{
		Floorclip -= 4;
	}

	//============================================================================
	//
	// A_SerpentLowerHump
	// 
	//============================================================================

	void A_SerpentLowerHump()
	{
		Floorclip += 4;
	}

	//============================================================================
	//
	// A_SerpentHumpDecide
	//
	//		Decided whether to hump up, or if the mobj is a serpent leader, 
	//			to missile attack
	//============================================================================

	void A_SerpentHumpDecide()
	{
		if (MissileState != NULL)
		{
			if (random[SerpentHump]() > 30)
			{
				return;
			}
			else if (random[SerpentHump]() < 40)
			{ // Missile attack
				SetState (MeleeState);
				return;
			}
		}
		else if (random[SerpentHump]() > 3)
		{
			return;
		}
		if (!CheckMeleeRange ())
		{ // The hump shouldn't occur when within melee range
			if (MissileState != NULL && random[SerpentHump]() < 128)
			{
				SetState (MeleeState);
			}
			else
			{	
				SetStateLabel("Hump");
				A_StartSound ("SerpentActive", CHAN_BODY);
			}
		}
	}

	//============================================================================
	//
	// A_SerpentCheckForAttack
	//
	//============================================================================

	void A_SerpentCheckForAttack()
	{
		if (!target)
		{
			return;
		}
		if (MissileState != NULL)
		{
			if (!CheckMeleeRange ())
			{
				SetStateLabel ("Attack");
				return;
			}
		}
		if (CheckMeleeRange2 ())
		{
			SetStateLabel ("Walk");
		}
		else if (CheckMeleeRange ())
		{
			if (random[SerpentAttack]() < 32)
			{
				SetStateLabel ("Walk");
			}
			else
			{
				SetStateLabel ("Attack");
			}
		}
	}

	//============================================================================
	//
	// A_SerpentChooseAttack
	//
	//============================================================================
	
	void A_SerpentChooseAttack()
	{
		if (!target || CheckMeleeRange())
		{
			return;
		}
		if (MissileState != NULL)
		{
			SetState (MissileState);
		}
	}
		
	//============================================================================
	//
	// A_SerpentMeleeAttack
	//
	//============================================================================

	void A_SerpentMeleeAttack()
	{
		let targ = target;
		if (!targ)
		{
			return;
		}
		if (CheckMeleeRange ())
		{
			int damage = random[SerpentAttack](1, 8) * 5;
			int newdam = targ.DamageMobj (self, self, damage, 'Melee');
			targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			A_StartSound ("SerpentMeleeHit", CHAN_BODY);
		}
		if (random[SerpentAttack]() < 96)
		{
			A_SerpentCheckForAttack();
		}
	}

	//============================================================================
	//
	// A_SerpentSpawnGibs
	//
	//============================================================================

	void A_SerpentSpawnGibs()
	{
		static const class<Actor> GibTypes[] =
		{
			"SerpentGib3",
			"SerpentGib2",
			"SerpentGib1"
		};

		for (int i = 2; i >= 0; --i)
		{
			double x = (random[SerpentGibs]() - 128) / 16.;
			double y = (random[SerpentGibs]() - 128) / 16.;

			Actor mo = Spawn (GibTypes[i], Vec2OffsetZ(x, y, floorz + 1), ALLOW_REPLACE);
			if (mo)
			{
				mo.Vel.X = (random[SerpentGibs]() - 128) / 1024.f;
				mo.Vel.Y = (random[SerpentGibs]() - 128) / 1024.f;
				mo.Floorclip = 6;
			}
		}
	}
}

class CStalkerBoss : CStalker replaces SerpentLeader
{
	Default
	{
		Mass 200;
		Obituary "$OB_SERPENT";
	}
	States
	{
	Spawn:
		STTA X 10 A_Look;
		Loop;
	See:
		STTA XX 1 A_Chase("Melee", null, CHF_NIGHTMAREFAST|CHF_NOPLAYACTIVE);
		STTA X 2 A_SerpentHumpDecide;
		Loop;
	Pain:
		STTD IJKLMNOPQR 2;
		STTD S 2 A_Pain;
		Goto DiveDown;
	Dive:
		STTA X 1;
		STTA Y 1 A_UnSetShootable;
		STTA Z 2 A_StartSound ("SerpentActive", CHAN_BODY);
		STTA [\] 2;
		STTB ABCDEFGHIJKLMN 2;
		STTB OPQRSTUVWXYZ[\] 2;
		STTC ABCD 2;
		STTC E 3 A_SerpentHide;
		Goto See;
	Melee:
		STTA X 1 A_UnHideThing;
		STTA Y 1 A_StartSound ("SeprentBirth", CHAN_BODY);
		STTA Z 2 A_SetShootable;
		STTA [\] 2;
		STTB ABCDEFGHIJKLMN 2;
		STTB O 4 A_SerpentCheckForAttack;
		Goto Dive;
	Death:
		STTG A 1 A_Scream;
		STTG BCDEFGHIJKLM 1;
		STTG M 1 A_NoBlocking;
		STTG NOPQRSTU 1;
		Stop;
	XDeath:
	/*
		STTG A 1 A_Scream;
		STTG BCDEFGHIJKLM 1;
		STTG M 1 A_NoBlocking;
		STTG NOPQRSTU 1;*/
		
		STXA A 1 A_Scream;
        STXA B 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA C 1 A_NoBlocking;
        STXA D 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA E 1 A_QueueCorpse;
        STXA F 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA G 1 A_SpawnItemEx("GibletsSpawnerDirectional");
        STXA H 1;
        STXA I 1;
        STXA J 1;
        STXA K 1;
        STXA L 1;
        STXA M 1;
        STXA N 1;
        STXA O 1;
        STXA P 1;
        STXA Q 1;
        STXA R 1;
        STXA S 1;
        STXA T 1;
        STXA U 1;
        STXA V 1;
        STXA W 1;
        STXA X 1;
        STXA Y 1;
        STXA Z 1;
        STXA [ 1;
        STXA \ 1;
        STXA ] 1;
        STXB A 1;
        STXB B 1;
        STXB C 1;
        STXB D 1;
        STXB E 1;
        STXB F 1;
        STXB G 1;
        STXB H 1;
        STXB I 1;
        STXB J -1;
		Stop;
	Walk:
		STTF NOPQRSTUVWXYZ[\ 2 A_Chase("Attack", null, CHF_NIGHTMAREFAST);
		STTF ] 5 A_SerpentCheckForAttack;
		Goto DiveDown;
	Hump:
		STTE L 3 A_SerpentUnHide;
		STTE MNOPQRSTUVWXYZ[\] 2;
		STTF ABCDEFGHIJKL 2;
		STTF M 2 A_SerpentHide;
		Goto See;
	Attack:
		STTA A 6 A_FaceTarget;
		STTA B 5 A_SerpentChooseAttack;
		Goto MeleeAttack;
	MeleeAttack:
		STTA ABCDEFGHIJKLM 1;
		STTA N 1 A_SerpentMeleeAttack;
		STTA OPQRSTUV 1;
		Goto DiveDown;
	DiveDown:
		STTB PQRSTUVWXYZ[\] 2;
		STTC ABCDE 2;
		Goto Dive;
	Missile:
		MeleeAttack:
		STTA ABCDEFGHIJKLM 1;
		STTA N 1 A_SpawnProjectile("SerpentFX", 32, 0);
		STTA OPQRSTUV 1;
		Goto DiveDown;
	}
}