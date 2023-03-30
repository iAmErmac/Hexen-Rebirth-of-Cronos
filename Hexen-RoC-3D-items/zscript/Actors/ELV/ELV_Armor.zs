class CFalconShield : HexenArmor replaces FalconShield
{
    Default
    {
        Health 1;
        Mass 1000;
        +NOGRAVITY
		+FLOATBOB
		Inventory.Amount 0;
		Inventory.PickupMessage "$TXT_ARMOR2";
        }
    States
    {
    Spawn:
        3DMD A -1;
        Stop;
    Death:
        3DMD A 1;
        Stop;
    }
}

class CAmuletOfWarding : HexenArmor replaces AmuletOfWarding
{
    Default
    {
        Health 3;
        Mass 1000;
        +NOGRAVITY
		+FLOATBOB
		Inventory.Amount 0;
		Inventory.PickupMessage "$TXT_ARMOR4";
        }
    States
    {
    Spawn:
        3DMD A -1;
        Stop;
    Death:
        3DMD A 1;
        Stop;
    }
}

class CPlatinumHelm : HexenArmor replaces PlatinumHelm
{
    Default
    {
        Health 2;
        Mass 1000;
        +NOGRAVITY
		+FLOATBOB
		Inventory.Amount 0;
		Inventory.PickupMessage "$TXT_ARMOR3";
        }
    States
    {
    Spawn:
        3DMD A -1;
        Stop;
    Death:
        3DMD A 1;
        Stop;
    }
}

class CMeshArmor : HexenArmor replaces MeshArmor
{
    Default
    {
        Health 0;
        Mass 1000;
        +NOGRAVITY
		+FLOATBOB
		Inventory.Amount 0;
		Inventory.PickupMessage "$TXT_ARMOR1";
        }
    States
    {
    Spawn:
        3DMD A -1;
        Stop;
    Death:
        3DMD A 1;
        Stop;
    }
}

class CVerge : HexenArmor
{
    Default
    {
        Mass 1000;
        +NOGRAVITY
		+FLOATBOB
        }
    States
    {
    Spawn:
        3DMD A -1;
        Stop;
    Death:
        3DMD A 1;
        Stop;
    }
}

class DragonskinBracers : Inventory replaces ArtiBoostArmor
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		Inventory.DefMaxAmount;
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.INVBAR +INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTIBRAC";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTIBOOSTARMOR";
		Tag "$TAG_ARTIBOOSTARMOR";
	}
	States
	{
	Spawn:
		DSBR A 1;
		DSBR A 1 A_SpawnItemEx("PurpleFog",random(0,4),0,24,frandom(0.15,0.5),0,0,random(0,360));
		Loop;
	}
	
	override bool Use (bool pickup)
	{
		int count = 0;

		if (gameinfo.gametype == GAME_Hexen)
		{
			HexenArmor armor;

			for (int i = 0; i < 4; ++i)
			{
				armor = HexenArmor(Spawn("HexenArmor"));
				armor.bDropped = true;
				armor.health = i;
				armor.Amount = 1;
				if (!armor.CallTryPickup (Owner))
				{
					armor.Destroy ();
				}
				else
				{
					count++;
				}
			}
			return count != 0;
		}
		else
		{
			BasicArmorBonus armor = BasicArmorBonus(Spawn("BasicArmorBonus"));
			armor.bDropped = true;
			armor.SaveAmount = 50;
			armor.MaxSaveAmount = 300;
			if (!armor.CallTryPickup (Owner))
			{
				armor.Destroy ();
				return false;
			}
			else
			{
				return true;
			}
		}
	}

	
}
