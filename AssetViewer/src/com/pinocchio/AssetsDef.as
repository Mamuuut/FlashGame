package com.pinocchio
{
	import com.assetviews.SpriteSheet;
	import com.pinocchio.BeatleHead;

	/**
	 * AssetsDef is the list of the asset definitions
	 * @author mamutdelaunay
	 */
	public class AssetsDef 
	{
		[Embed(source="sprite_sheet/player.gif")]
		private static const player:Class;
		[Embed(source="sprite_sheet/dwarf.gif")]
		private static const dwarf:Class;
		[Embed(source="sprite_sheet/snow_white.gif")]
		private static const snow_white:Class;
		[Embed(source="sprite_sheet/pick_axe.gif")]
		private static const pick_axe:Class;
		[Embed(source="sprite_sheet/fire.gif")]
		private static const fire:Class;
		[Embed(source="sprite_sheet/lava.gif")]
		private static const lava:Class;
		
		[Embed(source="texture/elevator.gif")]
		private static const elevator:Class;
		[Embed(source="texture/ground_edge.gif")]
		private static const ground_edge:Class;
		[Embed(source="texture/ground_repeat.gif")]
		private static const ground_repeat:Class;
		[Embed(source="texture/level_end.gif")]
		private static const level_end:Class;
		[Embed(source="texture/wall.gif")]
		private static const wall:Class;
		[Embed(source="texture/level_back.gif")]
		private static const level_back:Class;
		
		/* Animations */
		public static const ANIMATIONS:Object = 
		{
			/* MovieClip Animation */
			game_loader:
			{
				movieClip: new GameLoader(),
				animations: [ AnimationNames.WALK ]
			},
			game_frame:
			{
				movieClip: new Frame(),
				animations: [ AnimationNames.IDLE ]
			},
			beatle:
			{
				movieClip: new BeatleHead(),
				animations: [ AnimationNames.IDLE]
			},
			
			/* SpriteAnimation */
			pinocchio: 
			{
				spriteSheet: new SpriteSheet(
					new player(),
					[
						{ name: AnimationNames.IDLE, nbFrames: 2, widths: [28], periods: [5] },
						{ name: AnimationNames.WALK, nbFrames: 2, widths: [28], periods: [5] },
						{ name: AnimationNames.RUN, nbFrames: 2, widths: [28], periods: [2] },
						{ name: AnimationNames.JUMP, nbFrames: 1, widths: [28], periods: [1] },
						{ name: AnimationNames.DEATH, nbFrames: 10, widths: [28], periods: [5] }  
					] )
			},
			dwarf: 
			{
				spriteSheet: new SpriteSheet(
					new dwarf(),
					[
						{ name: AnimationNames.IDLE, nbFrames: 2, widths: [51], periods: [3] },
						{ name: AnimationNames.BURN, nbFrames: 4, widths: [75], periods: [3] },
						{ name: AnimationNames.DEATH, nbFrames: 11, widths: [75], periods: [3] }
					] )
			},
			snow_white: 
			{
				spriteSheet: new SpriteSheet(
					new snow_white(),
					[
						{ name: AnimationNames.IDLE, nbFrames: 2, widths: [84], periods: [10] }
					] )
			},
			pick_axe: 
			{
				spriteSheet: new SpriteSheet(
					new pick_axe(),
					[
						{ name: AnimationNames.IDLE, nbFrames: 8, widths: [32], periods: [1] }
					] )
			},
			fire: 
			{
				spriteSheet: new SpriteSheet(
					new fire(),
					[
						{ name: AnimationNames.IDLE, nbFrames: 8, widths: [32, 36, 46, 47, 48, 53, 53, 53], periods: [2] },
						{ name: AnimationNames.DEATH, nbFrames: 5, widths: [56], periods: [2] }
					] )
			},
			lava: 
			{
				spriteSheet: new SpriteSheet(
					new lava(),
					[
						{ name: AnimationNames.IDLE, nbFrames: 6, widths: [80], periods: [5] }
					] ),
				repeat: true
			}
		};
		
		/* Sprites */
		public static const SPRITES:Object = 
		{	
			/* Static Sprite */
			elevator:
			{
				source: new elevator(),
				repeat: true
			},
			ground_edge:
			{
				source: new ground_edge(),
				repeat: true
			},
			ground_repeat:
			{
				source: new ground_repeat(),
				repeat: true
			},
			level_end:
			{
				source: new level_end()
			},
			wall:
			{
				source: new wall(),
				repeat: true
			},
			level_back:
			{
				source: new level_back(),
				repeat: true
			}
		};
	}
}