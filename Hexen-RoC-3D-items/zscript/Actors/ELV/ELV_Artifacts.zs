class RedFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.1;
	Scale 0.08;
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
		IFOG A 0;
		IFOG AAAAAA 1 A_FadeIn(0.05);
        IFOG A 1;
		Goto FadeOut;
	FadeOut:
		IFOG A 1 A_FadeOut(0.005);
        Loop;
    }
}

class BlueFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.1;
	Scale 0.08;
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
		IFOG D 0;
		IFOG DDDDDD 1 A_FadeIn(0.05);
        IFOG D 1;
		Goto FadeOut;
	FadeOut:
		IFOG D 1 A_FadeOut(0.005);
        Loop;
    }
}

class PurpleFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.1;
	Scale 0.08;
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
		IFOG E 0;
		IFOG EEEEEE 1 A_FadeIn(0.05);
        IFOG E 1;
		Goto FadeOut;
	FadeOut:
		IFOG E 1 A_FadeOut(0.005);
        Loop;
    }
}

class GreenFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.1;
	Scale 0.08;
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

class CPickupFlash : Actor replaces PickupFlash
{
	Default
	{
	+NOGRAVITY
	}
	States
	{
	Spawn:
		PUP1 ABCDEFGHIJKLMNOPQRSTUVWXYZ 1;
    Stop;
	}
}
class CArtiSpeedBoots : PowerupGiver replaces ArtiSpeedBoots
{
	Default
	{
		+FLOATBOB
		+COUNTITEM
		Inventory.PickupFlash "PickupFlash";
		Inventory.Icon "ARTISPED";
		Inventory.PickupMessage "$TXT_ARTISPEED";
		Tag "$TAG_ARTISPEED";
		Powerup.Type "PowerSpeed";
	}
	States
	{
	Spawn:
		SBOA A 1;
		Loop;
	}
}

class CVial : CrystalVial replaces CrystalVial
{
	Actor g;
	Default
	{
		+FLOATBOB
		+NOGRAVITY
		Inventory.Amount 10;
		Inventory.PickupMessage "$TXT_ITEMHEALTH";
	}
	States
	{
	Spawn:
		VIAL A 1;
		Loop;
	NoVFX:
		VIAL A 17;
		Goto Spawn;
	}
	override void PostBeginPlay()
	{
    super.PostBeginPlay();
    g = Spawn("CVialGlass", pos);
    if (g)
    {
      g.FloatBobPhase = FloatBobPhase;
	  g.target = self;
    }
	}
}

class CVialGlass : Actor
{
	Default
	{
		FloatBobPhase 1;
		+DONTGIB
		+FLOATBOB
		+NOGRAVITY
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		VIAL A -1;
		Stop;
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

class VialFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.1;
	Scale 0.05;
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
		IFOG D 0;
		IFOG DDDDDD 1 A_FadeIn(0.05);
        IFOG D 1;
		Goto FadeOut;
	FadeOut:
		IFOG D 1 A_FadeOut(0.005);
        Loop;
    }
}

/*class CArtiHealth : HealthPickup replaces ArtiHealth
{
	Actor g;
	Default
	{
		FloatBobPhase 1;
		+COUNTITEM
		+FLOATBOB
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTIPTN2";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIHEALTH";
		Tag "$TAG_ARTIHEALTH";
		HealthPickup.Autouse 1;
	}
	States
	{
	Spawn:
		FLSK A 1;
		Loop;
	}
	override void PostBeginPlay()
  {
    super.PostBeginPlay();
    g = Spawn("CArtiHealthGlass", pos);
    if (g)
    {
      g.FloatBobPhase = FloatBobPhase;
    }
  }
  override void Tick()
  {
    super.Tick();
    // Destroy glow if this item has an owner:
    if (owner && g)
    {
      g.Destroy();
    }
  }
  
}

class CArtiHealthGlass : Actor
{
	Default
	{
		FloatBobPhase 1;
		+DONTGIB
		+FLOATBOB
		Renderstyle "Add";
		//Inventory.PickupSound "";
		//Inventory.PickupMessage "";
		//+INVENTORY.ALWAYSPICKUP
	}
	States
	{
	Spawn:
		FLSK A 1;
		Loop;
	}
}*/

class CArtiHealth : ArtiHealth replaces ArtiHealth
{
	Actor g;
	Default
	{
		FloatBobPhase 1;
		+COUNTITEM
		+FLOATBOB
		+NOGRAVITY
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTIPTN2";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIHEALTH";
		Tag "$TAG_ARTIHEALTH";
		HealthPickup.Autouse 1;
	}
	States
	{
	Spawn:
		FLSK A 1;
		Loop;
	}
	override void PostBeginPlay()
  {
    super.PostBeginPlay();
    g = Spawn("CArtiHealthGlass", pos);
    if (g)
    {
      g.FloatBobPhase = FloatBobPhase;
      g.target = self;
    }
  }
  
}

