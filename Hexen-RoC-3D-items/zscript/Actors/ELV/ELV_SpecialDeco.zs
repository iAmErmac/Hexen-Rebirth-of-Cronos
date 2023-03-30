//special class to check if faced to wall and then face away
class WallCheckActor2 : SwitchableDecoration
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

class TorchFlame1 : Actor
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
	Death:
		TFLA A 0;
		Stop;
	}
}

class BullFlame1 : Actor
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
	Death:
		TFLA A 0;
		Stop;
	}
}

class CauldronFire : Actor
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
	Death:
		TFLA A 0;
		Stop;
	}
}

class ChandelierFlame : Actor
{
	Default
	{
	Height 1;
	Radius 1;
	RenderStyle "Add";
	Alpha 1.0;
	+SPAWNCEILING;
	+NOGRAVITY;
	+BRIGHT;
	}
	States
	{
	Spawn:
		CHNF ABCDEFGHIJKLMN 3;
		Loop;
	Death:
		CHNF A 0;
		Stop;
	}
}

class CZTwinedTorch : SwitchableDecoration replaces ZTwinedTorch
{
	Default
	{
		Radius 10;
		Height 64;
		+SOLID
	}
	States
	{
	Active:
		TORA A 0 A_StartSound("Ignite");
	Spawn:
		TORA A 1;
		TORA A 1 A_SpawnItemEx("TorchFlame1",0,0,0);
		TORA A -1;
		Stop;
	Inactive:
		TORA A -1;
		Stop;
	}
}

class CZTwinedTorchUnlit : CZTwinedTorch replaces ZTwinedTorchUnlit
{
	States
	{
	Spawn:
		Goto Super::Inactive;
	}
}

class CZFireBull : WallCheckActor2 replaces ZFireBull
{
	Default
	{
		Radius 20;
		Height 80;
		+SOLID
	}
	States
	{
	Active:
		BTRC A 0 A_StartSound("Ignite");
	Spawn:
		BTRC A 1;
		BTRC A 1 A_SpawnItemEx("BullFlame1",0,0,0);
		BTRC A -1;
		Stop;
	Inactive:
		BTRC A -1;
		Stop;
	}
}

class CZFireBullUnlit : CZFireBull replaces ZFireBullUnlit
{
	States
	{
	Spawn:
		Goto Super::Inactive;
	}
}

class CZCauldron : SwitchableDecoration replaces ZCauldron
{
	Default
	{
		Radius 12;
		Height 26;
		+SOLID
	}
	States
	{
	Active:
		CAUL A 0 A_StartSound("Ignite");
	Spawn:
		CAUL A 1;
		CAUL A 1 A_SpawnItemEx("CauldronFire",0,0,0);
		CAUL A -1;
		Stop;
	Inactive:
		CAUL A -1;
		Stop;
	}
}

class CZCauldronUnlit : CZCauldron replaces ZCauldronUnlit
{
	States
	{
	Spawn:
		Goto Super::Inactive;
	}
}

class CZChandelier : Actor replaces ZChandelier
{
	Default
	{
		Radius 20;
		Height 60;
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		CHDL A 1;
		CHDL A 1 A_SpawnItemEx("ChandelierChain",0,0,0);
		CHDL A 1 A_SpawnItemEx("ChandelierFlame",0,0,0);
		CHDL A -1;
		Stop;
	}
}

class ChandelierChain : Actor
{
	Default
	{
		Radius 20;
		Height 60;
		Renderstyle "Translucent";
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		CHDL A -1;
		Stop;
	}
}

class CZChandelierUnlit : Actor replaces ZChandelierUnlit
{
	Default
	{
		Radius 20;
		Height 60;
		+SPAWNCEILING
		+NOGRAVITY
	}
	States
	{
	Spawn:
		CHDL A 1;
		CHDL A 1 A_SpawnItemEx("ChandelierChain",0,0,0);
		CHDL A -1;
		Stop;
	}
}

class XmasTreeNeedles : Actor
{
	Default
	{
		Radius 11;
		Height 130;
		Health 20;
		Mass 0x7fffffff;
		-SOLID +SHOOTABLE +NOBLOOD +NOICEDEATH
		Renderstyle "Translucent";
		DeathSound "TreeExplode";
	}
	States
	{
	Spawn:
		CTRE A -1;
		Stop;
	Burn:
		CTRE A 1;
		Stop;
	}
}

class ChristmasTreeFire : Actor
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
		TFLA ABCDEFGHGFEDCBA random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Stop;
	}
}

