// Ice Guy ------------------------------------------------------------------

class CIceGuy : Actor replaces IceGuy
{
	Default
	{
		Health 120;
		PainChance 144;
		Speed 5;
		Radius 22;
		Height 75;
		Mass 150;
		DamageType "Ice";
		Monster;
		+NOBLOOD
		+TELESTOMP
		+NOICEDEATH
		+INTERPOLATEANGLES
		SeeSound "IceGuySight";
		AttackSound "IceGuyAttack";
		ActiveSound "IceGuyActive";
		Obituary "$OB_ICEGUY";
		Tag "$FN_ICEGUY";
	}


	States
	{
	Spawn:
		IATB N 3 A_IceGuyLook;
        IATB O 3 A_IceGuyLook;
        IATB P 3 A_IceGuyLook;
        IATB Q 3 A_IceGuyLook;
        IATB R 3 A_IceGuyLook;
        IATB S 3 A_IceGuyLook;
        IATB T 3 A_IceGuyLook;
        IATB U 3 A_IceGuyLook;
        IATB V 3 A_IceGuyLook;
        IATB W 3 A_IceGuyLook;
        IATB X 3 A_IceGuyLook;
        IATB Y 3 A_IceGuyLook;
        IATB Z 3 A_IceGuyLook;
        IATB [ 3 A_IceGuyLook;
        IATB \ 3 A_IceGuyLook;
		Loop;
	See:
		IATC V 1 A_Chase;
        IATC W 1 A_IceGuyChase;
        IATC X 1 A_Chase;
        IATC Y 1 A_Chase;
        IATC Z 1 A_Chase;
        IATC [ 1 A_Chase;
        IATC \ 1 A_Chase;
        IATC ] 1 A_Chase;
        IATD A 1 A_Chase;
        IATD B 1 A_Chase;
        IATD C 1 A_Chase;
        IATD D 1 A_Chase;
        IATD E 1 A_Chase;
        IATD F 1 A_Chase;
        IATD G 1 A_Chase;
        IATD H 1 A_Chase;
        IATD I 1 A_Chase;
        IATD J 1 A_Chase;
        IATD K 1 A_Chase;
        IATD L 1 A_Chase;
		Loop;
	Pain:
		IATB D 1;
        IATB E 1;
        IATB F 1;
        IATB G 1;
        IATB H 1;
        IATB I 1;
        IATB J 1;
        IATB K 1;
        IATB L 1;
        IATB M 1 A_Pain;
		Goto See;
	Missile:
		IATA A 1 A_FaceTarget;
        IATA B 1 A_FaceTarget;
        IATA C 1 A_FaceTarget;
        IATA D 1 A_FaceTarget;
        IATA E 1 A_FaceTarget;
        IATA F 1 A_FaceTarget;
        IATA G 1 A_FaceTarget;
        IATA H 1 A_FaceTarget;
        IATA I 1 A_FaceTarget;
        IATA J 1 A_FaceTarget;
        IATA K 1 A_FaceTarget;
        IATA L 1 A_FaceTarget;
        IATA M 1 A_FaceTarget;
        IATA N 1 A_FaceTarget;
        IATA O 1 A_FaceTarget;
        IATA P 1 A_FaceTarget;
        IATA Q 1 A_IceGuyAttack;
        IATA R 1 A_FaceTarget;
        IATA S 1 A_FaceTarget;
        IATA T 1 A_FaceTarget;
        IATA U 1 A_FaceTarget;
        IATA V 1 A_FaceTarget;
        IATA W 1 A_FaceTarget;
        IATA X 1 A_FaceTarget;
        IATA Y 1 A_FaceTarget;
        IATA Z 1 A_FaceTarget;
        IATA [ 1 A_FaceTarget;
        IATA \ 1 A_FaceTarget;
        IATA ] 1 A_FaceTarget;
        IATB A 1 A_FaceTarget;
        IATB B 1 A_FaceTarget;
        IATB C 1 A_FaceTarget;
		Goto See;
	Melee:
		IATB ] 1;
        IATC A 1;
        IATC B 1;
        IATC C 1;
        IATC D 1;
        IATC E 1;
        IATC F 1;
        IATC G 1;
        IATC H 1;
        IATC I 1;
        IATC J 1;
        IATC K 1;
        IATC L 1;
        IATC M 1;
        IATC N 1;
        IATC O 1;
        IATC P 1 A_CustomMeleeAttack(random[EttinAttack](1,8)*2);
        IATC Q 1;
        IATC R 1;
        IATC S 1;
        IATC T 1;
        IATC U 1;
		Goto See;
	Death:
		IATA A 1 A_IceGuyDie;
		Stop;
	Inactive:
		IATB N 1;
        IATB O 1;
        IATB P 1;
        IATB Q 1;
        IATB R 1;
        IATB S 1;
        IATB T 1;
        IATB U 1;
        IATB V 1;
        IATB W 1;
        IATB X 1;
        IATB Y 1;
        IATB Z 1;
        IATB [ 1;
        IATB \ 1;
		Goto See;
	}
	
	//============================================================================
	//
	// SpawnWisp
	//
	//============================================================================

	private void SpawnWisp()
	{
		static const class<Actor> WispTypes[] = { "IceGuyWisp1", "IceGuyWisp2" };

		double dist = (random[IceGuyLook]() - 128) * radius / 128.;
		double an = angle + 90;
		Actor mo = Spawn(WispTypes[random[IceGuyLook](0, 1)], Vec3Angle(dist, an, 60.), ALLOW_REPLACE);
		if (mo)
		{
			mo.Vel = Vel;
			mo.target = self;
		}
	}
	
	//============================================================================
	//
	// A_IceGuyLook
	//
	//============================================================================

	void A_IceGuyLook()
	{
		A_Look();
		if (random[IceGuyLook]() < 64) SpawnWisp();
	}

	//============================================================================
	//
	// A_IceGuyChase
	//
	//============================================================================

	void A_IceGuyChase()
	{
		A_Chase();
		if (random[IceGuyLook]() < 128) SpawnWisp();
	}

	//============================================================================
	//
	// A_IceGuyAttack
	//
	//============================================================================

	void A_IceGuyAttack()
	{
		if(!target) 
		{
			return;
		}
		SpawnMissileXYZ(Vec3Angle(radius / 2, angle + 90, 40.), target, "IceGuyFX");
		SpawnMissileXYZ(Vec3Angle(radius / 2, angle - 90, 40.), target, "IceGuyFX");
		A_StartSound (AttackSound, CHAN_WEAPON);
	}
}