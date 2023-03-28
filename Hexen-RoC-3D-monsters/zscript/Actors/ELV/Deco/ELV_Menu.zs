class ClericMenu : Actor
{
	Default
	{
		+FLOORCLIP +TELESTOMP
		+DONTMORPH
		Obituary "$OB_CBOSS";
		Tag "$FN_CBOSS";
	}

	States
	{
	Spawn:
		CBTC XYZ[\] 2;
		CBTD ABCDEFGHIJKLMNOPQR 2;
		CBTD S 2;
		CBTD T 2;
		Loop;
	}
}

class FighterMenu : Actor
{
	Default
	{
		+FLOORCLIP
		+TELESTOMP
		+DONTMORPH
		Obituary "$OB_FBOSS";
		Tag "$FN_FBOSS";
	}

	States
	{
	Spawn:
		FBTC PQRSTUVWXYZ[\] 2;
		FBTD ABCDEFGHIJ 2;
		FBTD K 2; 
		FBTD L 2;
		Loop;
	}
}

class MageMenu : Actor
{
	Default
	{
		+FLOORCLIP +TELESTOMP
		+DONTMORPH
		Obituary "$OB_MBOSS";
		Tag "$FN_MBOSS";
	}

	States
	{
	Spawn:
		MGTB QRSTUVWXYZ[\] 2;
		MGTC ABCDEFGHIJK 2;
		MGTC L 2;
		MGTC M 2;
		Loop;
	}
}