//special class to check if faced to wall and then face away
class WallCheckActor : Actor
{
    override void PostBeginPlay()
    {
        Array<Double> wallDist;
        
        for(int i=0; i<36; i++)
            wallDist.Push(nearbyWallDist(i * 10)); //check for walls in every 10 degree angle
        
        double nearestWallDist = maxCheckDist;
        for(int i=0; i<wallDist.Size(); i++)
        {
            if(wallDist[i] && wallDist[i] < nearestWallDist)
                nearestWallDist = wallDist[i];
        }
        
        double angleTo = wallDist.Find(nearestWallDist);
        angleTo = angleTo * 10 + 180;
        A_SetAngle(angleTo); //face away from the nearest wall
    }
    
    double nearbyWallDist(double angle)
    {
        FLineTraceData lineData;
        bool hit = LineTrace(
           angle,
           maxCheckDist,
           0,
           offsetz: height/2,
           data: lineData
        );
        
        if(hit && lineData.HitType == TRACE_HitWall)
            return lineData.Distance;
        else
            return 0;
    }
	
	const maxCheckDist = 640;
}

class CZBarrel : Actor replaces ZBarrel
{
	Default
	{
		Radius 15;
		Height 32;
		+SOLID
	}
	States
	{
	Spawn:
		3DMD A -1;
		Stop;
	}
}

class CZBucket : Actor replaces ZBucket
{
	Default
	{
		Radius 8;
		Height 72;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		3DMD A -1;
		Stop;
	}
}

class CZBell : Actor replaces ZBell
{
	Default
	{
		Health 5;
		Radius 56;
		Height 120;
		Mass 0x7fffffff;
		+SOLID +SHOOTABLE +NOBLOOD +NOGRAVITY +SPAWNCEILING
		+NOICEDEATH
		DeathSound "BellRing";
	}

	States
	{
	Spawn:
		BELA A -1;
		Stop;
	Death:
		BELA A 3 A_BellReset1;
		BELA BCDE 3;
		BELA F 3 A_Scream;
		BELA GHIJKLMNO 3;
		BELA P 3 A_Scream;
		BELA QRSTUVWXY 3;
		BELA Z 3 A_Scream;
		BELA [\] 3;
		BELB ABCDEF 3;
		BELB G 3 A_Scream;
		BELB HIJKLMNOP 3;
		BELB Q 3 A_Scream;
		BELB RSTUVWXYZ 3;
		BELB [ 3 A_Scream;
		BELB \] 3;
		BELC ABCDEFGHIJKL 3;
		BELC M 3 A_BellReset2;
		Goto Spawn;
	}
	
	override void Activate (Actor activator)
	{
		if (health > 0)
		{
			DamageMobj (activator, activator, 10, 'Melee', DMG_THRUSTLESS); // 'ring' the bell
		}
	}

	//===========================================================================
	//
	// A_BellReset1
	//
	//===========================================================================

	void A_BellReset1()
	{
		bNoGravity = true;
		Height = Default.Height;
	}

	//===========================================================================
	//
	// A_BellReset2
	//
	//===========================================================================

	void A_BellReset2()
	{
		bShootable = true;
		bCorpse = false;
		bKilled = false;
		health = 5;
	}
}

class CBigTree1Leaves : Actor
{
	Default
	{
		Radius 15;
		Height 180;
		RenderStyle "Translucent";
		Alpha 1.0;
	}
	States
	{
	Spawn:
		TRLA A -1;
		Stop;
	}
}

class CBigTree1 : Actor replaces ZTreeLarge1
{
	Default
	{
		Radius 15;
		Height 180;
		+SOLID
	}
	States
	{
	Spawn:
		TREA A 1 NoDelay A_SetAngle(random(0, 360));
		TREA A 1 A_SpawnItemEx("CBigTree1Leaves",0,0,0);
		TREA A -1;
		Stop;
	}
}