class CArtiHealthGlass : Actor
{
	Default
	{
		FloatBobPhase 1;
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
		FLSK A 1;
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

class FlaskFog : Actor
{
	Default
	{
    Radius 1;
    Height 1;
    RenderStyle "Add";
    Alpha 0.0;
	Gravity 0.1;
	Scale 0.075;
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
		IFOG E 0;
		IFOG EEEEEE 1 A_FadeIn(0.05);
        IFOG E 1;
		Goto FadeOut;
	FadeOut:
		IFOG E 1 A_FadeOut(0.005);
        Loop;
    }
}

class CArtiTeleport : Inventory replaces ArtiTeleport
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		+INVENTORY.INVBAR
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.DefMaxAmount;
		Inventory.Icon "ARTIATLP";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTITELEPORT";
		Tag "$TAG_ARTITELEPORT";
	}
	States
	{
	Spawn:
		CHDV A 1;
		CHDV B 1;
		CHDV C 1;
		CHDV D 1;
		CHDV E 1;
		CHDV F 1;
		CHDV G 1;
		CHDV H 1;
		CHDV I 1;
		CHDV J 1;
		CHDV K 1;
		CHDV L 1;
		CHDV M 1;
		CHDV N 1;
		CHDV O 1;
		CHDV P 1;
		Loop;
	NoVFX:
		CHDV A 17;
		Goto Spawn;
	}
	
	override bool Use (bool pickup)
	{
		Vector3 dest;
		int destAngle;

		if (deathmatch)
		{
			[dest, destAngle] = level.PickDeathmatchStart();
		}
		else
		{
			[dest, destAngle] = level.PickPlayerStart(Owner.PlayerNumber());
		}
		dest.Z = ONFLOORZ;
		Owner.Teleport (dest, destAngle, TELF_SOURCEFOG | TELF_DESTFOG);
		bool canlaugh = true;
		Playerinfo p = Owner.player;
		if (p && p.morphTics && (p.MorphStyle & MRF_UNDOBYCHAOSDEVICE))
		{ // Teleporting away will undo any morph effects (pig)
			if (!p.mo.UndoPlayerMorph (p, MRF_UNDOBYCHAOSDEVICE) && (p.MorphStyle & MRF_FAILNOLAUGH))
			{
				canlaugh = false;
			}
		}
		if (canlaugh)
		{ // Full volume laugh
			Owner.A_StartSound ("*evillaugh", CHAN_VOICE, CHANF_DEFAULT, 1., ATTN_NONE);
		}
		return true;
	}
	
}

class CArtiTeleportOther : Inventory replaces ArtiTeleportOther
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		+INVENTORY.INVBAR
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.PickupFlash "PickupFlash";
		Inventory.DefMaxAmount;
		Inventory.Icon "ARTITELO";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTITELEPORTOTHER";
		Tag "$TAG_ARTITELEPORTOTHER";
	}
	States
	{
	Spawn:
		CHDV A 1;
		CHDV B 1;
		CHDV C 1;
		CHDV D 1;
		CHDV E 1;
		CHDV F 1;
		CHDV G 1;
		CHDV H 1;
		CHDV I 1;
		CHDV J 1;
		CHDV K 1;
		CHDV L 1;
		CHDV M 1;
		CHDV N 1;
		CHDV O 1;
		Loop;
	}
	
	//===========================================================================
	//
	// Activate Teleport Other
	//
	//===========================================================================

	override bool Use (bool pickup)
	{
		Owner.SpawnPlayerMissile ("TelOtherFX1");
		return true;
	}

	
}

class CArtiBoostMana : CustomInventory replaces ArtiBoostMana
{
	Default
	{
		+FLOATBOB
		+COUNTITEM
		+INVENTORY.INVBAR
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.PickupFlash "PickupFlash";
		Inventory.DefMaxAmount;
		Inventory.Icon "ARTIBMAN";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIBOOSTMANA";
		Tag "$TAG_ARTIBOOSTMANA";
	}
	States
	{
	Spawn:
		COMI A 1;
		Loop;
	Use:
		TNT1 A 0 A_GiveInventory("Mana1", 200);
		TNT1 A 0 A_GiveInventory("Mana2", 200);
		Stop;
	}
}

class CMana1 : CustomInventory replaces Mana1
{
	Default
	{
		Radius 8;
		Height 8;
		+FLOATBOB
		Inventory.PickupMessage "$TXT_MANA_1";
	}
	States
	{
	Spawn:
		MAN1 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("Mana1", 15);
		Stop;
	}
}

class CMana2 : CustomInventory replaces Mana2
{
	Default
	{
		Radius 8;
		Height 8;
		+FLOATBOB
		Inventory.PickupMessage "$TXT_MANA_2";
	}
	States
	{
	Spawn:
		MAN2 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("Mana2", 15);
		Stop;
	}
}

class CMana3 : CustomInventory replaces Mana3
{
	Default
	{
		Radius 8;
		Height 8;
		+FLOATBOB
		Inventory.PickupMessage "$TXT_MANA_BOTH";
	}
	States
	{
	Spawn:
		MAN3 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("Mana1", 20);
		TNT1 A 0 A_GiveInventory("Mana2", 20);
		Stop;
	}
}

