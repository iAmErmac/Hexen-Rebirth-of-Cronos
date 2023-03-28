class ModelBlood : Actor replaces Blood
{
	Default
	{
 Health 1;
 +NOGRAVITY;
 +NOCLIP;
 +CLIENTSIDEONLY;
 +NONETID;
 }
 States
 {
  Spawn:
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood1",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood2",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood3",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood4",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood5",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood6",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood7",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	Stop;
  Spray:
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood1",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood2",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood3",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood4",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood5",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood6",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood7",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	Stop;
 }
}

class ModelBloodSplatter : Actor replaces BloodSplatter
{
Default
{
 Health 1;
 +NOGRAVITY;
 +NOCLIP;
 +CLIENTSIDEONLY;
 +NONETID;
 }
 states
 {
  Spawn:
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood1",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood2",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood3",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood4",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood5",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood6",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	NADA A 0 A_SpawnItemEx("ModelFlyingBlood7",0,0,0,random(3,4),0,random(2,4),random(0,360),0,192);
	Stop;
 }
}

class ModelFlyingBlood1 : Actor
{
	Default
	{
    Radius 3;
    Height 6;
	Mass 1;
	RenderStyle "Shaded";
	StencilColor "40 00 00";
	Scale 0.4;
	+MISSILE;
    +NOTELEPORT;
	+CLIENTSIDEONLY;
	+THRUACTORS;
	+NONETID;
	}
    States
    {
	Spawn:
		NADA A 1;
	    NADA B 1;
		NADA C 1;
		NADA D 1;
		NADA E 1;
		NADA F 1;
		NADA G 1;
		NADA H 1;
		NADA I 1;
		NADA J 1;
		Goto FadeOut;
	FadeOut:
		NADA J 1 A_FadeOut(0.025);
		Loop;
    Death:
		NADA J 1 A_SpawnItem("FloorBlood",0,0,0);
        Stop;
    }
}

class ModelFlyingBlood2 : ModelFlyingBlood1
{
	Default
	{
	Scale 0.5;
	}
}

class ModelFlyingBlood3 : ModelFlyingBlood1
{
Default
{
	Scale 1.0;
	}
}

class ModelFlyingBlood4 : ModelFlyingBlood1
{
Default
{
	Scale 0.6;
	}
}

class ModelFlyingBlood5 : ModelFlyingBlood1
{
Default
{
	Scale 0.7;
	}
}

class ModelFlyingBlood6 : ModelFlyingBlood1
{
Default
{
	Scale 1.3;
	}
}

class ModelFlyingBlood7 : ModelFlyingBlood1
{
Default
{
	Scale 0.9;
	}
}

class FloorBlood : Actor
{
Default
{
	Radius 1;
	Height 2;
	Scale 4.0;
	+NOTELEPORT;
	+CLIENTSIDEONLY;
	+DONTSPLASH;
	+MOVEWITHSECTOR;
	+FLOORCLIP;
	+NONETID;
	RenderStyle "Translucent";
	}
	States
	{
	Spawn:
		NADA A 0 NoDelay A_SetScale(frandom(3.0, 5.0));
		NADA A 0 A_Jump(96,"Spawn2");
		NADA A 35;
		Goto FadeOut;
	FadeOut:
		NADA A 1 A_FadeOut(0.04);
		Loop;
	Spawn2:
		NADA A 0 A_SpawnItem("FloorBloodStencil",0,0,0);
		Stop;
	}
}

