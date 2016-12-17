package
{
	//Screens, onChange screen cases 'play'
	import events.NavigationEvent;		
	import screens.OnePlayer;
	//import screens.TwoPlayer;
	import screens.Leaderboard;
	import screens.Options;
	import screens.Welcome;
	import starling.display.Sprite;
	import starling.events.Event;
	import screens.Server;

	//import flash.events.Event;
	
	//{"Username":"Rahul","Country":"IN","Scored":8,"Conceded":2}
	
	public class Game extends Sprite
	{
		private var screenWelcome:Welcome;
		private var screenOnePlayer:OnePlayer;
		private var screenTwoPlayer:Server;
		private var screenLeaderboard:Leaderboard;
		private var screenOptions:Options;
		
		public function Game()
		{
			super();
			this.addEventListener(/*starling.events.*/Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Starling Framework initialised!");
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenOnePlayer = new OnePlayer();
			screenTwoPlayer = new Server();
			screenLeaderboard = new Leaderboard();
			screenOptions = new Options();
			//screenInGame.disposeTemporarily();
			//this.addChild(screenInGame);
			
			screenWelcome = new Welcome;
			this.addChild(screenWelcome);
			screenWelcome.initialize();
			
			
			screenLeaderboard = new Leaderboard;
			this.addChild(screenLeaderboard);
			//screenLeaderboard.initialize();
			
			//	Starling.multitouchEnabled = true;		
			//	mStarling = new Starling(Game, stage);
			//	mStarling.simulateMultitouch = true;
			
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{		
				case "onePlayer":
					this.removeChild(screenWelcome);
					this.addChild(screenOnePlayer);
					break;
				case "twoPlayer":
					this.removeChild(screenWelcome);
					this.addChild(screenTwoPlayer);
					break;
				case "leaderboard":
					this.removeChild(screenWelcome);
					this.addChild(screenLeaderboard);
					break;
				case "options":
					this.removeChild(screenWelcome);
					this.addChild(screenOptions);
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
