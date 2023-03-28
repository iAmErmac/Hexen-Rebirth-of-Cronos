class CAfrit : Actor replaces FireDemon
{
	const FIREDEMON_ATTACK_RANGE = 64*8.;
	int fdstrafecount;

	Default
	{
		Health 80;
		ReactionTime 8;
		PainChance 1;
		Speed 5;
		Radius 20;
		Height 68;
		Mass 75;
		Damage 1;
		Monster;
		+DROPOFF +NOGRAVITY +FLOAT
		+FLOORCLIP +INVULNERABLE +TELESTOMP
		+INTERPOLATEANGLES
		SeeSound "FireDemonSpawn";
		PainSound "FireDemonPain";
		DeathSound "FireDemonDeath";
		ActiveSound "FireDemonActive";
		Obituary "$OB_FIREDEMON";
		Tag "$FN_FIREDEMON";
	}

	States
	{
	Spawn:
		AFTC U 10 A_Look;
        AFTC U 1 A_Look;
		Goto Spawn + 1;
	See:
		AFTD A 0;
		AFTC UV 3;
		AFTC W 1 A_FiredRocks;
		AFTC X 3;
		AFTC YZ[\ 3;
		AFTC ] 1 A_UnSetInvulnerable;
	Chase:
		AFTC EFGHIJKLMNOPQRST 2 A_FiredChase;
		Loop;
	Pain:
		AFTA X 1 A_UnSetInvulnerable;
        AFTA Y 1 A_Pain;
        AFTA Z[\] 1;
        AFTB ABCDEFGHIJKL 1;
		Goto Chase;
	Missile:
		AFTA ABCDEFGHIJKLMN 1 A_FaceTarget;
        AFTA OPQ 4 A_FiredAttack;
        AFTA RSTUVW 1;
		Goto Chase;
	XDeath:
		FDMN M 5 A_FaceTarget;
		FDMN N 5 A_NoBlocking;
		FDMN O 5 A_FiredSplotch;
		Stop;
	Death:
		AFTD B 2 A_Scream;
		AFTD C 2 A_NoBlocking;
		AFTD DEFGHIJK 2;
		AFTD LMNOPQRSTU 2;
		AFTD V 2 Offset(0,33) A_CheckCrash;
		Goto Death + 3;
	Crash:
		AFTD WXY 2;
		AFTD Z 2 A_NoBlocking;
		AFTD [ -1 A_MoveAfrit;
		Stop;
	}
	
	void A_MoveAfrit()
	{
		{
		AddZ(-5, false);
		}
	}
	
	void A_CheckCrash()
	{
		if (pos.z <= floorz)
		{
			SetStateLabel ("Crash");
		}
	}

	//============================================================================
	// Fire Demon AI
	//
	// special1			index into floatbob
	// fdstrafecount			whether strafing or not
	//============================================================================

	//============================================================================
	//
	// A_FiredSpawnRock
	//
	//============================================================================

	private void A_FiredSpawnRock ()
	{
		Actor mo;
		class<Actor> rtype;

		switch (random[FireDemonRock](0, 4))
		{
			case 0:
				rtype = "FireDemonRock1";
				break;
			case 1:
				rtype = "FireDemonRock2";
				break;
			case 2:
				rtype = "FireDemonRock3";
				break;
			case 3:
				rtype = "FireDemonRock4";
				break;
			case 4:
			default:
				rtype = "FireDemonRock5";
				break;
		}

		double xo = (random[FireDemonRock]() - 128) / 16.;
		double yo = (random[FireDemonRock]() - 128) / 16.;
		double zo = random[FireDemonRock]() / 32.;
		mo = Spawn (rtype, Vec3Offset(xo, yo, zo), ALLOW_REPLACE);
		if (mo)
		{
			mo.target = self;
			mo.Vel.X = (random[FireDemonRock]() - 128) / 64.;
			mo.Vel.Y = (random[FireDemonRock]() - 128) / 64.;
			mo.Vel.Z = (random[FireDemonRock]() / 64.);
			mo.special1 = 2;		// Number bounces
		}

		// Initialize fire demon
		fdstrafecount = 0;
		bJustAttacked = false;
	}

	//============================================================================
	//
	// A_FiredRocks
	//
	//============================================================================
	void A_FiredRocks()
	{
		A_FiredSpawnRock ();
		A_FiredSpawnRock ();
		A_FiredSpawnRock ();
		A_FiredSpawnRock ();
		A_FiredSpawnRock ();
	}

	//============================================================================
	//
	// A_FiredAttack
	//
	//============================================================================

	void A_FiredAttack()
	{
		if (target == null)	return;
		Actor mo = SpawnMissile (target, "FireDemonMissile");
		if (mo) A_StartSound ("FireDemonAttack", CHAN_BODY);
	}

	//============================================================================
	//
	// A_FiredChase
	//
	//============================================================================

	void A_FiredChase()
	{
		int weaveindex = special1;
		double ang;
		double dist;

		if (reactiontime) reactiontime--;
		if (threshold) threshold--;

		// Float up and down
		AddZ(BobSin(weaveindex));
		special1 = (weaveindex + 2) & 63;

		// Ensure it stays above certain height
		if (pos.Z < floorz + 64)
		{
			AddZ(2);
		}

		if(!target || !target.bShootable)
		{	// Invalid target
			LookForPlayers (true);
			return;
		}

		// Strafe
		if (fdstrafecount > 0)
		{
			fdstrafecount--;
		}
		else
		{
			fdstrafecount = 0;
			Vel.X = Vel.Y = 0;
			dist = Distance2D(target);
			if (dist < FIREDEMON_ATTACK_RANGE)
			{
				if (random[FiredChase]() < 30)
				{
					ang = AngleTo(target);
					if (random[FiredChase]() < 128)
						ang += 90;
					else
						ang -= 90;
					Thrust(8, ang);
					fdstrafecount = 3;		// strafe time
				}
			}
		}

		FaceMovementDirection ();

		// Normal movement
		if (!fdstrafecount)
		{
			if (--movecount<0 || !MonsterMove ())
			{
				NewChaseDir ();
			}
		}

		// Do missile attack
		if (!bJustAttacked)
		{
			if (CheckMissileRange () && (random[FiredChase]() < 20))
			{
				SetState (MissileState);
				bJustAttacked = true;
				return;
			}
		}
		else
		{
			bJustAttacked = false;
		}

		// make active sound
		if (random[FiredChase]() < 3)
		{
			PlayActiveSound ();
		}
	}

	//============================================================================
	//
	// A_FiredSplotch
	//
	//============================================================================

	void A_FiredSplotch()
	{
		Actor mo;

		mo = Spawn ("FireDemonSplotch1", Pos, ALLOW_REPLACE);
		if (mo)
		{
			mo.Vel.X = (random[FireDemonSplotch]() - 128) / 32.;
			mo.Vel.Y = (random[FireDemonSplotch]() - 128) / 32.;
			mo.Vel.Z = (random[FireDemonSplotch]() / 64.) + 3;
		}
		mo = Spawn ("FireDemonSplotch2", Pos, ALLOW_REPLACE);
		if (mo)
		{
			mo.Vel.X = (random[FireDemonSplotch]() - 128) / 32.;
			mo.Vel.Y = (random[FireDemonSplotch]() - 128) / 32.;
			mo.Vel.Z = (random[FireDemonSplotch]() / 64.) + 3;
		}
	}
	
}