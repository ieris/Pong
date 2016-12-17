package screens
{
	import starling.display.Sprite;
	import events.NavigationEvent;	
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Button;
	
	public class Welcome extends Sprite
	{		
		private var welcomeBG:Image;
		private var ballSelector:Image;
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
			onePlayerButton = new Button(Assets.getTexture("OnePlayerButton"));
			onePlayerButton.x = stage.stageWidth/2 - onePlayerButton.width/2;
			onePlayerButton.y = stage.stageHeight/2 - onePlayerButton.height - 20;
			onePlayerButton.downState = Assets.getTexture("OnePlayerButton");
			this.addChild(onePlayerButton);
			this.addEventListener(Event.TRIGGERED, onButtonClick);
			
			twoPlayerButton = new Button(Assets.getTexture("TwoPlayerButton"));
			twoPlayerButton.x = stage.stageWidth/2 - onePlayerButton.width/2;
			twoPlayerButton.y = stage.stageHeight/2 - 10;
			twoPlayerButton.downState = Assets.getTexture("TwoPlayerButton");
			this.addChild(twoPlayerButton);
			
			leaderboardButton = new Button(Assets.getTexture("LeaderboardButton"));
			leaderboardButton.x = stage.stageWidth/2 - onePlayerButton.width/2;
			leaderboardButton.y = stage.stageHeight/2 + onePlayerButton.height;
			leaderboardButton.downState = Assets.getTexture("LeaderboardButton");
			this.addChild(leaderboardButton);
			
			optionsButton = new Button(Assets.getTexture("OptionsButton"));
			optionsButton.x = stage.stageWidth/2 - optionsButton.width/2
			optionsButton.y = stage.stageHeight/2 + (onePlayerButton.height * 2 + 10);
			optionsButton.downState = Assets.getTexture("OptionsButton");
			this.addChild(optionsButton);
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