class CBigTree2Leaves : Actor
{
	Default
	{
		Radius 15;
		Height 180;
		RenderStyle "Translucent";
		Alpha 1.0;
	}
	States
	{
	Spawn:
		TRLB A -1;
		Stop;
	}
}

class CBigTree2 : Actor replaces ZTreeLarge2
{
	Default
	{
		Radius 15;
		Height 180;
		+SOLID
	}
	States
	{
	Spawn:
		TREB A 1 NoDelay A_SetAngle(random(0, 360));
		TREB A 1 A_SpawnItemEx("CBigTree2Leaves",0,0,0);
		TREB A -1;
		Stop;
	}
}

class CGargoyleStone : WallCheckActor replaces ZStatueGargoyleGreenTall
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleIce : WallCheckActor replaces ZStatueGargoyleBlueTall
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleStoneSmall : WallCheckActor replaces ZStatueGargoyleGreenShort
{
	Default
	{
		Radius 14;
		Height 62;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleIceSmall : WallCheckActor replaces ZStatueGargoyleBlueShort
{
	Default
	{
		Radius 14;
		Height 62;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleWood : WallCheckActor replaces ZStatueGargoyleStripeTall
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleWoodSmall : WallCheckActor
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleLava : WallCheckActor replaces ZStatueGargoyleDarkRedTall
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleJasper : WallCheckActor replaces ZStatueGargoyleRedTall
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleBronze : WallCheckActor replaces ZStatueGargoyleTanTall
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleMetal : WallCheckActor replaces ZStatueGargoyleRustTall
{
	Default
	{
		Radius 14;
		Height 108;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleLavaSmall : WallCheckActor replaces ZStatueGargoyleDarkRedShort
{
	Default
	{
		Radius 14;
		Height 62;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleJasperSmall : WallCheckActor replaces ZStatueGargoyleRedShort
{
	Default
	{
		Radius 14;
		Height 62;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleBronzeSmall : WallCheckActor replaces ZStatueGargoyleTanShort
{
	Default
	{
		Radius 14;
		Height 62;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CGargoyleMetalSmall : WallCheckActor replaces ZStatueGargoyleRustShort
{
	Default
	{
		Radius 14;
		Height 62;
		+SOLID
	}
	States
	{
	Spawn:
		GRG1 A -1;
		Stop;
	}
}

class CZSwampVine : Actor replaces ZSwampVine
{
	Default
	{
		Radius 20;
		Height 52;
		+SOLID
	}
	States
	{
	Spawn:
		SWAM A 1 NoDelay A_SetAngle(random(0, 360));
		SWAM A 1 A_SpawnItemEx("CZSwampVines",0,0,0);
		SWAM A -1;
		Stop;
	}
}

class CZSwampVines : Actor
{
	Default
	{
		Radius 20;
		Height 52;
		+SOLID
		Renderstyle "Translucent";
	}
	States
	{
	Spawn:
		SWAM A -1;
		Stop;
	}
}

class CZCorpseLynched : Actor replaces ZCorpseLynched
{
	Default
	{
		Radius 11;
		Height 95;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		CORP A -1;
		Stop;
	}
}

class CZCorpseHanging : Actor replaces ZCorpseHanging
{
	Default
	{
		Radius 6;
		Height 75;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		CORP A -1;
		Stop;
	}
}

class CZCorpseKabob : Actor replaces ZCorpseKabob
{
	Default
	{
		Radius 10;
		Height 92;
		+SOLID
	}
	States
	{
	Spawn:
		CORP A -1;
		Stop;
	}
}

class CZCorpseSleeping : Actor replaces ZCorpseSleeping
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		CORP A -1;
		Stop;
	}
}

class CZDeadTree : Actor replaces ZTreeDead
{
	Default
	{
		Radius 10;
		Height 96;
		+SOLID
	}
	States
	{
	Spawn:
		TNT1 A 1 Nodelay A_SetAngle(random(0, 360));
		DTRE A -1;
		Stop;
	}
}

class WoodCup : Actor replaces TableShit1
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		DISH A -1;
		Stop;
	}
}

class BeerCup : Actor replaces TableShit2
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		DISH A 1;
		DISH A 1 A_SpawnItemEx("BeerGlass",0,0,0);
		DISH A -1;
		Stop;
	}
}

class BeerGlass : Actor
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
		Renderstyle "Translucent";
	}
	States
	{
	Spawn:
		DISH A -1;
		Stop;
	}
}

class SpilledCup : Actor replaces TableShit6
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		DISH A -1;
		Stop;
	}
}

class Cup2 : Actor replaces TableShit7
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		DISH A -1;
		Stop;
	}
}

