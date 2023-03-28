class CHeresiarch : Heresiarch replaces Heresiarch
{
	
	const SORCBALL_INITIAL_SPEED 		= 7;
	const SORCBALL_TERMINAL_SPEED		= 25;
	const SORCBALL_SPEED_ROTATIONS 		= 5;
	const SORC_DEFENSE_TIME				= 255;
	const SORC_DEFENSE_HEIGHT			= 45;
	const BOUNCE_TIME_UNIT				= (35/2);
	const SORCFX4_RAPIDFIRE_TIME		= (6*3);		// 3 seconds
	const SORCFX4_SPREAD_ANGLE			= 20;

	enum ESorc
	{
		SORC_DECELERATE,	
		SORC_ACCELERATE, 
		SORC_STOPPING,	
		SORC_FIRESPELL,	
		SORC_STOPPED,	
		SORC_NORMAL,		
		SORC_FIRING_SPELL
	}

	const BALL1_ANGLEOFFSET	= 0.;
	const BALL2_ANGLEOFFSET	= 120.;
	const BALL3_ANGLEOFFSET	= 240.;

	double BallAngle;
	class<SorcBall> StopBall;
	
	Default
	{
		Health 5000;
		Painchance 10;
		Speed 16;
		Radius 40;
		Height 110;
		Mass 500;
		Damage 9;
		Monster;
		+FLOORCLIP
		+BOSS
		+DONTMORPH
		+NOTARGET
		+NOICEDEATH
		+DEFLECT
		+NOBLOOD
		+INTERPOLATEANGLES
		SeeSound "SorcererSight";
		PainSound "SorcererPain";
		DeathSound "SorcererDeathScream";
		ActiveSound "SorcererActive";
		Obituary "$OB_HERESIARCH";
		Tag "$FN_HERESIARCH";
	}
	
	States
	{
	Spawn:
		HBTD K 3;
		HBTD K 2 A_SorcSpinBalls;
	Idle:
		HBTD KLMNOPQRSTUVWXYZ[\] 2 A_Look;
		HBTE ABCDEFGHIJKL 2 A_Look;
		Wait;
	See:
		HBTC STUVWXYZ[\] 2 A_Chase;
		HBTD ABCDEFGHIJ 2 A_Chase;
		Loop;
	Pain:
		HBTC HIJKLMNOPQ 2;
		HBTC R 2 A_Pain;
		Goto See;
	Missile:
		HBTB F 2 A_FaceTarget;
		HBTB GHIJKLMN 2 A_FaceTarget;
		HBTB O 2 A_SpeedBalls;
		HBTB PQRSTUVWXYZ[\] 2 A_FaceTarget;
		HBTC ABCDEFG 2 A_FaceTarget;
		Wait;
	Attack1:
		HBTA ABCDEFGHIJKL 2 A_FaceTarget;
		HBTA M 2 A_SpawnFizzle;
		HBTA NOPQRSTUVWXYZ[\] 2 A_FaceTarget;
		HBTB ABCDE 2 A_FaceTarget;
		Goto Attack1;
	Attack2:
		HBTA ABCDEFGHIJKL 2 A_FaceTarget;
		HBTA M 2 A_SorcBossAttack;
		HBTA NOPQRSTUVWXYZ[\] 2 A_FaceTarget;
		HBTB ABCDE 2 A_FaceTarget;
		Goto See;
	Death:
		HBTD K 1;
		HBTD L 1 A_Scream;
		HBTD M 1 A_SpawnItemEx("HereFire",0,0,0);
		HBTD N 1 A_NoBlocking; 
		HBTD O 1;
		HBTD P 1;
		HBTD Q 1;
		HBTD R 1;
		HBTD S 1;
		HBTD T 1;
		HBTD U 1;
		HBTD V 1 A_SetTranslucent(0.66, 0);
		HBTD W 1;
		HBTD X 1;
		HBTD Y 1 A_SetTranslucent(0.33, 0);
		HBTD Z 1;
		HBTD [ 1 A_SetTranslucent(0.0, 0);
		HBTD \ 1;
		Stop;
	}

	/*override void Die (Actor source, Actor inflictor, int dmgflags, Name MeansOfDeath)
	{
		// The heresiarch just executes a script instead of a special upon death
		int script = special;
		special = 0;

		Super.Die (source, inflictor, dmgflags, MeansOfDeath);

		if (script != 0)
		{
			ACS_Execute(script, 0);
		}
	}
	
	//============================================================================
	//
	// A_StopBalls
	//
	// Instant stop when rotation gets to ball in special2
	//		self is sorcerer
	//
	//============================================================================

	void A_StopBalls()
	{
		int chance = random[Heresiarch]();
		args[3] = SORC_STOPPING;				// stopping mode
		args[1] = 0;							// Reset rotation counter

		if ((args[0] <= 0) && (chance < 200))
		{
			StopBall = "SorcBall2";	// Blue
		}
		else if((health < (SpawnHealth() >> 1)) && (chance < 200))
		{
			StopBall = "SorcBall3";	// Green
		}
		else
		{
			StopBall = "SorcBall1";	// Yellow
		}
	}

	//============================================================================
	//
	// A_SorcSpinBalls
	//
	// Spawn spinning balls above head - actor is sorcerer
	//============================================================================

	void A_SorcSpinBalls()
	{
		A_SlowBalls();
		args[0] = 0;								// Currently no defense
		args[3] = SORC_NORMAL;
		args[4] = SORCBALL_INITIAL_SPEED;		// Initial orbit speed
		BallAngle = 1.;

		Vector3 ballpos = (pos.xy, -Floorclip + Height);
		
		Actor mo = Spawn("SorcBall1", pos, NO_REPLACE);
		if (mo)
		{
			mo.target = self;
			mo.special2 = SORCFX4_RAPIDFIRE_TIME;
		}
		mo = Spawn("SorcBall2", pos, NO_REPLACE);
		if (mo) mo.target = self;
		mo = Spawn("SorcBall3", pos, NO_REPLACE);
		if (mo) mo.target = self;
	}


	//============================================================================
	//
	// A_SpeedBalls
	//
	// Set balls to speed mode - self is sorcerer
	//
	//============================================================================

	void A_SpeedBalls()
	{
		args[3] = SORC_ACCELERATE;				// speed mode
		args[2] = SORCBALL_TERMINAL_SPEED;		// target speed
	}


	//============================================================================
	//
	// A_SlowBalls
	//
	// Set balls to slow mode - actor is sorcerer
	//
	//============================================================================

	void A_SlowBalls()
	{
		args[3] = SORC_DECELERATE;				// slow mode
		args[2] = SORCBALL_INITIAL_SPEED;		// target speed
	}

	//============================================================================
	//
	// A_SorcBossAttack
	//
	// Resume ball spinning
	//
	//============================================================================

	void A_SorcBossAttack()
	{
		args[3] = SORC_ACCELERATE;
		args[2] = SORCBALL_INITIAL_SPEED;
	}

	//============================================================================
	//
	// A_SpawnFizzle
	//
	// spell cast magic fizzle
	//
	//============================================================================

	void A_SpawnFizzle()
	{
		Vector3 pos = Vec3Angle(5., Angle, -Floorclip + Height / 2. );
		for (int ix=0; ix<5; ix++)
		{
			Actor mo = Spawn("SorcSpark1", pos, ALLOW_REPLACE);
			if (mo)
			{
				double rangle = Angle + random[CHeresiarch](0, 4) * (4096 / 360.);
				mo.Vel.X = random[CHeresiarch](0, int(speed) - 1) * cos(rangle);
				mo.Vel.Y = random[CHeresiarch](0, int(speed) - 1) * sin(rangle);
				mo.Vel.Z = 2;
			}
		}
	}*/

	
}
