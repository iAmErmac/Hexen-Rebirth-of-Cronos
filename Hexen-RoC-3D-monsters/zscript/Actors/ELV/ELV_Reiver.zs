
// Wraith -------------------------------------------------------------------

class CReiver : Wraith replaces Wraith
{
	Default
	{
		Health 150;
		PainChance 25;
		Speed 3;
		Height 55;
		Mass 75;
		Damage 10;
		Monster;
		+NOGRAVITY +DROPOFF +FLOAT
		+TELESTOMP
		+INTERPOLATEANGLES
		SeeSound "WraithSight";
		AttackSound "WraithAttack";
		PainSound "WraithPain";
		DeathSound "WraithDeath";
		ActiveSound "WraithActive";
		HitObituary "$OB_WRAITHHIT";
		Obituary "$OB_WRAITH";
		Tag "$FN_WRAITH";
	}

	States
	{
	Spawn:
		RATC R 10;
		RATC R 5 A_WraithInit;
		Goto Look;
	Look:
		RATC RSTUVWXYZ[\] 2 A_Look;
		RATD ABCDEFGHIJKLMN 2 A_Look;
		Loop;
	See:
		RATD OPQRSTUVWXYZ[\] 2 A_WraithChase;
        RATE ABCDEFGHI 2 A_WraithChase;
		Loop;
	Pain:
		RATC G 1 A_Pain;
		RATC HIJKLMNOPQ 1;
		Goto See;
	Melee:
		RATA ABCDEFGHIJ 1 A_FaceTarget;
		RATA K 1 A_WraithFX3;
		RATA L 1 A_WraithMelee;
		RATA MNOPQRSTUVWX 1;
		Goto See;
	Missile:
		RATE JKLMNOPQRSTUVWXYZ[\] 1 A_FaceTarget;
		RATE X 1 A_SpawnProjectile("WraithFX1");
		RATE YZ[\] 1;
		RATF ABCDEF 1;
		Goto See;
	Death:
		RATF G 1 A_Scream;
		RATF HIJKLM 1;
		RATF N 1 A_NoBlocking;
		RATF O 1 A_QueueCorpse;
		RATF P 1;
		RATF Q 1;
		Stop;
	}
	
	//============================================================================
	//
	// A_WraithInit
	//
	//============================================================================

	void A_WraithInit()
	{
		AddZ(48);

		// [RH] Make sure the wraith didn't go into the ceiling
		if (pos.z + height > ceilingz)
		{
			SetZ(ceilingz - Height);
		}

		WeaveIndexZ = 0;			// index into floatbob
	}


	//============================================================================
	//
	// A_WraithChase
	//
	//============================================================================

	void A_WraithChase()
	{
		int weaveindex = WeaveIndexZ;
		AddZ(BobSin(weaveindex));
		WeaveIndexZ = (weaveindex + 2) & 63;
		A_Chase ();
		A_WraithFX4 ();
	}

	//============================================================================
	//
	// A_WraithFX3
	//
	// Spawn an FX3 around the wraith during attacks
	//
	//============================================================================

	void A_WraithFX3()
	{
		int numdropped = random[WraithFX3](0,14);

		while (numdropped-- > 0)
		{
			double xo = (random[WraithFX3]() - 128) / 32.;
			double yo = (random[WraithFX3]() - 128) / 32.;
			double zo = random[WraithFX3]() / 64.;

			Actor mo = Spawn("WraithFX3", Vec3Offset(xo, yo, zo), ALLOW_REPLACE);
			if (mo)
			{
				mo.floorz = floorz;
				mo.ceilingz = ceilingz;
				mo.target = self;
			}
		}
	}

	//============================================================================
	//
	// A_WraithFX4
	//
	// Spawn an FX4 during movement
	//
	//============================================================================

	void A_WraithFX4 ()
	{
		int chance = random[WraithFX4]();
		bool spawn4, spawn5;

		if (chance < 10)
		{
			spawn4 = true;
			spawn5 = false;
		}
		else if (chance < 20)
		{
			spawn4 = false;
			spawn5 = true;
		}
		else if (chance < 25)
		{
			spawn4 = true;
			spawn5 = true;
		}
		else
		{
			spawn4 = false;
			spawn5 = false;
		}

		if (spawn4)
		{
			double xo = (random[WraithFX4]() - 128) / 16.;
			double yo = (random[WraithFX4]() - 128) / 16.;
			double zo = (random[WraithFX4]() / 64.);

			Actor mo = Spawn ("WraithFX4", Vec3Offset(xo, yo, zo), ALLOW_REPLACE);
			if (mo)
			{
				mo.floorz = floorz;
				mo.ceilingz = ceilingz;
				mo.target = self;
			}
		}
		if (spawn5)
		{
			double xo = (random[WraithFX4]() - 128) / 32.;
			double yo = (random[WraithFX4]() - 128) / 32.;
			double zo = (random[WraithFX4]() / 64.);

			Actor mo = Spawn ("WraithFX5", Vec3Offset(xo, yo, zo), ALLOW_REPLACE);
			if (mo)
			{
				mo.floorz = floorz;
				mo.ceilingz = ceilingz;
				mo.target = self;
			}
		}
	}

	//============================================================================
	//
	// A_WraithMelee
	//
	//============================================================================

	void A_WraithMelee()
	{
		// Steal health from target and give to self
		if (CheckMeleeRange() && (random[StealHealth]()<220))
		{
			int amount = random[StealHealth](1, 8) * 2;
			target.DamageMobj (self, self, amount, 'Melee');
			health += amount;
		}
	}
}

class CReiverBuried : CReiver replaces WraithBuried
{
	Default
	{
		Height 68;
		-SHOOTABLE
		-SOLID
		+DONTMORPH
		+DONTBLAST
		+STAYMORPHED
		+INVISIBLE
		PainChance 0;
	}
	States
	{
	Spawn:
		Goto Super::Look;
	See:
		RATA Y 3 A_WraitHeigth;
		RATA Y 3 A_WraithRaiseInit;
		RATA Z 3 A_WraithRaise;
		RATA [ 3;
		RATA \ 3;
		RATA ] 3;
        RATB ABCDEFGHIJKLMNOPQRSTUVWXYZ[\] 3;
        RATC ABC 3;
		RATC D 3;
		RATC E 3;
		RATC F 3;
		RATC F 3 A_WraitHeigth2;
		Goto Chase;
	Chase:
		Goto Super::See;
	}
	//============================================================================
	//
	// A_WraithRaiseInit
	//
	//============================================================================

	void A_WraithRaiseInit()
	{
		bInvisible = false;
		bNonShootable = false;
		bDontBlast = false;
		bShootable = true;
		bSolid = true;
		Floorclip = Height;
	}

	//============================================================================
	//
	// A_WraithRaise
	//
	//============================================================================

	void A_WraithRaise()
	{
		if (RaiseMobj (2))
		{
			// Reached it's target height
			// [RH] Once a buried wraith is fully raised, it should be
			// morphable, right?
			bDontMorph = false;
			bSpecialFloorClip = false;
			// [RH] Reset PainChance to a normal wraith's.
			PainChance = GetDefaultByType("Wraith").PainChance;
		}

		SpawnDirt (radius);
	}
	
	void A_WraitHeigth()
	{
		AddZ(1);
	}
	
	void A_WraitHeigth2()
	{
		AddZ(48);
	}

}