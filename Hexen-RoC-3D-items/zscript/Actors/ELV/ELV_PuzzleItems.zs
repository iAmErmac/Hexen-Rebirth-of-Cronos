// Yorick's Skull -----------------------------------------------------------

class CPuzzSkull : PuzzleItem replaces PuzzSkull
{
	Default
	{
		PuzzleItem.Number 0;
		Inventory.Icon "ARTISKLL";
		Inventory.PickupMessage "$TXT_ARTIPUZZSKULL";
		Tag "$TAG_ARTIPUZZSKULL";
	}
	States
	{
	Spawn:
		WSTS A -1;
		Stop;
	}
}

class CPuzzBook1 : PuzzleItem replaces PuzzBook1
{
	Default
	{
		PuzzleItem.Number 7;
		Inventory.Icon "ARTIBOK1";
		Inventory.PickupMessage "$TXT_ARTIPUZZBOOK1";
		Tag "$TAG_ARTIPUZZBOOK1";
	}
	States
	{
	Spawn:
		PBK1 A -1;
		Stop;
	}
}


// Book 2 (Liber Oscura) ----------------------------------------------------

class CPuzzBook2 : PuzzleItem replaces PuzzBook2
{
	Default
	{
		PuzzleItem.Number 8;
		Inventory.Icon "ARTIBOK2";
		Inventory.PickupMessage "$TXT_ARTIPUZZBOOK2";
		Tag "$TAG_ARTIPUZZBOOK2";
	}
	States
	{
	Spawn:
		PBK2 A -1;
		
		Stop;
	}
}

class FlameMask : PuzzleItem replaces PuzzFlameMask
{
	Default
	{
		PuzzleItem.Number 9;
		Inventory.Icon "ARTISKL2";
		Inventory.PickupMessage "$TXT_ARTIPUZZSKULL2";
		Tag "$TAG_ARTIPUZZSKULL2";
	}
	States
	{
	Spawn:
		FLAM A -1;
		Stop;
	}
}

class CPuzzGear1 : PuzzleItem replaces PuzzGear1
{
	Default
	{
		PuzzleItem.Number 13;
		Inventory.Icon "ARTIGEAR";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEAR";
		Tag "$TAG_ARTIPUZZGEAR1";
	}
	States
	{
	Spawn:
		GEAR A 1;
		Loop;
	}
}


// Clock Gear 2 -------------------------------------------------------------

class CPuzzGear2 : PuzzleItem replaces PuzzGear2
{
	Default
	{
		PuzzleItem.Number 14;
		Inventory.Icon "ARTIGER2";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEAR";
		Tag "$TAG_ARTIPUZZGEAR2";
	}
	States
	{
	Spawn:
		GEAR A 1;
		Loop;
	}
}


// Clock Gear 3 -------------------------------------------------------------

class CPuzzGear3 : PuzzleItem replaces PuzzGear3
{
	Default
	{
		PuzzleItem.Number 15;
		Inventory.Icon "ARTIGER3";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEAR";
		Tag "$TAG_ARTIPUZZGEAR3";
	}
	States
	{
	Spawn:
		GEAR A 1;
		Loop;
	}
}


// Clock Gear 4 -------------------------------------------------------------

class CPuzzGear4 : PuzzleItem replaces PuzzGear4
{
	Default
	{
		PuzzleItem.Number 16;
		Inventory.Icon "ARTIGER4";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEAR";
		Tag "$TAG_ARTIPUZZGEAR4";
	}
	States
	{
	Spawn:
		GEAR A 1;
		Loop;
	}
}

class CPuzzGemBig : PuzzleItem replaces PuzzGemBig
{
	Default
	{
		PuzzleItem.Number 1;
		Inventory.Icon "ARTIBGEM";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEMBIG";
		Tag "$TAG_ARTIPUZZGEMBIG";
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		GEMS A -1;
		Stop;
	}
}

// Red Gem (Ruby Planet) ----------------------------------------------------

class CPuzzGemRed : PuzzleItem  replaces PuzzGemRed
{
	Default
	{
		PuzzleItem.Number 2;
		Inventory.Icon "ARTIGEMR";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEMRED";
		Tag "$TAG_ARTIPUZZGEMRED";
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		GEMS A -1;
		Stop;
	}
}


// Green Gem 1 (Emerald Planet) ---------------------------------------------

class CPuzzGemGreen1 : PuzzleItem replaces PuzzGemGreen1
{
	Default
	{
		PuzzleItem.Number 3;
		Inventory.Icon "ARTIGEMG";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEMGREEN1";
		Tag "$TAG_ARTIPUZZGEMGREEN1";
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		GEMS A -1;
		Stop;
	}
}


// Green Gem 2 (Emerald Planet) ---------------------------------------------

class CPuzzGemGreen2 : PuzzleItem replaces PuzzGemGreen2
{
	Default
	{
		PuzzleItem.Number 4;
		Inventory.Icon "ARTIGMG2";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEMGREEN2";
		Tag "$TAG_ARTIPUZZGEMGREEN2";
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		GEMS A -1;
		Stop;
	}
}


// Blue Gem 1 (Sapphire Planet) ---------------------------------------------

class CPuzzGemBlue1 : PuzzleItem replaces PuzzGemBlue1
{
	Default
	{
		PuzzleItem.Number 5;
		Inventory.Icon "ARTIGEMB";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEMBLUE1";
		Tag "$TAG_ARTIPUZZGEMBLUE1";
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		GEMS A -1;
		Stop;
	}
}


// Blue Gem 2 (Sapphire Planet) ---------------------------------------------

class CPuzzGemBlue2 : PuzzleItem replaces PuzzGemBlue2
{
	Default
	{
		PuzzleItem.Number 6;
		Inventory.Icon "ARTIGMB2";
		Inventory.PickupMessage "$TXT_ARTIPUZZGEMBLUE2";
		Tag "$TAG_ARTIPUZZGEMBLUE2";
		Renderstyle "Add";
	}
	States
	{
	Spawn:
		GEMS A -1;
		Stop;
	}
}

// Fighter Weapon (Glaive Seal) ---------------------------------------------

class CPuzzFWeapon : PuzzleItem replaces PuzzFWeapon
{
	Default
	{
		PuzzleItem.Number 10;
		Inventory.Icon "ARTIFWEP";
		Inventory.PickupMessage "$TXT_ARTIPUZZFWEAPON";
		Tag "$TAG_ARTIPUZZFWEAPON";
	}
	States
	{
	Spawn:
		TWPS A -1;
		Stop;
	}
}


// Cleric Weapon (Holy Relic) -----------------------------------------------

class CPuzzCWeapon : PuzzleItem replaces PuzzCWeapon
{
	Default
	{
		PuzzleItem.Number 11;
		Inventory.Icon "ARTICWEP";
		Inventory.PickupMessage "$TXT_ARTIPUZZCWEAPON";
		Tag "$TAG_ARTIPUZZCWEAPON";
	}
	States
	{
	Spawn:
		TWPS A -1;
		Stop;
	}
}


// Mage Weapon (Sigil of the Magus) -----------------------------------------

class CPuzzMWeapon : PuzzleItem replaces PuzzMWeapon
{
	Default
	{
		PuzzleItem.Number 12;
		Inventory.Icon "ARTIMWEP";
		Inventory.PickupMessage "$TXT_ARTIPUZZMWEAPON";
		Tag "$TAG_ARTIPUZZMWEAPON";
	}
	States
	{
	Spawn:
		TWPS A -1;
		Stop;
	}
}