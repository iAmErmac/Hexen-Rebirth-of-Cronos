
// Dirt clump (spawned by spike) --------------------------------------------

class CDirtClump : Actor replaces DirtClump
{
	Default
	{
		+NOBLOCKMAP
		+NOTELEPORT
	}
	States
	{
	Spawn:
		DIRT A 20;
		Loop;
	}
}

// Spike (thrust floor) -----------------------------------------------------

class CThrustFloor : Actor replaces ThrustFloor
{
	Default
	{
		Radius 20;
		Height 128;
	}

	States
	{
	ThrustRaising:
		SPIK A 2 A_ThrustRaise;
		Loop;
	BloodThrustRaising:
		SPIK B 2 A_ThrustRaise;
		Loop;
	ThrustLower:
		SPIK A 2 A_ThrustLower;
		Loop;
	BloodThrustLower:
		SPIK B 2 A_ThrustLower;
		Loop;
	ThrustInit1:
		SPIK A 3;
		SPIK A 4 A_ThrustInitDn;
		SPIK A -1;
		Loop;
	BloodThrustInit1:
		SPIK B 3;
		SPIK B 4 A_ThrustInitDn;
		SPIK B -1;
		Loop;
	ThrustInit2:
		SPIK A 3;
		SPIK A 4 A_ThrustInitUp;
		SPIK A 10;
		Loop;
	BloodThrustInit2:
		SPIK B 3;
		SPIK B 4 A_ThrustInitUp;
		SPIK B 10;
		Loop;
	ThrustRaise:
		SPIK A 8 A_ThrustRaise;
		SPIK A 6 A_ThrustRaise;
		SPIK A 4 A_ThrustRaise;
		SPIK A 3 A_SetSolid;
		SPIK A 2 A_ThrustImpale;
		Loop;
	BloodThrustRaise:
		SPIK B 8 A_ThrustRaise;
		SPIK B 6 A_ThrustRaise;
		SPIK B 4 A_ThrustRaise;
		SPIK B 3 A_SetSolid;
		SPIK B 2 A_ThrustImpale;
		Loop;
	}
	
	override void Activate (Actor activator)
	{
		if (args[0] == 0)
		{
			A_StartSound ("ThrustSpikeLower", CHAN_BODY);
			bInvisible = false;
			if (args[1])
				SetStateLabel("BloodThrustRaise");
			else
				SetStateLabel("ThrustRaise");
		}
	}

	override void Deactivate (Actor activator)
	{
		if (args[0] == 1)
		{
			A_StartSound ("ThrustSpikeRaise", CHAN_BODY);
			if (args[1])
				SetStateLabel("BloodThrustLower");
			else
				SetStateLabel("ThrustLower");
		}
	}
	
	//===========================================================================
	//
	// Thrust floor stuff
	//
	// Thrust Spike Variables
	//		master		pointer to dirt clump actor
	//		special2	speed of raise
	//		args[0]		0 = lowered,  1 = raised
	//		args[1]		0 = normal,   1 = bloody
	//===========================================================================

	void A_ThrustInitUp()
	{
		special2 = 5;	// Raise speed
		args[0] = 1;		// Mark as up
		Floorclip = 0;
		bSolid = true;
		bNoTeleport = true;
		bFloorClip = true;
		special1 = 0;
	}

	void A_ThrustInitDn()
	{
		special2 = 5;	// Raise speed
		args[0] = 0;		// Mark as down
		Floorclip = Default.Height;
		bSolid = false;
		bNoTeleport = true;
		bFloorClip = true;
		bInvisible = true;
		master = Spawn("DirtClump", Pos, ALLOW_REPLACE);
	}


	void A_ThrustRaise()
	{
		if (RaiseMobj (special2))
		{	// Reached it's target height
			args[0] = 1;
			if (args[1])
				SetStateLabel ("BloodThrustInit2", true);
			else
				SetStateLabel ("ThrustInit2", true);
		}

		// Lose the dirt clump
		if ((Floorclip < Height) && master)
		{
			master.Destroy ();
			master = null;
		}

		// Spawn some dirt
		if (random[Thrustraise]()<40)
			SpawnDirt (radius);
		special2++;							// Increase raise speed
	}

	void A_ThrustLower()
	{
		if (SinkMobj (6))
		{
			args[0] = 0;
			if (args[1])
				SetStateLabel ("BloodThrustInit1", true);
			else
				SetStateLabel ("ThrustInit1", true);
		}
	}

	
	void A_ThrustImpale()
	{
		BlockThingsIterator it = BlockThingsIterator.Create(self);
		while (it.Next())
		{
			let targ = it.thing;
			if (targ != null)
			{
				double blockdist = radius + targ.radius;
				if (abs(targ.pos.x - it.Position.X) >= blockdist || abs(targ.pos.y - it.Position.Y) >= blockdist)
					continue;

				// Q: Make this z-aware for everything? It never was before.
				if (targ.pos.z + targ.height < pos.z || targ.pos.z > pos.z + height)
				{
					if (CurSector.PortalGroup != targ.CurSector.PortalGroup)
						continue;
				}

				if (!targ.bShootable)
					continue;

				if (targ == self)
					continue;	// don't clip against self

				int newdam = targ.DamageMobj (self, self, 10001, 'Crush');
				targ.TraceBleed (newdam > 0 ? newdam : 10001, null);
				args[1] = 1;	// Mark thrust thing as bloody
			}
		}
	}
}

// Spike up -----------------------------------------------------------------

class CThrustFloorUp : CThrustFloor replaces ThrustFloorUp
{
	Default
	{
		+SOLID
		+NOTELEPORT +FLOORCLIP
	}
	States
	{
	Spawn:
		Goto ThrustInit2;
	}
}

// Spike down ---------------------------------------------------------------

class CThrustFloorDown : CThrustFloor replaces ThrustFloorDown
{
	Default
	{
		+NOTELEPORT +FLOORCLIP
		+INVISIBLE
	}
	States
	{
	Spawn:
		Goto ThrustInit1;
	}
}
