
class CHexenKey : Key
{
	Default
	{
		Radius 8;
		Height 20;
	}
}

class CKeySteel : CHexenKey replaces KeySteel
{
	Default
	{
		Inventory.Icon "KEYSLOT1";
		Inventory.PickupMessage "$TXT_KEY_STEEL";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyCave : CHexenKey replaces KeyCave
{
	Default
	{
		Inventory.Icon "KEYSLOT2";
		Inventory.PickupMessage "$TXT_KEY_CAVE";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyAxe : CHexenKey replaces KeyAxe
{
	Default
	{
		Inventory.Icon "KEYSLOT3";
		Inventory.PickupMessage "$TXT_KEY_AXE";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyFire : CHexenKey replaces KeyFire
{
	Default
	{
		Inventory.Icon "KEYSLOT4";
		Inventory.PickupMessage "$TXT_KEY_FIRE";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyEmerald : CHexenKey replaces KeyEmerald
{
	Default
	{
		Inventory.Icon "KEYSLOT5";
		Inventory.PickupMessage "$TXT_KEY_EMERALD";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyDungeon : CHexenKey replaces KeyDungeon
{
	Default
	{
		Inventory.Icon "KEYSLOT6";
		Inventory.PickupMessage "$TXT_KEY_DUNGEON";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeySilver : CHexenKey replaces KeySilver
{
	Default
	{
		Inventory.Icon "KEYSLOT7";
		Inventory.PickupMessage "$TXT_KEY_SILVER";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyRusted : CHexenKey replaces KeyRusted
{
	Default
	{
		Inventory.Icon "KEYSLOT8";
		Inventory.PickupMessage "$TXT_KEY_RUSTED";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyHorn : CHexenKey replaces KeyHorn
{
	Default
	{
		Inventory.Icon "KEYSLOT9";
		Inventory.PickupMessage "$TXT_KEY_HORN";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeySwamp : CHexenKey replaces KeySwamp
{
	Default
	{
		Inventory.Icon "KEYSLOTA";
		Inventory.PickupMessage "$TXT_KEY_SWAMP";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

class CKeyCastle : CHexenKey replaces KeyCastle
{
	Default
	{
		Inventory.Icon "KEYSLOTB";
		Inventory.PickupMessage "$TXT_KEY_CASTLE";
	}
	States
	{
	Spawn:
		KEYS A -1;
		Stop;
	}
}