class FloorBloodStencil : FloorBlood
{
Default
{
	RenderStyle "Shaded";
	StencilColor "40 00 00";
	}
	States
	{
	Spawn:
		BPLD A 0 NoDelay A_SetScale(frandom(3.75, 5.0));
		BPLD A 0 A_Jump(192,"Spawn2","Spawn3","Spawn4","Spawn5","Spawn6","Spawn7");
		BPDL A 35;
		Goto FadeOutA;
	FadeOutA:
		BPDL A 1 A_FadeOut(0.04);
		Loop;
	Spawn2:
		BPDL B 35;
		Goto FadeOutB;
	FadeOutB:
		BPDL B 1 A_FadeOut(0.04);
		Loop;
	Spawn3:
		BPDL C 35;
		Goto FadeOutC;
	FadeOutC:
		BPDL C 1 A_FadeOut(0.04);
		Loop;
	Spawn4:
		BPDL D 35;
		Goto FadeOutD;
	FadeOutD:
		BPDL D 1 A_FadeOut(0.04);
		Loop;
	Spawn5:
		BPDL E 35;
		Goto FadeOutE;
	FadeOutE:
		BPDL E 1 A_FadeOut(0.04);
		Loop;
	Spawn6:
		BPDL F 35;
		Goto FadeOutF;
	FadeOutF:
		BPDL F 1 A_FadeOut(0.04);
		Loop;
	Spawn7:
		BPDL G 35;
		Goto FadeOutG;
	FadeOutG:
		BPDL G 1 A_FadeOut(0.04);
		Loop;
	}
}

class CeilBlood : FloorBlood
{
Default
{
	+NOGRAVITY
	+CEILINGHUGGER
	}
	States
	{
	Spawn:
		BPLD A 0 NoDelay A_SetScale(frandom(3.75, 5.0));
		Goto Idle;
	Idle:
		BPLD A 0 A_Jump(160,"Spawn2");
		BPDL AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOut;
	FadeOut:
		BPDL A 1 A_FadeOut(0.04);
		Loop;
	Spawn2:
		NADA A 1 A_SpawnItem("CeilBloodStencil",0,0,0);
		Stop;
	Death:
		NADA A 1;
		Stop;
	}
}

class CeilBloodStencil : CeilBlood
{
Default
{
	RenderStyle "Shaded";
	StencilColor "40 00 00";
	}
	States
	{
	Spawn:
		BPLD A 0 NoDelay A_SetScale(frandom(3.75, 5.0));
		Goto Idle;
	Idle:
		BPLD A 0 A_Jump(192,"Spawn2","Spawn3","Spawn4","Spawn5","Spawn6","Spawn7");
		BPDL AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOutA;
	FadeOutA:
		BPDL A 1 A_FadeOut(0.04);
		Loop;
	Spawn2:
		BPDL BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOutB;
	FadeOutB:
		BPDL B 1 A_FadeOut(0.04);
		Loop;
	Spawn3:
		BPDL CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOutC;
	FadeOutC:
		BPDL C 1 A_FadeOut(0.04);
		Stop;
	Spawn4:
		BPDL DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOutD;
	FadeOutD:
		BPDL D 1 A_FadeOut(0.04);
		Loop;
	Spawn5:
		BPDL EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOutE;
	FadeOutE:
		BPDL E 1 A_FadeOut(0.04);
		Loop;
	Spawn6:
		BPDL FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOutF;
	FadeOutF:
		BPDL F 1 A_FadeOut(0.04);
		Loop;
	Spawn7:
		BPDL GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG 1 ThrustThingZ(0,1024,0,0);
		Goto FadeOutG;
	FadeOutG:
		BPDL G 1 A_FadeOut(0.04);
		Loop;
	Death:
		NADA A 0;
		Stop;
	}
}

class XDeathDecaler : Actor
{
Default
{
    Radius 4;
    Height 8;
	Speed 24;
	Mass 1;
	RenderStyle "Shaded";
	StencilColor "40 00 00";
	Scale 2.0;
	+MISSILE;
    +NOTELEPORT;
	+THRUACTORS;
	+CLIENTSIDEONLY;
	+NONETID;
	Decal "BloodSplater";
	}
    States
    {
    Spawn:
		TNT1 A 0 NoDelay A_QueueCorpse;
		Goto Idle;
	Idle:
        NADA B 2 A_Countdown;
        Loop;
    Death:
		NADA B 1;
        Stop;
    }
}

class FBlooder : Actor
{
Default
{
	Radius 2;
	Height 4;
	RenderStyle "None";
	+MISSILE;
	+CLIENTSIDEONLY;
	+NOTELEPORT;
	+THRUACTORS;
	+NONETID;
	Decal "BloodSplater";
	}
	states
	{
	Spawn:
		TNT1 A 0 NoDelay A_QueueCorpse;
		Goto Idle;
	Idle:
		TNT1 A 0 A_JumpIf(waterlevel > 1, "Splash");
		TNT1 A 70;
		Stop;
	Splash:
		TNT1 A 1;
		Stop;
	Death:
		TNT1 A 1 A_SpawnItemEx("FloorBlood",0,0,0);
		Stop;
	}
}

