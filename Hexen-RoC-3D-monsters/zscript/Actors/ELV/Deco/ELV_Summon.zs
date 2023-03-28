class CArtiDarkServant : Inventory replaces ArtiDarkServant
{
	Default
	{
		+COUNTITEM
		+FLOATBOB
		Inventory.RespawnTics 4230;
		Inventory.DefMaxAmount;
		Inventory.PickupFlash "PickupFlash";
		+INVENTORY.INVBAR 
		+INVENTORY.FANCYPICKUPSOUND
		Inventory.Icon "ARTISUMN";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$TXT_ARTISUMMON";
		Tag "$TAG_ARTISUMMON";
	}
	States
	{
	Spawn:
		MLTA A 350;
		Loop;
	}
	
	//============================================================================
	//
	// Activate the summoning artifact
	//
	//============================================================================

	override bool Use (bool pickup)
	{
		Actor mo = Owner.SpawnPlayerMissile ("CSummoningDoll");
		if (mo)
		{
			mo.target = Owner;
			mo.tracer = Owner;
			mo.Vel.Z = 5;
		}
		return true;
	}

	
}

// Summoning Doll -----------------------------------------------------------

class CSummoningDoll : Actor replaces SummoningDoll
{
	Default
	{
		Speed 20;
		+NOBLOCKMAP +DROPOFF +MISSILE
		+NOTELEPORT
	}

	States
	{
	Spawn:
		MLTA A 4;
		Loop;
	Death:
		MLTA AA 4;
		MLTA A 4 A_Summon;
		Stop;
	}
	
	//============================================================================
	//
	// A_Summon
	//
	//============================================================================

	void A_Summon()
	{
		Actor mo = Spawn("CMinotaurFriend", pos, ALLOW_REPLACE);
		if (mo)
		{
			if (mo.TestMobjLocation() == false || !tracer)
			{ // Didn't fit - change back to artifact
				mo.Destroy();
				Actor arti = Spawn("CArtiDarkServant", Pos, ALLOW_REPLACE);
				if (arti) arti.bDropped = true;
				return;
			}

			// Careful! The Minotaur might have been replaced 
			// so only set the time if we got a genuine one.
			CMinotaurFriend m = CMinotaurFriend(mo);
			if (m) m.StartTime = level.maptime;
			
			if (tracer.bCorpse)
			{	// Master dead
				mo.tracer = null;		// No master
			}
			else
			{
				mo.tracer = tracer;		// Pointer to master
				Inventory power = Inventory(Spawn("PowerMinotaur"));
				power.CallTryPickup(tracer);
				mo.SetFriendPlayer(tracer.player);
			}

			// Make smoke puff
			Spawn("MinotaurSmoke", Pos, ALLOW_REPLACE);
			A_StartSound(mo.ActiveSound, CHAN_VOICE);
		}
	}
	
}