class CArtiInvulnerability2 : PowerupGiver replaces ArtiInvulnerability2
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		+Inventory.BIGPOWERUP
		Inventory.PickupFlash "PickupFlash";
		Inventory.RespawnTics 4230;
		Inventory.Icon "ARTIDEFN";
		Inventory.PickupMessage "$TXT_ARTIINVULNERABILITY2";
		Powerup.Type "PowerInvulnerable";
		Tag "$TAG_ARTIDEFENDER";
	}
	States
	{
	Spawn:
		IODF A 1;
		Loop;
	}
}

class CArtiHealingRadius : Inventory replaces ArtiHealingRadius
{
	const HEAL_RADIUS_DIST = 255.;

	Default
	{
		+COUNTITEM
		+FLOATBOB
		Inventory.DefMaxAmount;
		+INVENTORY.INVBAR 
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.PickupFlash "PickupFlash";
		Inventory.Icon "ARTIHRAD";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIHEALINGRADIUS";
		Tag "$TAG_ARTIHEALINGRADIUS";
	}
	States
	{
	Spawn:
		MYST A 1;
		Loop;
	}	
	
	override bool Use (bool pickup)
	{
		bool effective = false;
		Name mode = 'Health';
		
		PlayerPawn pp = PlayerPawn(Owner);
		if (pp) mode = pp.HealingRadiusType;

		for (int i = 0; i < MAXPLAYERS; ++i)
		{
			if (!playeringame[i])
			{
				continue;
			}

			PlayerPawn mo = players[i].mo;
			if (mo != null && mo.health > 0 && mo.Distance2D (Owner) <= HEAL_RADIUS_DIST)
			{
				// Q: Is it worth it to make this selectable as a player property?
				// A: Probably not - but it sure doesn't hurt.
				bool gotsome=false;
				switch (mode)
				{
				case 'Armor':
					for (int j = 0; j < 4; ++j)
					{
						HexenArmor armor = HexenArmor(Spawn("HexenArmor"));
						armor.health = j;
						armor.Amount = 1;
						if (!armor.CallTryPickup (mo))
						{
							armor.Destroy ();
						}
						else
						{
							gotsome = true;
						}
					}
					break;

				case 'Mana':
				{
					int amount = random[HealRadius](50, 99);

					if (mo.GiveAmmo ("Mana1", amount) ||
						mo.GiveAmmo ("Mana2", amount))
					{
						gotsome = true;
					}
					break;
				}

				default:
				//case NAME_Health:
					gotsome = mo.GiveBody (random[HealRadius](50, 99));
					break;
				}
				if (gotsome)
				{
					mo.A_StartSound ("MysticIncant", CHAN_AUTO);
					effective=true;
				}
			}
		}
		return effective;

	}
	
}

class CArtiSuperHealth : HealthPickup replaces ArtiSuperHealth
{
	Default
	{
		Health 100;
		+COUNTITEM
		+FLOATBOB
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTISPHL";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTISUPERHEALTH";
		Tag "$TAG_ARTISUPERHEALTH";
		HealthPickup.Autouse 2;
	}
	States
	{
	Spawn:
		MYST A 350;
		Loop;
	}
}

class TorchItemFire : Inventory
{
	Default
	{
	FloatBobPhase 1;
	RenderStyle "Add";
	Alpha 1.0;
	+BRIGHT;
	+FLOATBOB
	+INVENTORY.ALWAYSPICKUP
	Inventory.PickupMessage "";
	}
	States
	{
	Spawn:
		TFLA ABCDEFGH random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Loop;
	}
}

class CArtiTorch : PowerupGiver replaces ArtiTorch
{
	Default
	{
		FloatBobPhase 1;
		+COUNTITEM
		+FLOATBOB
		Inventory.PickupFlash "PickupFlash";
		Inventory.Icon "ARTITRCH";
		Inventory.PickupMessage "$TXT_ARTITORCH";
		Tag "$TAG_ARTITORCH";
		Powerup.Type "PowerTorch";
	}
	States
	{
	Spawn:
		TORC A -1;
		Stop;
	}
	override void PostBeginPlay()
	{
    super.PostBeginPlay();
    let g = Spawn("TorchItemFire", pos);
    if (g)
    {
      g.FloatBobPhase = FloatBobPhase;
    }
	}
}

class CArtiFly : PowerupGiver replaces ArtiFly
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		Inventory.PickupFlash "PickupFlash";
		Inventory.InterHubAmount 0;
		Inventory.RespawnTics 4230;
		Inventory.Icon "ARTISOAR";
		Inventory.PickupMessage "$TXT_ARTIFLY";
		Tag "$TAG_ARTIFLY";
		Powerup.Type "PowerFlight";
	}
	States
	{
	Spawn:
		SKUL ABCDEFGHI 3;
		Loop;
	}
}