class Cup1 : Actor replaces TableShit8
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		DISH A -1;
		Stop;
	}
}

class Cup3 : Actor replaces TableShit9
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		DISH A -1;
		Stop;
	}
}

class Knife : Actor replaces TableShit10
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		DISH A -1;
		Stop;
	}
}

class CandleWeb : Actor
{
	Default
	{
		Radius 20;
		Height 16;
		Renderstyle "Add";
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		CNDW A -1;
		Stop;
	}
}

class CTableShit3 : Actor replaces TableShit3
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		CNDW A 1;
		CNDW A 1 A_SpawnItemEx("CandleWeb",0,0,0);
		CNDW A -1;
		Stop;
	}
}

class CTableShit4 : Actor replaces TableShit4
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		CND1 A -1;
		Stop;
	}
}

class CTableShit5 : Actor replaces TableShit5
{
	Default
	{
		Radius 20;
		Height 16;
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		CND2 A -1;
		Stop;
	}
}

class FaceTorchFire : Actor
{
	Default
	{
	Height 1;
	Radius 1;
	RenderStyle "Add";
	Alpha 1.0;
	+BRIGHT;
	}
	States
	{
	Spawn:
		TFLA ABCDEFGH random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Loop;
	}
}


class FaceTorch : Actor replaces FireThing
{
	Default
	{
		Radius 5;
		Height 10;
		+SOLID
	}
	States
	{
	Spawn:
		FCTC A 1;
		FCTC A 1 A_SpawnItemEx("FaceTorchFire",0,0,0);
		FCTC A -1;
		Stop;
	}
}

class Flag : Actor replaces ZBannerTattered
{
	Default
	{
		Radius 8;
		Height 120;
		+SOLID
	}
	States
	{
	Spawn:
		FLAG A -1;
		Stop;
	}
}

class CZRock1 : Actor replaces ZRock1
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		ROCK A -1;
		Stop;
	}
}

class CZRock2 : Actor replaces ZRock2
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		ROCK A -1;
		Stop;
	}
}

class CZRock3 : Actor replaces ZRock3
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		ROCK A -1;
		Stop;
	}
}

class CZRock4 : Actor replaces ZRock4
{
	Default
	{
		Radius 20;
		Height 16;
		+SOLID
	}
	States
	{
	Spawn:
		ROCK A -1;
		Stop;
	}
}

class CZChainBit32 : Actor replaces ZChainBit32
{
	Default
	{
		Radius 4;
		Height 32;
		+SPAWNCEILING
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		HOOK A -1;
		Stop;
	}
}

class CZChainBit64 : Actor replaces ZChainBit64
{
	Default
	{
		Radius 4;
		Height 64;
		+SPAWNCEILING
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		HOOK A -1;
		Stop;
	}
}

class CZChainEndHeart : Actor replaces ZChainEndHeart
{
	Default
	{
		Radius 4;
		Height 32;
		+SPAWNCEILING
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		HOOK A -1;
		Stop;
	}
}

class CZChainEndHook1 : Actor replaces ZChainEndHook1
{
	Default
	{
		Radius 4;
		Height 32;
		+SPAWNCEILING
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		HOOK A -1;
		Stop;
	}
}

