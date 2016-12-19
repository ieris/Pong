package screens
{
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Welcome extends Sprite
	{		
		
		private var gameLogo:Image;
		private var ballSelector:Image;
		private var multiplayerButton:Button;
		private var singleplayerButton:Button;
		private var logInButton:Button;
		private var optionsButton:Button;
		private var leaderboardButton:Button;
				
		public var name1Button:Button;
		public var name2Button:Button;
		public var name3Button:Button;
		static public var userName:TextField = new TextField(0, 0, "");
		private var notification:TextField = new TextField(1000, 200, "HELLO");
		public var nameSelected:int = 0;
		private var logInCount:int = 0;

		//log in variables
				
		
		public function Welcome()
		{
			super();	
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);			 	
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
			//Game logo
			
			gameLogo = new Image(Assets.getTexture("GameLogo"));
			gameLogo.x = stage.stageWidth/2 - gameLogo.width/2;
			gameLogo.y = 400;
			this.addChild(gameLogo);
			
			//Main menu buttons
			multiplayerButton = new Button(Assets.getTexture("MultiplayerButton"));
			multiplayerButton.x = stage.stageWidth/2 - multiplayerButton.width/2;
			multiplayerButton.y = stage.stageHeight/2 - multiplayerButton.height - 20;
			multiplayerButton.downState = Assets.getTexture("MultiplayerButton");
			this.addChild(multiplayerButton);			
			
			singleplayerButton = new Button(Assets.getTexture("SingleplayerButton"));
			singleplayerButton.x = stage.stageWidth/2 - multiplayerButton.width/2;
			singleplayerButton.y = stage.stageHeight/2 - 10;
			singleplayerButton.downState = Assets.getTexture("SingleplayerButton");
			this.addChild(singleplayerButton);
			
			leaderboardButton = new Button(Assets.getTexture("LeaderboardButton"));
			leaderboardButton.x = stage.stageWidth/2 - multiplayerButton.width/2;
			leaderboardButton.y = stage.stageHeight/2 + multiplayerButton.height;
			leaderboardButton.downState = Assets.getTexture("LeaderboardButton");
			this.addChild(leaderboardButton);
			
			optionsButton = new Button(Assets.getTexture("OptionsButton"));
			optionsButton.x = stage.stageWidth/2 - multiplayerButton.width/2;
			optionsButton.y = stage.stageHeight/2 + (multiplayerButton.height*2) + 10;
			optionsButton.downState = Assets.getTexture("OptionsButton");
			this.addChild(optionsButton);
			
			//Name options
			
			name1Button = new Button(Assets.getTexture("Name1"));
			name1Button.x = stage.stageWidth/2 - multiplayerButton.width/2;
			name1Button.y = stage.stageHeight/2 - multiplayerButton.height - 200;
			name1Button.downState = Assets.getTexture("Name1");
			name1Button.name = "Robert";
			name1Button.visible = true;
			
			name2Button = new Button(Assets.getTexture("Name2"));
			name2Button.x = stage.stageWidth/2 - multiplayerButton.width/2;
			name2Button.y = stage.stageHeight/2 - multiplayerButton.height -120;
			name2Button.downState = Assets.getTexture("Name2");
			name2Button.name = "Sam";
			name2Button.visible = true;
			
			name3Button = new Button(Assets.getTexture("Name3"));
			name3Button.x = stage.stageWidth/2 - multiplayerButton.width/2;
			name3Button.y = stage.stageHeight/2 - multiplayerButton.height-40;
			name3Button.downState = Assets.getTexture("Name3");
			name3Button.name = "Dolores";
			name3Button.visible = true;
			
			//Log in buttons
			
			logInButton = new Button(Assets.getTexture("LogInButton"));
			logInButton.x = stage.stageWidth/2 - multiplayerButton.width/2;
			logInButton.y = stage.stageHeight/2 + multiplayerButton.height+20;
			logInButton.downState = Assets.getTexture("LogInButton");
			logInButton.visible = true;
			
			notification.x = stage.stageWidth/2 - notification.width/2;
			notification.y = 150;
			notification.color = 0xffffff;
			notification.fontSize = 30;
			notification.text = "Choose a name and log in!";
			this.addEventListener(Event.TRIGGERED, onButtonClick);			
		}
		
		private function onButtonClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if ((buttonClicked as Button == multiplayerButton))
			{
				trace("clicked");
				this.addChild(logInButton);
	
				
				multiplayerButton.visible = false;
				singleplayerButton.visible = false;
				leaderboardButton.visible = false;
				gameLogo.visible = false;
				optionsButton.visible = false;
				
				this.addChild(notification);
				this.addChild(name1Button);
				this.addChild(name2Button);
				this.addChild(name3Button);
			}
			else if ((buttonClicked as Button == singleplayerButton))
			{
				trace("singleplayer clicked!");
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "singleplayer"}, true));
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}
			else if ((buttonClicked as Button == leaderboardButton))
			{
				trace("clicked leaderboard");
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "leaderboard"}, true));
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}
			else if ((buttonClicked as Button == optionsButton))
			{
				trace("clicked leaderboard");
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "options"}, true));
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}
			
			else if ((buttonClicked as Button == logInButton))
			{
				logInCount = 1;								
				if (nameSelected > 0 && logInCount > 0)
				{
					logIn(userName);
				}
				this.removeEventListener(Event.ENTER_FRAME, onButtonClick);
			}

			else if ((buttonClicked as Button == name1Button))
			{
				nameSelected = 1;
				userName.text = name1Button.name;
				trace("you have selected " + userName.text + " as your name");
			}
			else if ((buttonClicked as Button == name2Button))
			{
				nameSelected = 2;
				userName.text = name2Button.name;
				trace("you have selected " + userName.text + " as your name");
			}
			else if ((buttonClicked as Button == name3Button))
			{
				nameSelected = 3;
				userName.text = name3Button.name;
				trace("you have selected " + userName.text + " as your name");
			}
		}
		
		private function logIn(userName:TextField):void
		{
			trace("you have logged in as :" + userName.text);
			name1Button.visible = false;
			name2Button.visible = false;
			name3Button.visible = false;
			logInButton.visible = false;
			
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "multiplayer"}, true));
		}
		
		public function getPlayerName():TextField
		{
			return userName;
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