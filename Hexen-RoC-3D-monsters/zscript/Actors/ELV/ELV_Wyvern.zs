class CWyvern : Dragon replaces Dragon
{
	const WYVERN_ATTACK_RANGE = 64*8.;
	int fdstrafecount;
	Default
	{
		Health 640;
		PainChance 128;
		Speed 10;
		Height 85;
		Mass 0x7fffffff;
		Monster;
		+NOGRAVITY +FLOAT +NOBLOOD
		+BOSS
		+DONTMORPH +NOTARGET
		+NOICEDEATH
		+INTERPOLATEANGLES
		SeeSound "DragonSight";
		AttackSound "DragonAttack";
		PainSound "DragonPain";
		DeathSound "DragonDeath";
		ActiveSound "DragonActive";
		Obituary "$OB_DRAGON";
		Tag "$FN_DRAGON";
	}

	States
	{
	Spawn:
		WYTC P 2 A_Look;
		Loop;
	See:
		WYTC G 1 A_DragonInitFlight;
		WYTC G 0 A_DragonFlap;
		WYTC GHIJKLMNOPQRSTUVWXYZ[\ 2 A_DragonFlight;
		Goto See + 1;
	Pain:
		WYTB V 2 A_DragonPain;
		WYTB WXYZ[\] 2;
		WYTC ABCDEF 2;
		Goto See + 1;
	Missile:
		WYTA ABCDEFGHIJ 2;
		WYTA KKK 8 A_DragonAttack;
		WYTA LMNOPQRS 2;
		Goto See + 1;
	Death:
		WYTA T 2 A_Scream;
		WYTA U 2 A_NoBlocking;
		WYTA VWXYZ[\] 2;
		WYTB ABCDEFGHI 2;
		WYTB J 4 A_DragonCheckCrash;
		Wait;
	Crash:
		WYTB KLMNOPQRST 2;
		WYTB U -1;
		Stop;
	}
	
	//============================================================================
	//
	// DragonSeek
	//
	//============================================================================

	private void DragonSeek (double thresh, double turnMax)
	{
		double dist;
		double delta;
		Actor targ;
		int i;
		double bestAngle;
		double angleToSpot, angleToTarget;
		Actor mo;

		targ = tracer;
		if(targ == null)
		{
			return;
		}

		double diff = deltaangle(angle, AngleTo(targ));
		delta = abs(diff);

		if (delta > thresh)
		{
			delta /= 2;
			if (delta > turnMax)
			{
				delta = turnMax;
			}
		}
		if (diff > 0)
		{ // Turn clockwise
			angle = angle + delta;
		}
		else
		{ // Turn counter clockwise
			angle = angle - delta;
		}
		VelFromAngle();

		dist = DistanceBySpeed(targ, Speed);
		if (pos.z + height < targ.pos.z || targ.pos.z + targ.height < pos.z)
		{
			Vel.Z = (targ.pos.z - pos.z) / dist;
		}
		if (targ.bShootable && random[DragonSeek]() < 64)
		{ // attack the destination mobj if it's attackable
			Actor oldTarget;
			
			if (absangle(angle, AngleTo(targ)) < 22.5)
			{
				oldTarget = target;
				target = targ;
				if (CheckMeleeRange ())
				{
					int damage = random[DragonSeek](1, 8) * 10;
					int newdam = targ.DamageMobj (self, self, damage, 'Melee');
					targ.TraceBleed (newdam > 0 ? newdam : damage, self);
					A_StartSound (AttackSound, CHAN_WEAPON);
				}
				else if (random[DragonSeek]() < 128 && CheckMissileRange())
				{
					SpawnMissile(targ, "DragonFireball");		
					A_StartSound (AttackSound, CHAN_WEAPON);
				}
				target = oldTarget;
			}
		}
		if (dist < 4)
		{ // Hit the target thing
			if (target && random[DragonSeek]() < 200)
			{
				Actor bestActor = null;
				bestAngle = 360.;
				angleToTarget = AngleTo(target);
				for (i = 0; i < 5; i++)
				{
					if (!targ.args[i])
					{
						continue;
					}
					ActorIterator iter = Level.CreateActorIterator(targ.args[i]);
					mo = iter.Next ();
					if (mo == null)
					{
						continue;
					}
					angleToSpot = AngleTo(mo);
					double diff = absangle(angleToSpot, angleToTarget);
					if (diff < bestAngle)
					{
						bestAngle = diff;
						bestActor = mo;
					}
				}
				if (bestActor != null)
				{
					tracer = bestActor;
				}
			}
			else
			{
				// [RH] Don't lock up if the dragon doesn't have any
				// targs defined
				for (i = 0; i < 5; ++i)
				{
					if (targ.args[i] != 0)
					{
						break;
					}
				}
				if (i < 5)
				{
					do
					{
						i = (random[DragonSeek]() >> 2) % 5;
					} while(!targ.args[i]);
					ActorIterator iter = Level.CreateActorIterator(targ.args[i]);
					tracer = iter.Next ();
				}
			}
		}
	}

	//============================================================================
	//
	// A_DragonInitFlight
	//
	//============================================================================

	void A_DragonInitFlight()
	{
		ActorIterator iter = Level.CreateActorIterator(tid);

		do
		{ // find the first tid identical to the dragon's tid
			tracer = iter.Next ();
			if (tracer == null)
			{
				SetState (SpawnState);
				return;
			}
		} while (tracer == self);
		RemoveFromHash ();
	}

	//============================================================================
	//
	// A_DragonFlight
	//
	//============================================================================

	void A_DragonFlight()
	{
		double ang;

		DragonSeek (4., 8.);
		let targ = target;
		if (targ)
		{
			if(!target.bShootable)
			{ // target died
				target = null;
				return;
			}
			ang = absangle(angle, AngleTo(target));
			if (ang <22.5 && CheckMeleeRange())
			{
				int damage = random[DragonFlight](1, 8) * 8;
				int newdam = targ.DamageMobj (self, self, damage, 'Melee');
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
				A_StartSound (AttackSound, CHAN_WEAPON);
			}
			else if (ang <= 20)
			{
				SetState (MissileState);
				A_StartSound (AttackSound, CHAN_WEAPON);
			}
		}
		else
		{
			LookForPlayers (true);
		}
	}

	//============================================================================
	//
	// A_DragonFlap
	//
	//============================================================================

	void A_DragonFlap()
	{
		A_DragonFlight();
		if (random[DragonFlight]() < 240)
		{
			A_StartSound ("DragonWingflap", CHAN_BODY);
		}
		else
		{
			PlayActiveSound ();
		}
	}

	//============================================================================
	//
	// A_DragonAttack
	//
	//============================================================================

	void A_DragonAttack()
	{
		SpawnMissile (target, "DragonFireball");
	}


	//============================================================================
	//
	// A_DragonPain
	//
	//============================================================================

	void A_DragonPain()
	{
		A_Pain();
		if (!tracer)
		{ // no destination spot yet
			SetState (SeeState);
		}
	}

	//============================================================================
	//
	// A_DragonCheckCrash
	//
	//============================================================================

	void A_DragonCheckCrash()
	{
		if (pos.z <= floorz)
		{
			SetStateLabel ("Crash");
		}
	}
	void A_WyvernChase()
	{
		int weaveindex = special1;
		double ang;
		double dist;

		if (reactiontime) reactiontime--;
		if (threshold) threshold--;

		// Float up and down
		//AddZ(BobSin(weaveindex));
		//special1 = (weaveindex + 2) & 63;

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
			if (dist < WYVERN_ATTACK_RANGE)
			{
				if (random[WyvernChase]() < 30)
				{
					ang = AngleTo(target);
					if (random[WyvernChase]() < 128)
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
			if (CheckMissileRange () && (random[WyvernChase]() < 20))
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
		if (random[WyvernChase]() < 3)
		{
			PlayActiveSound ();
		}
	}
}