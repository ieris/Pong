package screens
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class Singleplayer extends Sprite
	{			
		//Here we have all the game images
		private var gameBG:Image;
		private var player:Image;
		private var pc:Image;
		private var ball:Image;
		
		//Here we have all of the player properties
		private var playerSpeed:int = 4;
		private var player_velocity:int = 0;
		public var playerScore:int = 0;
		
		//Here we have all of the PC properties
		private var pcSpeed:int = 2;
		private var pc_velocity:int = 0;
		public var pcScore:int = 0;
		
		//Here we have all of the ball properties
		private var ballSpeedX:int = -6;
		private var ballSpeedY:int = -4;
		private var ball_xVelocity:int = -ballSpeedX;
		private var ball_yVelocity:int = ballSpeedY;
		
		//Here are the score variables
		public var playerTxt:TextField;
		public var pcTxt:TextField;
		
		//Here are the keyboard properties, to see when the ball should be released
		private var space:Boolean = true;
		
		private var mainMenuButton:Button;
		
		//Here we initialize all of the event listeners
		public function Singleplayer()
		{
			super();						
			
			//Add all of the event listeners here		
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(Event.ENTER_FRAME, collision);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		
		//Draw assets function
		public function drawGame():void
		{		
			player = new Image(Assets.getTexture("PlayerOne"));
			player.x = player.width;
			player.y = 200;
			this.addChild(player);
			
			pc = new Image(Assets.getTexture("PlayerTwo"));
			pc.x = stage.stageWidth - (2*pc.width);
			pc.y = stage.stageHeight/2;
			this.addChild(pc);
			
			ball = new Image(Assets.getTexture("Ball"));
			ball.x = stage.stageWidth/2;
			ball.y = stage.stageHeight/2;
			this.addChild(ball);
			
			//This is where we have our scores
			//playerTxt.text = String(playerTxt);
			//pcTxt.text = String(pcTxt);
			
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0xFF0000;
			format.size = 10;
			
			mainMenuButton = new Button(Assets.getTexture("MainMenuButton"));
			mainMenuButton.x = stage.stageWidth/2 - mainMenuButton.width/2;
			mainMenuButton.y = 20;
			mainMenuButton.downState = Assets.getTexture("MainMenuButton");
			this.addChild(mainMenuButton);
			this.addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
		//Get data to send to the server and leaderboard
		public function getPaddleYPosition():int
		{
			return player.y;
		}
		
		public function getPlayerScore():int
		{
			return playerScore;
		}
		
		public function getPCScore():int
		{
			return pcScore;
		}
		
		
		//Collision function for the paddle and ball (including singleplayer for now ---------!!!!)
		private function collision(event:Event):void
		{			
			//Restricting the pc from moving beyond the screen
			if(pc.y <= 0)
			{
				pc.y = 0;
			}
			else if(pc.y >= stage.stageHeight - pc.height)
			{
				pc.y = stage.stageHeight - pc.height;
			}
			
			//Restricting the player from moving beyond the screen
			if(player.y >= stage.stageHeight - player.height)
			{
				player.y = stage.stageHeight - player.height;
			}
			else if(player.y <= 0)
			{
				player.y = 0;
			}
			
			//COLLISION
			
			//Ball collision with the edge of the screen
			// >
			if (ball.x + ball.width >= stage.stageWidth)
			{
				if(playerScore < 2)
				{
					ball_xVelocity *= -1;
					playerScore += 1;
					space = false;
					trace("player : " + playerScore);
					resetBall();
				}
				else
				{
					gameOver();
				}
			}
				// <
			else if (ball.x <= 0)
			{
				if(pcScore < 2)
				{
					ball_xVelocity *= -1;
					pcScore += 1;
					trace("pc : " + pcScore);
					space = false;
					resetBall();
				}
				else
				{
					gameOver();								
				}
			}
				// ^
			else if (ball.y <= 0)
			{
				ball_yVelocity *= -1;
			}
				// v
			else if (ball.y + ball.height + ball.height >= stage.stageHeight)
			{
				ball_yVelocity *= -1;
			}
				
				//Ball collision with the pc paddles
			else if ((ball.x + ball.width >= pc.x && ball.y >= pc.y && ball.y + ball.height <= pc.y + pc.height))
			{
				ball_xVelocity *= -1;
			}
				//Ball collision with the player paddles
			else if ((ball.x <= player.x + player.width && ball.y >= player.y && ball.y + ball.height <= player.y + player.height))
			{
				ball_xVelocity *= -1;
			}
		}
		
		//Function to call events every second
		private function onEnterFrame(event:Event):void
		{
			
			//Moving the player
			player.y += player_velocity;	
			
			//Moving the pc around the screen
			if(pc.y + pc.height/2 < ball.y + ball.height/2)
			{
				pc_velocity = pcSpeed;
			}
			else
			{
				pc_velocity = -pcSpeed;
			}
			
			pc.y += pc_velocity;
			
			//Moving the ball around the scene
			releaseBall();				
		}
		
		//Keyboard events
		private function onKeyPress(event:KeyboardEvent):void
		{
			//Then we listen out for keyboard commands and move the paddle accordingly
			if(event.keyCode == Keyboard.W || event.keyCode == Keyboard.UP)
			{
				player_velocity = -playerSpeed;
			}
			else if(event.keyCode == Keyboard.S || event.keyCode == Keyboard.DOWN)
			{
				player_velocity = playerSpeed;
			}
			else if(event.keyCode == Keyboard.SPACE)
			{
				space = true;
				releaseBall();
			}
		}
		
		//When keys are released the player stops moving
		private function onKeyRelease(event:KeyboardEvent):void 
		{
			if(event.keyCode == Keyboard.W || event.keyCode == Keyboard.S || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN)
			{
				player_velocity = 0;
			}
		}
		
		//Reset the ball when score is collided with vertical wall
		private function resetBall():void
		{
			ball.x = stage.stageWidth/2;
			ball.y = stage.stageHeight/2;
			pc.x = stage.stageWidth - (2*pc.width);
			pc.y = stage.stageHeight/2;
			player.x = player.width;
			player.y = stage.stageHeight/2;
		}
		
		private function gameOver():void
		{
			resetBall();
			pcScore = 0;
			playerScore = 0;
			ball.visible = false;
			player.visible = false;
			pc.visible = false;
			
			this.removeEventListener(Event.ENTER_FRAME, gameOver);
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this.removeEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "game over"}, true));
		}
		
		//When space is pressed the ball is released
		private function releaseBall():void
		{
			if (space == true)
			{
				ball.x -= ball_xVelocity;
				ball.y -= ball_yVelocity;
			}
		}
		
		//Dispose function
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		//Initialize function
		public function initialize():void
		{
			this.visible = true;
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
	}
}