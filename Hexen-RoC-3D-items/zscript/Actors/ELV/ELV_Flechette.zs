
// Poison Bag (Flechette used by Cleric) ------------------------------------

class CPoisonBag : PoisonBag replaces PoisonBag
{
	Default
	{
		Radius 5;
		Height 5;
		+NOBLOCKMAP +NOGRAVITY
	}

	States
	{
	Spawn:
		FLEC A 0;
		FLEC A 0 A_SpawnItemEX("CPoisonBagBottom");
		FLEC A 18;
		FLEC A 4;
		FLEC A 3;
		FLEC A 1 A_PoisonBagInit;
		Stop;
	}
}

class CPoisonBagBottom : Actor
{
	Default
	{
		Radius 5;
		Height 5;
		Renderstyle "Add";
		+NOBLOCKMAP +NOGRAVITY
	}

	States
	{
	Spawn:
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		FLEC A 1;
		Stop;
	}
}

// Fire Bomb (Flechette used by Mage) ---------------------------------------

class CFireBomb : Actor replaces FireBomb
{
	Default
	{
		DamageType "Fire";
		+NOGRAVITY
		+FOILINVUL
		RenderStyle "Translucent";
		DeathSound "FlechetteExplode";
	}

	States
	{
	Spawn:
		FLEC A 0;
		FLEC A 0 A_SpawnItemEX("CFireBombBottom");
		FLEC STUVWXYZ[\] 2;
		/*FLEC T 2;
		FLEC U 2;
		FLEC V 2;
		FLEC W 2;
		FLEC X 2;
		FLEC Y 2;
		FLEC Z 2;
		FLEC [ 2;
		FLEC \ 2;
		FLEC [ 2;*/
		FLED ABCDEFGHIJKLM 2;
		/*FLED B 2;
		FLED C 2;
		FLED D 2;
		FLED E 2;
		FLED F 2;
		FLED G 2;
		FLED H 2;
		FLED I 2;
		FLED J 2;
		FLED K 2;
		FLED L 2;
		FLED M 2;*/
		FLED N 2 A_Scream;
		XPL1 A 4 Bright A_TimeBomb;
		XPL1 BCDEF 4 Bright;
		Stop;
	}
	void A_TimeBomb()
	{
		AddZ(32, false);
		A_SetRenderStyle(1., STYLE_Add);
		A_Explode();
	}
}

class CFireBombBottom : Actor
{
	Default
	{
		DamageType "Fire";
		+NOGRAVITY
		+FOILINVUL
		RenderStyle "Add";
		DeathSound "FlechetteExplode";
	}

	States
	{
	Spawn:
		FLEC S 3;
		FLEC TUVWXYZ[\] 2;
		/*FLEC U 2;
		FLEC V 2;
		FLEC W 2;
		FLEC X 2;
		FLEC Y 2;
		FLEC Z 2;
		FLEC [ 2;
		FLEC \ 2;
		FLEC [ 2;*/
		FLED ABCDEFGHIJKLMN 2;
		/*FLED B 2;
		FLED C 2;
		FLED D 2;
		FLED E 2;
		FLED F 2;
		FLED G 2;
		FLED H 2;
		FLED I 2;
		FLED J 2;
		FLED K 2;
		FLED L 2;
		FLED M 2;
		FLED N 2;*/
		Stop;
	}
}

// Throwing Bomb (Flechette used by Fighter) --------------------------------

class CThrowingBomb : ThrowingBomb replaces ThrowingBomb
{
	Default
	{
		Health 48;
		Speed 12;
		Radius 8;
		Height 10;
		DamageType "Fire";
		Renderstyle "Add";
		+NOBLOCKMAP +DROPOFF +MISSILE
		BounceType "HexenCompat";
		SeeSound "FlechetteBounce";
		DeathSound "FlechetteExplode";
	}

	States
	{
	Spawn:
		FLEC B 4;
		FLEC CDEFGHIJKLMNOPQ 2 A_CheckThrowBomb;
		FLEC BCDEFGHIJKLMN 2 A_CheckThrowBomb;
		FLEC O 2 A_CheckThrowBomb2;
		Loop;
	Tail:
		FLEC PQPOPQO 3 A_CheckThrowBomb;
		Wait;
	Death:
		CFCF Q 4 Bright A_NoGravity;
		CFCF R 3 Bright A_Scream;
		CFCF S 4 Bright A_Explode;
		CFCF T 3 Bright;
		CFCF U 4 Bright;
		CFCF W 3 Bright;
		CFCF X 4 Bright;
		CFCF Z 3 Bright;
		Stop;
	}
}