class CBlooder : FBlooder
{
Default
{
	+NOGRAVITY;
	Decal "BloodSplater";
	}
	states
	{
	Idle:
		TNT1 A 0 A_JumpIf(waterlevel > 1, "Splash");
		TNT1 A 35;
		Stop;
	Death:
		TNT1 A 1 A_SpawnItemEx("CeilBlood",0,0,0);
		Stop;
	}
}

class GibletsSpawnerGeneric : Actor
{
Default
{
    Radius 8;
    Height 16;
	+CLIENTSIDEONLY;
	+NOINTERACTION;
	+NONETID;
	}
    States
    {
    Spawn:
		TNT1 A 0 NoDelay A_CheckSightOrRange(1600,"Death");
		TNT1 AAAAAAAAAA 0 A_SpawnItemEx("FBlooder",0,0,2,frandom(1.0,8.0),0,frandom(1.0,8.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
		TNT1 AAAAAAAAAA 0 A_SpawnItemEx("CBlooder",0,0,2,frandom(1.0,8.0),0,16,frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
		TNT1 AAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile("XDeathDecaler", 0, 0, frandom(0.0, 359.0), 2, frandom(2.0, 160.0));
        Goto Death;
    Death:
        TNT1 A 0 A_SpawnItemEx("GibPiece1",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 0 A_SpawnItemEx("GibPiece2",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 0 A_SpawnItemEx("GibPiece3",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 0 A_SpawnItemEx("GibPiece4",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 0 A_SpawnItemEx("GibPiece5",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 0 A_SpawnItemEx("GibPiece6",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 0 A_SpawnItemEx("GibPiece7",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 0 A_SpawnItemEx("GibPiece8",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        TNT1 A 1 A_SpawnItemEx("GibPiece9",0,0,2,frandom(1.0,16.0),0,frandom(4.0,16.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION, 128);
        Stop;
    }
}

class GibPiece1 : Actor
{
Default
{
    Radius 4;
    Height 8;
	Mass 10;
	BounceType "Doom";
	BounceCount 10;
	+MISSILE;
    +NOTELEPORT;
    +DONTSPLASH;
	+MOVEWITHSECTOR;
	+THRUACTORS;
	+CLIENTSIDEONLY;
	+NONETID;
	Decal "BloodSplater";
	}
    States
    {
    Spawn:
		NADA A 0 NoDelay A_QueueCorpse;
		NADA A 0 A_SetScale(FRandom(1.0,1.5));
        NADA AAAAAA 2 A_SpawnItem("GibTrail",0,0,0);
		Goto LoopNogore;
    LoopNogore:
		NADA A 1 A_JumpIf(waterlevel > 1, "Deathwait");
		NADA A 0 A_Jump(128, "Deathwait");
		Loop;
    Death:
		NADA A 0 A_JumpIf(waterlevel > 1, "Deathwait");
		NADA A 0 A_SpawnItem("FloorBlood",0,0,0);
		Goto Deathwait;
	Deathwait:
		Goto FadeOut;
	FadeOut:
		NADA A 1 A_FadeOut(0.04);
        Loop;
    }
}

class GibPiece2 : GibPiece1
{
}

class GibPiece3 : GibPiece1
{
}

class GibPiece4 : GibPiece1
{
}

class GibPiece5 : GibPiece1
{
}

class GibPiece6 : GibPiece1
{
}

class GibPiece7 : GibPiece1
{
}

class GibPiece8 : GibPiece1
{
}

class GibPiece9 : GibPiece1
{
}

class GibletsSpawnerDirectional : GibletsSpawnerGeneric
{
Default
{
}
    States
    {
    Spawn:
		TNT1 A 0 NoDelay A_CheckSightOrRange(1600,"Death");
		TNT1 A 1;
		TNT1 AAAAAAAAAA 0 A_SpawnItemEx("FBlooder",0,0,2,frandom(1.0,8.0),0,frandom(1.0,8.0),frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
		TNT1 AAAAAAAAAA 0 A_SpawnItemEx("CBlooder",0,0,2,frandom(1.0,8.0),0,16,frandom(0.0,359.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
		TNT1 AAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile("XDeathDecaler", 0, 0, frandom(130.0, 230.0), 2, frandom(-30.0, 60.0));
        Goto Death;
    Death:
        TNT1 A 0 A_SpawnItemEx("GibPiece1",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 0 A_SpawnItemEx("GibPiece2",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 0 A_SpawnItemEx("GibPiece3",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 0 A_SpawnItemEx("GibPiece4",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 0 A_SpawnItemEx("GibPiece5",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 0 A_SpawnItemEx("GibPiece6",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 0 A_SpawnItemEx("GibPiece7",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 0 A_SpawnItemEx("GibPiece8",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        TNT1 A 1 A_SpawnItemEx("GibPiece9",0,0,2,frandom(8.0,16.0),0,frandom(8.0,16.0),frandom(135.0,225.0),SXF_CLIENTSIDE|SXF_NOCHECKPOSITION);
        Stop;
    }
}

class GibTrail : Actor
{
Default
{
    Radius 1;
    Height 1;
	Alpha 0.5;
	RenderStyle "Translucent";
	Scale 0.4;
	+FORCEXYBILLBOARD;
	+CLIENTSIDEONLY;
	+NOINTERACTION;
	+NONETID;
	}
    States
    {
    Spawn:
	    NADA A 0 NoDelay A_JumpIf(Waterlevel>1,"Underwater");
		NADA A 0 ThrustThingZ(0,-1,0,0);
		NADA A 0 A_Jump(128,"Idle2");
		Goto Idle;
	Idle:
	    BLOD A 0 A_SetScale(Scale.X+0.005);
	    BLOD A 1 A_FadeOut(0.01);
		Loop;
	Idle2:
	    BLOD B 0 A_SetScale(Scale.X+0.005);
	    BLOD B 1 A_FadeOut(0.01);
		Loop;
	Underwater:
	    NADA A 0 A_Jump(128,"UnderwaterIdle2");
		Goto UnderwaterIdle2;
	UnderwaterIdle:
	    BLOD A 0 A_SetScale(Scale.X+0.006);
	    BLOD A 1 A_FadeOut(0.006);
		Loop;
	UnderwaterIdle2:
	    BLOD B 0 A_SetScale(Scale.X+0.006);
	    BLOD B 1 A_FadeOut(0.006);
		Loop;
    }
}

class ZCorpseBloodDrip : Actor replaces CorpseBloodDrip
{
	Default
	{
		Radius 1;
		Height 4;
		Gravity 0.125;
		+MISSILE
		+NOICEDEATH
		RenderStyle "Translucent";
		DeathSound "Drip";
	}
	States
	{
	Spawn:
		BDRP A -1;
		Stop;
	Death:
		BDSH A 0;
		BDSH A 0 A_SpawnItem("FloorBlood",0,0,0);
		//BDSH AB 3;
		//BDSH CD 2;
		Stop;
	}
}


class ZBloodPool : FloorBlood replaces BloodPool
{
Default
{
	RenderStyle "Shaded";
	StencilColor "40 00 00";
	}
	States
	{
	Spawn:
		BPLD A 0 NoDelay A_SetScale(frandom(3.75, 5.0));
		BPLD A 0 A_Jump(192,"Spawn2","Spawn3","Spawn4","Spawn5","Spawn6","Spawn7");
		BPDL A 35;
		Goto FadeOutA;
	FadeOutA:
		BPDL A -1;
		Loop;
	Spawn2:
		BPDL B 1;
		Goto FadeOutB;
	FadeOutB:
		BPDL B -1;
		Stop;
	Spawn3:
		BPDL C 1;
		Goto FadeOutC;
	FadeOutC:
		BPDL C -1;
		Stop;
	Spawn4:
		BPDL D 1;
		Goto FadeOutD;
	FadeOutD:
		BPDL D -1;
		Stop;
	Spawn5:
		BPDL E 1;
		Goto FadeOutE;
	FadeOutE:
		BPDL E -1;
		Stop;
	Spawn6:
		BPDL F 1;
		Goto FadeOutF;
	FadeOutF:
		BPDL F -1;
		Stop;
	Spawn7:
		BPDL G 1;
		Goto FadeOutG;
	FadeOutG:
		BPDL G -1;
		Stop;
	}
}