class CZXmasTree : Actor replaces ZXmasTree
{
	Default
	{
		Radius 11;
		Height 130;
		Health 20;
		Mass 0x7fffffff;
		+SOLID +SHOOTABLE +NOBLOOD +NOICEDEATH
		DeathSound "TreeExplode";
	}
	States
	{
	Spawn:
		CTRE A 1;
		CTRE A 1 A_SpawnItemEx("XmasTreeNeedles",0,0,0);
		CTRE A -1;
		Stop;
	Burn:
		XTFX A 3;
		XTFX A 3 A_SpawnItemEx("ChristmasTreeFire",0,0,0);
        XTFX B 3;
        XTFX C 3 A_Scream;
        XTFX D 3;
        XTFX E 3;
        XTFX F 3;
        XTFX G 3;
        XTFX H 3 A_Explode(30, 64);
        XTFX I 3;
        XTFX J 3;
        XTFX K 3;
        XTFX L 3;
        XTFX M 3;
        XTFX N 3;
        XTFX O 3;
        XTFX P 3;
        XTFX Q 3;
        XTFX R 3;
        XTFX S 3 A_NoBlocking;
        XTFX T 3;
        XTFX U 3;
        XTFX V 3;
        XTFX W 3;
        XTFX X 3;
        XTFX Y 3;
        XTFX Z 3;
        XTFX [ 3;
        XTFX \ 3;
        XTFX ] 3;
        XTFY A 3;
        XTFY B -1;
		Stop;
	}
}

class CZCorpseLynchedNoHeart : Actor replaces ZCorpseLynchedNoHeart
{
	Default
	{
		Radius 10;
		Height 100;
		+SOLID +SPAWNCEILING +NOGRAVITY
	}

	States
	{
	Spawn:
		CORP A 140 A_CorpseBloodDrip;
		Loop;
	}
	
	override void PostBeginPlay ()
	{
		Super.PostBeginPlay ();
		Spawn ("BloodPool", (pos.xy, floorz), ALLOW_REPLACE);
	}

	//============================================================================
	//
	// A_CorpseBloodDrip
	//
	//============================================================================

	void A_CorpseBloodDrip()
	{
		if (random[CorpseDrip]() <= 128)
		{
			Spawn ("CorpseBloodDrip", pos + (0, 0, Height / 2), ALLOW_REPLACE);
		}
	}
}

class CZCorpseSitting : Actor replaces ZCorpseSitting
{
	Default
	{
		Health 30;
		Radius 15;
		Height 35;
		+SOLID +SHOOTABLE +NOBLOOD
		+NOICEDEATH
		DeathSound "FireDemonDeath";
	}

	States
	{
	Spawn:
		CORP A -1;
		Stop;
	Death:
		CORS ABCDEFGHIJKLMN 1;
		CORS O -1;
		Stop;
	}
}

class TreeCrushFire : Actor
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
		TFLA ABCDEFGHGFEDCBA random(1,2) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Stop;
	}
}

class TreeCrush : Actor replaces TreeDestructible
{
	Default
	{
		Health 70;
		Radius 15;
		Height 180;
		DeathHeight 24;
		Mass 0x7fffffff;
		PainSound "TreeExplode";
		DeathSound "TreeBreak";
		+SOLID +SHOOTABLE +NOBLOOD +NOICEDEATH
	}
	States
	{
	Spawn:
	Spawn:
		TREC A 1 NoDelay A_SetAngle(random(0, 360));
		TREC A -1;
		Stop;
	Death:
		TREC B 4;
		TREC C 4 A_Scream;
		TREC DEFGHIJKLMNOPQR 4;
		TREC S -1;
		Stop;
	Burn:
		TREF B 6;
		TREF B 6  A_SpawnItemEx("TreeCrushFire",0,0,0);
		TREF C 6 A_Pain;
		TREF D 6;
		TREF EFGH 6;
		TREF I 6 A_Explode(10, 128);
		TREF JKLMNOPQR 6;
		TREF S -1;
		Stop;
	} 
}

class TorchFire : Actor
{
	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
		+FIXMAPTHINGPOS
		+BRIGHT
		Radius 1;
		RenderStyle "Add";
		Alpha 1.0;
	}
	States
	{
	Spawn:
		TFLA ABCDEFGH random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Loop;
	}
}

class CZWallTorch : SwitchableDecoration replaces ZWallTorch
{
	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
		+FIXMAPTHINGPOS
		Radius 6.5;
	}
	States
	{
	Active:
		TRCH A 0 Bright A_StartSound("Ignite");
	Spawn:
		TRCH A 1;
		TRCH A 1 A_SpawnItemEx("TorchFire",0,0,0);
		TRCH A -1;
		Stop;
	Inactive:
		TRCH A -1;
		Stop;
	}
}

class CZWallTorchUnlit : CZWallTorch replaces ZWallTorchUnlit
{
	States
	{
	Spawn:
		Goto Super::Inactive;
	}
}

class CandleBigFire : Actor
{
	Default
	{
		Radius 20;
		Height 16;
		Renderstyle "Add";
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		CBBF ABCDEFGHIJKLMNOPQRST 1;
		Loop;
	}
}