// Poison Bag Artifact (Flechette) ------------------------------------------

class CArtiPoisonBag : Inventory replaces ArtiPoisonBag
{
	Actor g;
	Default
	{
		+FLOATBOB
		+NOGRAVITY
		Inventory.DefMaxAmount;
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.INVBAR +INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTIPSBG";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIPOISONBAG";
		Tag "$TAG_ARTIPOISONBAG";
	}
	States
	{
	Spawn:
		FLEC A 1;
		FLEC A -1;
		Stop;
	}
	override void PostBeginPlay()
  {
    super.PostBeginPlay();
    g = Spawn("CArtiPoisonBagBottom", pos);
    if (g)
    {
      g.FloatBobPhase = FloatBobPhase;
	  g.target = self;
    }
  } 
  
  //============================================================================
	//
	// AArtiPoisonBag :: BeginPlay
	//
	//============================================================================

	override void BeginPlay ()
	{
		Super.BeginPlay ();
		// If a subclass's specific icon is not defined, let it use the base class's.
		if (!Icon.isValid())
		{
			Icon = GetDefaultByType("CArtiPoisonBag").Icon;
		}
	}

	//============================================================================
	//
	// GetFlechetteType
	//
	//============================================================================

	private class<Actor> GetFlechetteType(Actor other)
	{
		class<Actor> spawntype = null;
		PlayerPawn pp = PlayerPawn(other);
		if (pp)
		{
			spawntype = pp.FlechetteType;
		}
		if (spawntype == null)
		{
			// default fallback if nothing valid defined.
			spawntype = "CArtiPoisonBag3";
		}
		return spawntype;
	}

	//============================================================================
	//
	// AArtiPoisonBag :: HandlePickup
	//
	//============================================================================

	override bool HandlePickup (Inventory item)
	{
		// Only do special handling when picking up the base class
		if (item.GetClass() != "CArtiPoisonBag")
		{
			return Super.HandlePickup (item);
		}

		if (GetClass() == GetFlechetteType(Owner))
		{
			if (Amount < MaxAmount || sv_unlimited_pickup)
			{
				Amount += item.Amount;
				if (Amount > MaxAmount && !sv_unlimited_pickup)
				{
					Amount = MaxAmount;
				}
				item.bPickupGood = true;
			}
			return true;
		}
		return false;
	}

	//============================================================================
	//
	// AArtiPoisonBag :: CreateCopy
	//
	//============================================================================

	override Inventory CreateCopy (Actor other)
	{
		// Only the base class gets special handling
		if (GetClass() != "CArtiPoisonBag")
		{
			return Super.CreateCopy (other);
		}

		class<Actor> spawntype = GetFlechetteType(other);
		let copy = Inventory(Spawn (spawntype));
		if (copy != null)
		{
			copy.Amount = Amount;
			copy.MaxAmount = MaxAmount;
			GoAwayAndDie ();
		}
		return copy;
	}
 }

class CArtiPoisonBagBottom : Actor
{
	Default
	{
		FloatBobPhase 1;
		//Radius 11;
		+DONTGIB
		+FLOATBOB
		+NOGRAVITY
		Renderstyle "Add";
		//Inventory.PickupSound "";
		//Inventory.PickupMessage "";
		//+INVENTORY.ALWAYSPICKUP
	}
	States
	{
	Spawn:
		FLEC A 1;
		FLEC A 1;
		Loop;
	}
	 override void Tick()
  {
    Super.Tick();
    if(!target || !target.bSpecial)
    {
       self.Destroy();
    }
  }
}

// Poison Bag 1 (The Cleric's) ----------------------------------------------

class CArtiPoisonBag1 : CArtiPoisonBag replaces ArtiPoisonBag1
{
	Default
	{
		Inventory.Icon "ARTIPSBG";
		Tag "$TAG_ARTIPOISONBAG1";
	}
	override bool Use (bool pickup)
	{
		Actor mo = Spawn("PoisonBag", Owner.Vec3Offset(
			16 * cos(Owner.angle),
			24 * sin(Owner.angle),
			-Owner.Floorclip + 8), ALLOW_REPLACE);
		if (mo)
		{
			mo.target = Owner;
			return true;
		}
		return false;
	}
	
	
}