class CZChainEndHook2 : Actor replaces ZChainEndHook2
{
	Default
	{
		Radius 4;
		Height 32;
		+SPAWNCEILING
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		HOOK A -1;
		Stop;
	}
}

class CZChainEndSpike : Actor replaces ZChainEndSpike
{
	Default
	{
		Radius 4;
		Height 32;
		+SPAWNCEILING
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		HOOK A -1;
		Stop;
	}
}

class CZChainEndSkull : Actor replaces ZChainEndSkull
{
	Default
	{
		Radius 4;
		Height 32;
		+SPAWNCEILING
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		HOOK A -1;
		Stop;
	}
}

class CZIronMaiden : Actor replaces ZIronMaiden
{
	Default
	{
		Radius 12;
		Height 60;
		+SOLID
	}
	States
	{
	Spawn:
		IRMD A -1;
		Stop;
	}
}

class CZStalagmitePillar : Actor replaces ZStalagmitePillar
{
	Default
	{
		Radius 8;
		Height 138;
		+SOLID
	}
	States
	{
	Spawn:
		STLC A -1;
		Stop;
	}
}

class CZStalagmiteLarge : Actor replaces ZStalagmiteLarge
{
	Default
	{
		Radius 8;
		Height 48;
		+SOLID
	}
	States
	{
	Spawn:
		STLC A -1;
		Stop;
	}
}

class CZStalagmiteMedium : Actor replaces ZStalagmiteMedium
{
	Default
	{
		Radius 6;
		Height 40;
		+SOLID
	}
	States
	{
	Spawn:
		STLC A -1;
		Stop;
	}
}

class CZStalagmiteSmall : Actor replaces ZStalagmiteSmall
{
	Default
	{
		Radius 8;
		Height 36;
		+SOLID
	}
	States
	{
	Spawn:
		STLC A -1;
		Stop;
	}
}

class CZStalactiteLarge : Actor replaces ZStalactiteLarge
{
	Default
	{
		Radius 8;
		Height 66;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		STLC A -1;
		Stop;
	}
}

class CZStalactiteMedium : Actor replaces ZStalactiteMedium
{
	Default
	{
		Radius 6;
		Height 50;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		STLC A -1;
		Stop;
	}
}

class CZStalactiteSmall : Actor replaces ZStalactiteSmall
{
	Default
	{
		Radius 8;
		Height 40;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		STLC A -1;
		Stop;
	}
}

class CZLog : Actor replaces ZLog
{
	Default
	{
		Radius 20;
		Height 25;
		+SOLID
	}
	States
	{
	Spawn:
		LOGS A -1;
		Stop;
	}
}

class CZShroomLarge1 : Actor replaces ZShroomLarge1
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZShroomLarge2 : Actor replaces ZShroomLarge2
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZShroomLarge3 : Actor replaces ZShroomLarge3
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZShroomSmall1 : Actor replaces ZShroomSmall1
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZShroomSmall2 : Actor replaces ZShroomSmall2
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZShroomSmall3 : Actor replaces ZShroomSmall3
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZShroomSmall4 : Actor replaces ZShroomSmall4
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZShroomSmall5 : Actor replaces ZShroomSmall5
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		MUSH A 1 NoDelay A_SetAngle(random(0, 360));
		MUSH A -1;
		Stop;
	}
}

class CZVasePillar : Actor replaces ZVasePillar
{
	Default
	{
		Radius 12;
		Height 54;
		+SOLID
	}
	States
	{
	Spawn:
		PVAS A -1;
		Stop;
	}
}

