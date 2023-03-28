class HereFire : Actor
{
	Default
	{
	Height 1;
	Radius 1;
	RenderStyle "Add";
	Alpha 1.0;
	+BRIGHT;
	}
	States
	{
	Spawn:
		TFLA ABCDEFGHGFEDCBA random(1,3) A_PlaySound("Torch/Burn",4,1.0,1,ATTN_STATIC);
		Stop;
	}
}