// Poison Bag 2 (The Mage's) ------------------------------------------------

class CArtiPoisonBag2 : CArtiPoisonBag replaces ArtiPoisonBag2
{
	Default
	{
		Inventory.Icon "ARTIPSBG";
		Tag "$TAG_ARTIPOISONBAG2";
	}
	override bool Use (bool pickup)
	{
		Actor mo = Spawn("FireBomb", Owner.Vec3Offset(
			16 * cos(Owner.angle),
			24 * sin(Owner.angle),
			-Owner.Floorclip + 8), ALLOW_REPLACE);
		if (mo)
		{
			mo.target = Owner;
			return true;
		}
		return false;
	}
}

// Poison Bag 3 (The Fighter's) ---------------------------------------------

class CArtiPoisonBag3 : CArtiPoisonBag replaces ArtiPoisonBag3
{
	Default
	{
		Inventory.Icon "ARTIPSBG";
		Tag "$TAG_ARTIPOISONBAG3";
	}
	override bool Use (bool pickup)
	{
		Actor mo = Spawn("ThrowingBomb", Owner.Pos + (0,0,35. - Owner.Floorclip + (Owner.player? Owner.player.crouchoffset : 0)), ALLOW_REPLACE);
		if (mo)
		{
			mo.angle = Owner.angle + (random[PoisonBag](-4, 3) * (360./256.));

			/* Original flight code from Hexen
			 * mo.momz = 4*F.RACUNIT+((player.lookdir)<<(F.RACBITS-4));
			 * mo.z += player.lookdir<<(F.RACBITS-4);
			 * P_ThrustMobj(mo, mo.ang, mo.info.speed);
			 * mo.momx += player.mo.momx>>1;
			 * mo.momy += player.mo.momy>>1;
			 */

			// When looking straight ahead, it uses a z velocity of 4 while the xy velocity
			// is as set by the projectile. To accommodate self with a proper trajectory, we
			// aim the projectile ~20 degrees higher than we're looking at and increase the
			// speed we fire at accordingly.
			double modpitch = clamp(-Owner.Pitch + 20, -89., 89.);
			double ang = mo.angle;
			double speed = (mo.Speed, 4.).Length();
			double xyscale = speed * cos(modpitch);

			mo.Vel.Z = speed * sin(modpitch);
			mo.Vel.X = xyscale * cos(ang) + Owner.Vel.X / 2;
			mo.Vel.Y = xyscale * sin(ang) + Owner.Vel.Y / 2;
			mo.AddZ(mo.Speed * sin(modpitch));

			mo.target = Owner;
			mo.tics -= random[PoisonBag](0, 3);
			mo.CheckMissileSpawn(Owner.radius);
			return true;
		}
		return false;
	}
}

// Poison Cloud -------------------------------------------------------------

class CPoisonCloud : Actor replaces PoisonCloud
{
	Default
	{
		Radius 20;
		Height 30;
		Mass 0x7fffffff;
		+NOBLOCKMAP +NOGRAVITY +DROPOFF
		+NODAMAGETHRUST
		+DONTSPLASH +FOILINVUL +CANBLAST +BLOODLESSIMPACT +BLOCKEDBYSOLIDACTORS +FORCEZERORADIUSDMG +OLDRADIUSDMG
		+FLOATBOB
		RenderStyle "Translucent";
		Alpha 0.6;
		DeathSound "PoisonShroomDeath";
		DamageType "PoisonCloud";
	}

	States
	{
	Spawn:
		TNT1 A 1;
		TNT1 A 1 A_Scream;
		
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 1 A_PoisonBagDamage;
		TNT1 A 1 A_SpawnItemEx("PoisonFog",random(-15,15),0,0,frandom(-0.75,0.75),0,0,random(0,360));
		TNT1 A 2 A_PoisonBagCheck;
		TNT1 A 1 A_PoisonBagCheck;
		
		
	
		/*PSBG D 1;
		PSBG D 1 A_Scream;
		PSBG DEEEFFFGGGHHHII 2 A_PoisonBagDamage;
		PSBG I 2 A_PoisonBagCheck;
		PSBG I 1 A_PoisonBagCheck;*/
		Goto Spawn + 3;
	Death:
		TNT1 A 7;
		TNT1 A 6;
		/*PSBG HG 7;
		PSBG FD 6;*/
		Stop;
	}
	
