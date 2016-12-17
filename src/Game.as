package
{
	//Screens, onChange screen cases 'play'
	import events.NavigationEvent;
	
	import screens.Leaderboard;
	import screens.Multiplayer;
	import screens.Server;
	import screens.Singleplayer;
	import screens.Welcome;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var screenWelcome:Welcome;
		private var screenMultiplayer:Multiplayer;
		private var screenSingleplayer:Singleplayer;
		private var screenTwoPlayer:Server;
		private var screenLeaderboard:Leaderboard;
		
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
			screenTwoPlayer = new Server();
			screenLeaderboard = new Leaderboard();			
			screenWelcome = new Welcome;
			
			this.addChild(screenWelcome);
			screenWelcome.initialize();

			//	Starling.multitouchEnabled = true;		
			//	mStarling = new Starling(Game, stage);
			//	mStarling.simulateMultitouch = true;
			
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{		
				case "multiplayer":
					this.removeChild(screenWelcome);
					this.addChild(screenMultiplayer);
					break;
				case "singlePlayer":
					this.removeChild(screenWelcome);
					this.addChild(screenSingleplayer);
					break;
				case "leaderboard":
					this.removeChild(screenWelcome);
					this.addChild(screenLeaderboard);
					break;
				/*	case "gameOver":
				screenInGame.disposeTemporarily();
				screenWelcome.disposeTemporarily();
				screenGameOver.initialize();
				break; */
			}
		}
	}
}
