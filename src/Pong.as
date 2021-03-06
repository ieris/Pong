package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", backgroundColor="#006666")]
	public class Pong extends Sprite
	{
		
		private var stats:Stats;
		public static var myStarling:Starling;
		
		public function Pong()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		private function onAddedToStage(event:Event):void
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.SHOW_ALL;
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			
			
			myStarling = new Starling(Game, stage, new Rectangle(0,0, screenWidth, screenHeight));
			myStarling.start();
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stats = new Stats();
			//this.addChild(stats);
			
			
			myStarling.antiAliasing =1;
			
		}
		
	}
}