class CandleBlueFire : Actor
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
		CNBF ABCDEFGHIJKLMNOPQRST 1;
		Loop;
	}
}

class CZCandle : Actor replaces ZCandle
{
	Default
	{
		Radius 20;
		Height 16;
		+NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
	Spawn:
		CBDB A 1;
		CBDB A 1 A_SpawnItemEx("CandleBigFire",0,0,0);
		CBDB A -1;
		Stop;
	}
}

class CZBlueCandle : Actor replaces ZBlueCandle
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
		CNDB A 1;
		CNDB A 1 A_SpawnItemEx("CandleBlueFire",0,0,0);
		CNDB A -1;
		Stop;
	}
}

class CZSuitOfArmor : WallCheckActor replaces ZSuitOfArmor
{
	Default
	{
		Health 60;
		Radius 16;
		Height 72;
		Mass 0x7fffffff;
		+SOLID +SHOOTABLE +NOBLOOD
		+NOICEDEATH
		DeathSound "SuitofArmorBreak";
	}

	States
	{
	Spawn:
		KNPC A -1;
		Stop;
	Death:
		KNPC A 1 A_SoAExplode;
		Stop;
	}
	
	//===========================================================================
	//
	// A_SoAExplode - Suit of Armor Explode
	//
	//===========================================================================

	void A_SoAExplode()
	{
		for (int i = 0; i < 10; i++)
		{
			double xo = (random[SoAExplode]() - 128) / 16.;
			double yo = (random[SoAExplode]() - 128) / 16.;
			double zo = random[SoAExplode]() * Height / 256.;
			Actor mo = Spawn ("ZArmorChunk", Vec3Offset(xo, yo, zo), ALLOW_REPLACE);
			if (mo)
			{
				mo.SetState (mo.SpawnState + i);
				mo.Vel.X = random2[SoAExplode]() / 64.;
				mo.Vel.Y = random2[SoAExplode]() / 64.;
				mo.Vel.Z = random[SoAExplode](5, 12);
			}
		}
		// Spawn an item?
		Class<Actor> type = GetSpawnableType(args[0]);
		if (type != null)
		{
			if (!(level.nomonsters || sv_nomonsters) || !(GetDefaultByType (type).bIsMonster))
			{ // Only spawn monsters if not -nomonsters
				Spawn (type, Pos, ALLOW_REPLACE);
			}
		}
		A_StartSound (DeathSound, CHAN_BODY);
		Destroy ();
	}
}


// Armor chunk --------------------------------------------------------------

class CZArmorChunk : Actor replaces ZArmorChunk
{
	Default
	{
		Radius 4;
		Height 8;
	}
	States
	{
	Spawn:
		KNPC B -1;
		Stop;
		KNPC C -1;
		Stop;
		KNPC D -1;
		Stop;
		KNPC E -1;
		Stop;
		KNPC F -1;
		Stop;
		KNPC G -1;
		Stop;
		KNPC H -1;
		Stop;
		KNPC I -1;
		Stop;
		KNPC J -1;
		Stop;
		KNPC K -1;
		Stop;
	}
}

// Pottery1 ------------------------------------------------------------------

class CPottery1 : Actor replaces Pottery1
{
	Default
	{
		Health 15;
		Speed 10;
		Height 32;
		+SOLID +SHOOTABLE +NOBLOOD +DROPOFF +SMASHABLE
		+SLIDESONWALLS +PUSHABLE +TELESTOMP +CANPASS
		+NOICEDEATH
	}


	States
	{
	Spawn:
		VASE A -1;
		Loop;
	Death:
		VASE A 0 A_PotteryExplode;
		Stop;
	}
	
	//============================================================================
	//
	// A_PotteryExplode
	//
	//============================================================================

	void A_PotteryExplode()
	{
		Actor mo = null;
		int i;

		for(i = random[Pottery](3, 6); i; i--)
		{
			mo = Spawn ("PotteryBit", Pos, ALLOW_REPLACE);
			if (mo)
			{
				mo.SetState (mo.SpawnState + random[Pottery](0, 4));
				mo.Vel.X = random2[Pottery]() / 64.;
				mo.Vel.Y = random2[Pottery]() / 64.;
				mo.Vel.Z = random[Pottery](5, 12) * 0.75;
			}
		}
		mo.A_StartSound ("PotteryExplode", CHAN_BODY);
		// Spawn an item?
		Class<Actor> type = GetSpawnableType(args[0]);
		if (type != null)
		{
			if (!(level.nomonsters || sv_nomonsters) || !(GetDefaultByType (type).bIsMonster))
			{ // Only spawn monsters if not -nomonsters
				Spawn (type, Pos, ALLOW_REPLACE);
			}
		}
	}
}

