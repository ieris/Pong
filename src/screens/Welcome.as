package screens
{
	import starling.display.Sprite;
	import events.NavigationEvent;	
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Button;
	
	public class Welcome extends Sprite
	{		
		private var gameLogo:Image;
		private var onePlayerButton:Button;
		private var twoPlayerButton:Button;
		private var optionsButton:Button;
		private var leaderboardButton:Button;
		
		public function Welcome()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			//this.addEventListener(Event.ENTER_FRAME, buttonClick); 	
		}
	
		private function onAddedToStage(event:Event):void
		{
			//draw the welcome screen
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawScreen();
			trace("Welcome screen initialized");
		}
		
		private function drawScreen():void
		{		
			gameLogo = new Image(Assets.getTexture("gameLogo"));
			gameLogo.x = 0;
			gameLogo.y = 0;
			this.addChild(gameLogo);

			/*onePlayerButton = new Button(Assets.getTexture("onePlayerButton"));
			onePlayerButton.x = 0;
			onePlayerButton.y = 140;
			onePlayerButton.downState = Assets.getTexture("onePlayerButton");
			this.addChild(onePlayerButton);
			this.addEventListener(Event.TRIGGERED, onButtonClick);
			
			twoPlayerButton = new Button(Assets.getTexture("twoPlayerButton"));
			twoPlayerButton.x = 0;
			twoPlayerButton.y = 140;
			twoPlayerButton.downState = Assets.getTexture("twoPlayerButton");
			this.addChild(twoPlayerButton);
			
			leaderboardButton = new Button(Assets.getTexture("leaderboardButton"));
			leaderboardButton.x = 0;
			leaderboardButton.y = 140;
			leaderboardButton.downState = Assets.getTexture("leaderboardButton");
			this.addChild(leaderboardButton);
			
			optionsButton = new Button(Assets.getTexture("optionsButton"));
			optionsButton.x = 0;
			optionsButton.y = 140;
			optionsButton.downState = Assets.getTexture("optionsButton");
			this.addChild(optionsButton);*/
		}
		
		public function onButtonClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if ((buttonClicked as Button == onePlayerButton))
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "onePlayer"}, true));
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}
			else if ((buttonClicked as Button == twoPlayerButton))
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "twoPlayer"}, true));
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}
			else if ((buttonClicked as Button == leaderboardButton))
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "leaderboard"}, true));
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}
			else if ((buttonClicked as Button == optionsButton))
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "options"}, true));
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}
		}
		
		public function initialize():void
		{
			this.visible = true;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}