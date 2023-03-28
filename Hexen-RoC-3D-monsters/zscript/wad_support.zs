
Class WadSupportHandler : StaticEventHandler
{
	override void CheckReplacement(ReplaceEvent e)
	{
		if(GameInfo.GameType & GAME_Doom)
		{
			if(e.Replacee is "ZombieMan") 			e.Replacement = 'CAfrit';
			if(e.Replacee is "ShotgunGuy") 			e.Replacement = random(1, 10) > 2 ? 'CAfrit' : 'CEttin';
			if(e.Replacee is "ChaingunGuy") 		e.Replacement = 'CBishop';
			if(e.Replacee is "DoomImp") 			e.Replacement = random(0, 1) > 3 ? 'CEttin' : 'CChaosSerpent';
			if(e.Replacee is "Demon") 				e.Replacement = 'CCentaur';
			if(e.Replacee is "Spectre") 			e.Replacement = 'CIceGuy';
			if(e.Replacee is "LostSoul") 			e.Replacement = 'CAfrit';
			if(e.Replacee is "Cacodemon") 			e.Replacement = 'DoubleBishopSpawner';
			if(e.Replacee is "PainElemental") 		e.Replacement = 'TrippleReiverSpawner';
			if(e.Replacee is "Revenant") 			e.Replacement = random(1, 10) > 3 ? 'CSerpent' : 'CChaosSerpent';
			if(e.Replacee is "HellKnight") 			e.Replacement = 'CCentaurLeader';
			if(e.Replacee is "BaronOfHell") 		e.Replacement = 'CentaurTeamSpawner';
			if(e.Replacee is "Arachnotron") 		e.Replacement = 'CChaosSerpent';
			if(e.Replacee is "Fatso") 				e.Replacement = 'BishopTeamSpawner';
			if(e.Replacee is "Archvile") 			e.Replacement = random(1, 10) > 1 ? 'CCentaurLeader' : 'CMaulotaur';
			if(e.Replacee is "Cyberdemon") 			e.Replacement = 'CKorax';
			if(e.Replacee is "SpiderMastermind") 	e.Replacement = 'CHeresiarch';
		}
	}
}

Class DoubleBishopSpawner : Actor
{
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_SpawnItemEx("CBishop", random(3, 8), random(3, 8), random (2, 5), random(2, -2), random(2, -2), 0.05, random(1, -1) * 90);
		TNT1 A 15;
		TNT1 A 1 A_SpawnItemEx("CBishop", random(10, 15), random(10, 15), random (2, 5), random(1, -1), random(1, -1), 0.05, random(1, -1) * 90);
		Stop;
	}
}

Class TrippleReiverSpawner : Actor
{
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_SpawnItemEx("CReiver", random(3, 8), random(3, 8), random (2, 5), random(2, -2), random(2, -2), 0.05, random(1, -1) * 90);
		TNT1 A 15;
		TNT1 A 1 A_SpawnItemEx("CReiver", random(3, 8), random(3, 8), random (2, 5), random(2, -2), random(2, -2), 0.05, random(1, -1) * 90);
		TNT1 A 16;
		TNT1 A 1 A_SpawnItemEx("CReiver", random(10, 15), random(10, 15), random (2, 5), random(1, -1), random(1, -1), 0.05, random(1, -1) * 90);
		Stop;
	}
}

Class BishopTeamSpawner : Actor
{
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_SpawnItemEx("CSerpent");
		TNT1 A 15;
		TNT1 A 1 A_SpawnItemEx("CBishop", random(-70, -80), random(-70, -80), random (2, 5), random(4, -4), random(4, -4), 0.05, random(1, -1) * 90);
		TNT1 A 16;
		TNT1 A 1 A_SpawnItemEx("CAfrit", random(70, 80), random(70, 80), 0, 0, 0, 0, random(1, -1) * 90);
		Stop;
	}
}

Class CentaurTeamSpawner : Actor
{
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_SpawnItemEx("CCentaurLeader");
		TNT1 A 15;
		TNT1 A 1 A_SpawnItemEx("CAfrit", random(70, 80), random(70, 80), 0, 0, 0, 0, random(1, -1) * 90);
		TNT1 A 16;
		TNT1 A 1 A_SpawnItemEx("CAfrit", random(-70, -80), random(-70, -80), 0, 0, 0, 0, random(1, -1) * 90);
		Stop;
	}
}