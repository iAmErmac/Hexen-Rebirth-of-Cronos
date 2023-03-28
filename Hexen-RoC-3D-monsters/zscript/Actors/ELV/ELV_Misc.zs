class CIceChunk : Actor replaces IceChunk
{
	Default
	{
		Radius 3;
		Height 4;
		Mass 5;
		Gravity 0.125;
		RenderStyle "Add";
		+DROPOFF
		+CANNOTPUSH
		+FLOORCLIP
		+NOTELEPORT
		+NOBLOCKMAP
		+MOVEWITHSECTOR
	}
	
	void A_IceSetTics ()
	{
		A_SetRoll(random(-90, 90));
		A_SetPitch(random(-30, 30));
		tics = random[IceTics](70, 133);
		Name dtype = GetFloorTerrain().DamageMOD;
		if (dtype == 'Fire')
		{
			tics >>= 2;
		}
		else if (dtype == 'Ice')
		{
			tics <<= 1;
		}
	}

	States
	{
	Spawn:
		3DMD ABCD 10 A_IceSetTics;
		Stop;
	}
}