// Pottery2 -----------------------------------------------------------------

class CPottery2 : CPottery1  replaces Pottery2
{
	Default
	{
		Height 25;
	}
	States
	{
	Spawn:
		VASE A -1;
		Stop;
	}
	
}

// Pottery3 -----------------------------------------------------------------

class CPottery3 : CPottery1  replaces Pottery3
{
	Default
	{
		Height 25;
	}
	States
	{
	Spawn:
		VASE A -1;
		Stop;
	}
}

// Pottery Bit --------------------------------------------------------------

class CPotteryBit : Actor replaces PotteryBit
{
	State LoopState;
	
	Default
	{
		Radius 5;
		Height 5;
		+MISSILE
		+NOTELEPORT
		+NOICEDEATH
	}

	States
	{
	Spawn:
		POTB ABCDE -1;
		Stop;
	Death:
		POTB C 0 A_PotteryChooseBit;
		Stop;
	Pottery1:
		POTB C 140;
		POTB C 1 A_PotteryCheck;
		Stop;
	Pottery2:
		POTB F 140;
		POTB F 1 A_PotteryCheck;
		Stop;
	Pottery3:
		POTB I 140;
		POTB I 1 A_PotteryCheck;
		Stop;
	Pottery4:
		POTB G 140;
		POTB G 1 A_PotteryCheck;
		Stop;
	Pottery5:
		POTB A 140;
		POTB A 1 A_PotteryCheck;
		Stop;
	}
	
	//============================================================================
	//
	// A_PotteryChooseBit
	//
	//============================================================================

	void A_PotteryChooseBit()
	{
		static const statelabel bits[] = { "Pottery1", "Pottery2", "Pottery3", "Pottery4", "Pottery5" };
		LoopState = FindState(bits[random[PotteryBit](0, 4)]);	// Save the state for jumping back to.
		SetState (LoopState);
		tics = 256 + (random[PotteryBit]() << 1);
	}

	//============================================================================
	//
	// A_PotteryCheck
	//
	//============================================================================

	void A_PotteryCheck()
	{
		for(int i = 0; i < MAXPLAYERS; i++)
		{
			if (playeringame[i])
			{
				Actor pmo = players[i].mo;
				if (CheckSight (pmo) && (absangle(pmo.AngleTo(self), pmo.Angle) <= 45))
				{ // jump back to previpusly set state.
					SetState (LoopState);
					return;
				}
			}
		}
	}
}

class PiedestalGem : Actor
{
	Default
	{
		Radius 10;
		Height 40;
		Renderstyle "Add";
		+SOLID
	}
	States
	{
	Spawn:
		PIEG A -1;
		Stop;
	}
}

class CZGemPedestal : SwitchingDecoration replaces ZGemPedestal
{
	Default
	{
		Radius 10;
		Height 40;
		+SOLID
	}
	States
	{
	Spawn:
		PIED A -1;
		Stop;
	Active:
		PIED A 1;
		PIED A 1 A_SpawnItemEx("PiedestalGem",0,0,0);
		PIED A -1;
		Stop;
	}
}

class CZWingedStatueNoSkull : SwitchingDecoration replaces ZWingedStatueNoSkull
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
	Active:
		WSTS B -1;
		Stop;
	}
}

// Shrub1 -------------------------------------------------------------------

class ShrubSmall : Actor replaces ZShrub1
{
	Default
	{
		Radius 8;
		Height 24;
		Health 20;
		Mass 0x7fffffff;
		+SOLID +SHOOTABLE +NOBLOOD +NOICEDEATH
		DeathSound "TreeExplode";
	}
	States
	{
	Spawn:
		SHRU A -1;
		Stop;
	Burn:
		SHRU B 1;
		SHRU B 1 A_SpawnItemEx("ShrubSmallFire",0,0,0);
		SHRU B 6 A_Scream;
		SHRU B -1;
		Stop;
	}
}


// Shrub2 -------------------------------------------------------------------

class ShrubBig : Actor replaces ZShrub2
{
	Default
	{
		Radius 16;
		Height 40;
		Health 20;
		Mass 0x7fffffff;
		+SOLID +SHOOTABLE +NOBLOOD +NOICEDEATH
		DeathSound "TreeExplode";
	}
	States
	{
	Spawn:
		SHRU C -1;
		Stop;
	Burn:
		SHRU D 1;
		SHRU D 1 A_SpawnItemEx("ShrubBigFire",0,0,0);
		SHRU D 6 A_Scream;
		SHRU D 5 A_Explode(30, 64);
		SHRU D -1;
		Stop;
	}
}

class ShrubSmallFire : Actor
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
		TFLA ABCDEFGHGFEDCBA random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Stop;
	}
}

class ShrubBigFire : Actor
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
		TFLA ABCDEFGHGFEDCBA random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Stop;
	}
}