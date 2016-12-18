package screens
{
	import events.NavigationEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	
	public class Gameover extends Sprite
	{
		private var gameOverImage:Image;
		private var mainMenuButton:Button;
		
		public function Gameover()
		{
			super();			
			trace("game over screen");
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
		private function onAddedToStage():void
		{	
			drawScene();
			this.addEventListener(Event.TRIGGERED, onButtonClick);		
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		private function drawScene():void
		{
			gameOverImage = new Image(Assets.getTexture("GameOver"));
			gameOverImage.x = stage.stageWidth/2 - gameOverImage.width/2;
			gameOverImage.y = 200;
			gameOverImage.visible = true;
			this.addChild(gameOverImage);
			
			mainMenuButton = new Button(Assets.getTexture("MainMenuButton"));
			mainMenuButton.x = stage.stageWidth/2 - mainMenuButton.width/2;
			mainMenuButton.y = stage.stageHeight/2;
			mainMenuButton.downState = Assets.getTexture("MainMenuButton");
			mainMenuButton.visible = true;
			this.addChild(mainMenuButton);
			
			trace("gameOver");
		}
		public function onButtonClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if ((buttonClicked as Button == mainMenuButton))
			{
				trace("pressed main menu button");
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
				this.removeEventListener(Event.TRIGGERED, onButtonClick);		
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