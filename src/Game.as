package
{
	//We beging by creating the screens we will use for the game
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
			
			//Creating an instance of each screen
			screenMultiplayer = new Multiplayer();
			screenSingleplayer = new Singleplayer();
			screenOptions = new Options();
			screenLeaderboard = new Leaderboard();			
			screenWelcome = new Welcome();
			screenGameover = new Gameover();
			
			//First screen added is the welcome screen
			this.addChild(screenWelcome);
			screenWelcome.initialize();			
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			//These are the various cases where the Observer will decide
			//which screen to display and which to remove
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
					this.removeChild(screenOptions);
					this.removeChild(screenMultiplayer);
					this.removeChild(screenSingleplayer);
					this.removeChild(screenGameover);
					screenLeaderboard = new Leaderboard();
					this.addChild(screenLeaderboard);
					break;
				case "options":
					this.removeChild(screenWelcome);
					this.removeChild(screenOptions);
					this.removeChild(screenLeaderboard);
					this.removeChild(screenMultiplayer);
					this.removeChild(screenSingleplayer);
					this.removeChild(screenGameover);
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