	//===========================================================================
	//
	// 
	//
	//===========================================================================

	override void BeginPlay ()
	{
		Vel.X = MinVel; // missile objects must move to impact other objects
		special1 = random[PoisonCloud](24, 31);
		special2 = 0;
	}
	
	//===========================================================================
	//
	// 
	//
	//===========================================================================

	override int DoSpecialDamage (Actor victim, int damage, Name damagetype)
	{
		if (victim.player)
		{
			bool mate = (target != null && victim.player != target.player && victim.IsTeammate (target));
			bool dopoison;
			
			if (!mate)
			{
				dopoison = victim.player.poisoncount < 4;
			}
			else
			{
				dopoison = victim.player.poisoncount < (int)(4. * level.teamdamage);
			}

			if (dopoison)
			{
				damage = random[PoisonCloud](15, 30);
				if (mate)
				{
					damage = (int)(damage * level.teamdamage);
				}
				// Handle passive damage modifiers (e.g. PowerProtection)
				damage = victim.GetModifiedDamage(damagetype, damage, true);
				// Modify with damage factors
				damage = victim.ApplyDamageFactor(damagetype, damage);
				if (damage > 0)
				{
					victim.player.PoisonDamage (self, random[PoisonCloud](15, 30), false); // Don't play painsound

					// If successful, play the poison sound.
					if (victim.player.PoisonPlayer (self, self.target, 50))
						victim.A_StartSound ("*poison", CHAN_VOICE);
				}
			}	
			return -1;
		}
		else if (!victim.bIsMonster)
		{ // only damage monsters/players with the poison cloud
			return -1;
		}
		return damage;
	}
	
	//===========================================================================
	//
	// A_PoisonBagCheck
	//
	//===========================================================================

	void A_PoisonBagCheck()
	{
		if (--special1 <= 0)
		{
			SetStateLabel("Death");
		}
	}

	//===========================================================================
	//
	// A_PoisonBagDamage
	//
	//===========================================================================

	void A_PoisonBagDamage()
	{
		A_Explode(4, 40);
		AddZ(BobSin(special2) / 16);
		special2 = (special2 + 1) & 63;
	}
}

class PoisonFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.0;
	Scale 0.2;
	+CLIENTSIDEONLY;
	+FORCEXYBILLBOARD;
	+DONTSPLASH;
	+NOTELEPORT;
	+THRUACTORS;
	+BRIGHT;
	}
    States
    {
    Spawn:
		IFOG C 0;
		IFOG CCCCCC 1 A_FadeIn(0.05);
        IFOG C 1;
		Goto FadeOut;
	FadeOut:
		IFOG C 1 A_FadeOut(0.005);
        Loop;
    }
}

class CZPoisonShroom : PoisonBag replaces ZPoisonShroom
{
	Default
	{
		Radius 6;
		Height 20;
		PainChance 255;
		Health 30;
		Mass 0x7fffffff;
		+SHOOTABLE
		+SOLID
		+NOBLOOD
		+NOICEDEATH
		-NOBLOCKMAP
		-NOGRAVITY
		PainSound "PoisonShroomPain";
		DeathSound "PoisonShroomDeath";
	}

	States
	{
	Spawn:
		MUSH A 5 A_PoisonShroom;
		Goto Pain+1;
	Pain:
		MUSH A 2;
		MUSH B 2;
		MUSH C 2 A_Pain;
		MUSH D 2;
		MUSH E 2;
		MUSH F 2;
		MUSH G 2;
		MUSH H 2;
		MUSH I 2;
		MUSH J 2;
		Goto Spawn;
	Death:
		MUSH A 2;
		MUSH B 2;
		MUSH C 2 A_PoisonBagInit;
		MUSH K -1;
		Stop;
	}
	
	//===========================================================================
	//
	// A_PoisonShroom
	//
	//===========================================================================

	void A_PoisonShroom()
	{
		tics = 128 + (random[PoisonShroom]() << 1);
	}
}