class CZStalactiteIceLarge : Actor replaces ZStalactiteIceLarge
{
	Default
	{
		Radius 8;
		Height 66;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class CZStalactiteIceMedium : Actor replaces ZStalactiteIceMedium
{
	Default
	{
		Radius 5;
		Height 50;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class CZStalactiteIceSmall : Actor replaces ZStalactiteIceSmall
{
	Default
	{
		Radius 4;
		Height 32;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class CZStalactiteIceTiny : Actor replaces ZStalactiteIceTiny
{
	Default
	{
		Radius 4;
		Height 8;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class CZStalagmiteIceLarge : Actor replaces ZStalagmiteIceLarge
{
	Default
	{
		Radius 8;
		Height 66;
		+SOLID
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class CZStalagmiteIceMedium : Actor replaces ZStalagmiteIceMedium
{
	Default
	{
		Radius 5;
		Height 50;
		+SOLID
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class CZStalagmiteIceSmall : Actor replaces ZStalagmiteIceSmall
{
	Default
	{
		Radius 4;
		Height 32;
		+SOLID
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class CZStalagmiteIceTiny : Actor replaces ZStalagmiteIceTiny
{
	Default
	{
		Radius 4;
		Height 8;
		+SOLID
	}
	States
	{
	Spawn:
		SICE A -1;
		Stop;
	}
}

class ScrewTorchFire : Actor
{
	Default
	{
		Radius 6;
		Height 35;
		Renderstyle "Add";
		+SOLID
	}
	States
	{
	Spawn:
		TFLA ABCDEFGH random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Loop;
	}
}

class CBrassTorch : Actor replaces BrassTorch
{
	Default
	{
		Radius 6;
		Height 35;
		+SOLID
	}
	States
	{
	Spawn:
		SCRE A 1;
		SCRE A 1 A_SpawnItemEx("ScrewTorchFire",0,0,0);
		SCRE A -1;
		Stop;
	}
}

class CZRockBrown1 : Actor replaces ZRockBrown1
{
	Default
	{
		Radius 17;
		Height 72;
		+SOLID
	}
	States
	{
	Spawn:
		STNS A -1;
		Stop;
	}
}

class CZRockBrown2 : Actor replaces ZRockBrown2
{
	Default
	{
		Radius 15;
		Height 50;
		+SOLID
	}
	States
	{
	Spawn:
		STNS A -1;
		Stop;
	}
}

class CZRockBlack : Actor replaces ZRockBlack
{
	Default
	{
		Radius 20;
		Height 40;
		+SOLID
	}
	States
	{
	Spawn:
		STNS A -1;
		Stop;
	}
}

class CZRubble1 : Actor replaces ZRubble1
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		STNS A -1;
		Stop;
	}
}

class CZRubble2 : Actor replaces ZRubble2
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		STNS A -1;
		Stop;
	}
}

class CZRubble3 : Actor replaces ZRubble3
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		STNS A -1;
		Stop;
	}
}

class CZStumpBurned : Actor replaces ZStumpBurned
{
	Default
	{
		Radius 12;
		Height 20;
		+SOLID
	}
	States
	{
	Spawn:
		STMP A 1 NoDelay A_SetAngle(random(0, 360));
		STMP A -1;
		Stop;
	}
}

class CZStumpBare : Actor replaces ZStumpBare
{
	Default
	{
		Radius 12;
		Height 20;
		+SOLID
	}
	States
	{
	Spawn:
		STMP A 1 NoDelay A_SetAngle(random(0, 360));
		STMP A -1;
		Stop;
	}
}

class CZStumpSwamp1 : Actor replaces ZStumpSwamp1
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		STMP A 1 NoDelay A_SetAngle(random(0, 360));
		STMP A -1;
		Stop;
	}
}

class CZStumpSwamp2 : Actor replaces ZStumpSwamp2
{
	Default
	{
		Radius 20;
		Height 16;
	}
	States
	{
	Spawn:
		STMP A 1 NoDelay A_SetAngle(random(0, 360));
		STMP A -1;
		Stop;
	}
}

class CZTreeSwamp150 : Actor replaces ZTreeSwamp150
{
	Default
	{
		Radius 10;
		Height 150;
		+SOLID
	}
	States
	{
	Spawn:
		STMP A 1 NoDelay A_SetAngle(random(0, 360));
		SWMT A -1;
		Stop;
	}
}

class CZTreeSwamp120 : Actor replaces ZTreeSwamp120
{
	Default
	{
		Radius 10;
		Height 120;
		+SOLID
	}
	States
	{
	Spawn:
		STMP A 1 NoDelay A_SetAngle(random(0, 360));
		SWMT A -1;
		Stop;
	}
}

class CZTreeGnarled1 : Actor replaces ZTreeGnarled1
{
	Default
	{
		Radius 22;
		Height 100;
		+SOLID
	}
	States
	{
	Spawn:
		GNRT A 1 NoDelay A_SetAngle(random(0, 360));
		GNRT A -1;
		Stop;
	}
}

class CZTreeGnarled2 : Actor replaces ZTreeGnarled2
{
	Default
	{
		Radius 22;
		Height 100;
		+SOLID
	}
	States
	{
	Spawn:
		GNRT A 1 NoDelay A_SetAngle(random(0, 360));
		GNRT A -1;
		Stop;
	}
}

class CZMossCeiling1 : Actor replaces ZMossCeiling1
{
	Default
	{
		Radius 20;
		Height 20;
		+SPAWNCEILING
		+NOGRAVITY
		Renderstyle "Translucent";
	}
	States
	{
	Spawn:
		MOSS A -1;
		Stop;
	}
}

class CZMossCeiling2 : Actor replaces ZMossCeiling2
{
	Default
	{
		Radius 20;
		Height 24;
		+SPAWNCEILING
		+NOGRAVITY
		Renderstyle "Translucent";
	}
	States
	{
	Spawn:
		MOSS A -1;
		Stop;
	}
}

class CZTombstoneRIP : Actor replaces ZTombstoneRIP
{
	Default
	{
		Radius 10;
		Height 46;
		+SOLID
	}
	States
	{
	Spawn:
		TOMB A -1;
		Stop;
	}
}

class CZTombstoneShane : Actor replaces ZTombstoneShane
{
	Default
	{
		Radius 10;
		Height 46;
		+SOLID
	}
	States
	{
	Spawn:
		TOMB A -1;
		Stop;
	}
}

class CZTombstoneBigCross : Actor replaces ZTombstoneBigCross
{
	Default
	{
		Radius 10;
		Height 46;
		+SOLID
	}
	States
	{
	Spawn:
		TOMB A -1;
		Stop;
	}
}

class CZTombstoneBrianR : Actor replaces ZTombstoneBrianR
{
	Default
	{
		Radius 10;
		Height 52;
		+SOLID
	}
	States
	{
	Spawn:
		TOMB A -1;
		Stop;
	}
}

class CZTombstoneCrossCircle : Actor replaces ZTombstoneCrossCircle
{
	Default
	{
		Radius 10;
		Height 52;
		+SOLID
	}
	States
	{
	Spawn:
		TOMB A -1;
		Stop;
	}
}

class CZTombstoneSmallCross : Actor replaces ZTombstoneSmallCross
{
	Default
	{
		Radius 8;
		Height 46;
		+SOLID
	}
	States
	{
	Spawn:
		TOMB A -1;
		Stop;
	}
}

class CZTombstoneBrianP : Actor replaces ZTombstoneBrianP
{
	Default
	{
		Radius 8;
		Height 46;
		+SOLID
	}
	States
	{
	Spawn:
		TOMB A -1;
		Stop;
	}
}

class CZWingedStatue : WallCheckActor replaces ZWingedStatue
{
	Default
	{
		Radius 10;
		Height 62;
		+SOLID
	}
	States
	{
	Spawn:
		WSTS A -1;
		Stop;
	}
}