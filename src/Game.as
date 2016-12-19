package
{
	//Screens, onChange screen cases 'play'
	import events.NavigationEvent;
	
	import screens.Gameover;
	import screens.Leaderboard;
	import screens.Multiplayer;
	import screens.Options;
	import screens.Singleplayer;
	import screens.Welcome;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var screenWelcome:Welcome;
		private var screenMultiplayer:Multiplayer;
		private var screenSingleplayer:Singleplayer;
		private var screenLeaderboard:Leaderboard;
		private var screenOptions:Options;
		private var screenGameover:Gameover;
		
		public function Game()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Starling Framework initialised!");
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenMultiplayer = new Multiplayer();
			screenSingleplayer = new Singleplayer();
			screenOptions = new Options();
			screenLeaderboard = new Leaderboard();			
			screenWelcome = new Welcome();
			screenGameover = new Gameover();
			
			this.addChild(screenWelcome);
			screenWelcome.initialize();			
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{		
				case "multiplayer":
					this.removeChild(screenWelcome);
					this.removeChild(screenLeaderboard);
					this.removeChild(screenOptions);
					screenMultiplayer = new Multiplayer();
					this.addChild(screenMultiplayer);
					break;
				case "singleplayer":
					this.removeChild(screenWelcome);	
					this.removeChild(screenMultiplayer);
					this.removeChild(screenLeaderboard);
					this.removeChild(screenOptions);
					screenSingleplayer = new Singleplayer();
					this.addChild(screenSingleplayer);
					break;
				case "leaderboard":
					this.removeChild(screenWelcome);
					screenLeaderboard = new Leaderboard();
					this.addChild(screenLeaderboard);
					break;
				case "options":
					this.removeChild(screenWelcome);
					this.removeChild(screenOptions);
					screenOptions = new Options();
					this.addChild(screenOptions);
					break;
				case "welcome":
					this.removeChild(screenLeaderboard);
					this.removeChild(screenMultiplayer);
					this.removeChild(screenSingleplayer);
					this.removeChild(screenGameover);
					this.removeChild(screenOptions);
					screenWelcome = new Welcome();
					this.addChild(screenWelcome);
					break;
				case "game over":
					trace("case game over");
					this.removeChild(screenLeaderboard);
					this.removeChild(screenMultiplayer);
					this.removeChild(screenSingleplayer);
					this.removeChild(screenOptions);
					this.removeChild(screenWelcome);
					screenGameover = new Gameover();
					this.addChild(screenGameover);
				break;
			}
		}
	}
}
