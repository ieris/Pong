package screens
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.events.KeyboardEvent;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	public class OnePlayer extends Sprite
	{	
		//Here we have all the images
		private var sceneBackground:Image;
		private var player:Image;
		private var pc:Image;
		private var ball:Image;
		
		private var timer:Number = 0;
		private var counter:Number = 1;
		
		//Screen variables
		//private var half_Stage_Height:Number = (stage.stageHeight)/2;
		//private var half_Stage_Width:Number = stage.stageWidth/2;
		
		//Here we have all of the player properties
		private var playerSpeed:int = 4;
		private var player_velocity:int = 0;
		public var playerScore:int = 0;
		//private var half_Player_Height:Number = player.height/2;
		//private var half_Player_Width:Number = player.width/2;
		
		
		//Here we have all of the PC properties
		private var pcSpeed:int = 4;
		private var pc_velocity:int = 0;
		public var pcScore:int = 0;
		//private var half_PC_Height:Number = pc.height/2;
		//private var half_PC_Width:Number = pc.width/2;
		
		//Here we have all of the ball properties
		private var ballSpeedX:int = -3;
		private var ballSpeedY:int = -2;
		private var ball_xVelocity:int = -ballSpeedX;
		private var ball_yVelocity:int = ballSpeedY;
		//private var half_Ball_Height:Number = ball.height/2;
		//private var half_Ball_Width:Number = ball.width/2;
		
		//Here are the score variables
		public var playerTxt:TextField;
		public var pcTxt:TextField;
		
		//Here we initialize all of the event listeners
		public function OnePlayer()
		{
			super();			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		
		//Game over function		
		private function gameOver():void
		{
			this.removeEventListener(Event.ENTER_FRAME, gameOver);
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this.removeEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
			
			trace("Game Over");
			
			//this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "game over"}, true));
		}
		
		//Draw assets function
		private function drawGame():void
		{				
			sceneBackground = new Image(Assets.getTexture("sceneBackground"));
			sceneBackground.x = 0;
			sceneBackground.y = 0;
			this.addChild(sceneBackground);
			
			player = new Image(Assets.getTexture("playerOne"));
			player.x = 0;
			player.y = 0;
			this.addChild(player);
			
			ball = new Image(Assets.getTexture("ball"));
			ball.x = 0;
			ball.y = 0;
			this.addChild(ball);
			
			//This is where we have our scores
			
			playerTxt = new TextField(10, 200, "Arial");
			playerTxt.text = String(playerTxt);
			this.addChild(playerTxt);
			
			pcTxt = new TextField(10, 200, "Arial");
			pcTxt.text = String(pcTxt);
			this.addChild(pcTxt);
			
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0xFF0000;
			format.size = 10;
		}
		
		private function onEnterFrame(event:Event):void
		{
			//Moving the player
			player.y += player_velocity;
			
			//Restricting the player from moving beyond the screen
			if(player.y - player.height/2 <= 0)
			{
				player.y = player.height/2;
			}
			else if(player.y + player.height/2 >= stage.stageHeight)
			{
				player.y = stage.stageHeight - player.height/2;
			}
			
			//Moving the pc around the screen
			if(pc.y + pc.height/2  < ball.y)
			{
				pc_velocity = -pcSpeed;
			}
			else
			{
				pc_velocity = pcSpeed;
			}
			
			pc.y += pc_velocity;
			
			//Restricting the pc from moving beyond the screen
			if(pc.y - pc.height/2 <= 0)
			{
				pc.y = pc.height/2;
			}
			else if(pc.y + pc.height/2 >= stage.stageHeight)
			{
				pc.y = stage.stageHeight - pc.height/2;
			}
			
			//Moving the ball around the scene
			ball.x += ball_xVelocity;
			ball.y += ball_yVelocity;
			
			//COLLISION
			
			//Collision between player and ball
			if (ball.x - ball.width/2 <= player.x + player.height/2)
			{
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
				//Collision between pc and ball
			else if (ball.x + ball.width/2 >= pc.x + player.width/2)
			{
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
				//Collision between ball and vertical walls
			else if(ball.x - ball.width/2 <= 0)
			{
				pcScore += 1;
				pcTxt.text = String(pcScore);
				resetGame();
			}
			else if (ball.x + ball.width/2 >= stage.stageWidth)
			{
				playerScore += 1;
				playerTxt.text = String(playerScore);
				resetGame();
			}
				//Collision between ball and horizontal walls
			else if(ball.y - ball.height/2 <= 0)
			{
				//Rebound ball from top wall
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
			else if (ball.y + ball.height/2 >= stage.stageHeight)
			{
				//Rebound ball from bottom wall
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
		}
		
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
				releaseBall_Player();
			}
		}
		
		private function onKeyRelease(event:KeyboardEvent):void 
		{
			if(event.keyCode == Keyboard.W || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.S || event.keyCode == Keyboard.DOWN)
			{
				player_velocity = 0;
			}
		}
		
		private function releaseBall_Player():void
		{
			ball_xVelocity = playerSpeed;
			ball_yVelocity = playerSpeed;
		}
		
		private function releaseBall_PC():void
		{
			ball_xVelocity = -playerSpeed;
			ball_yVelocity = -playerSpeed;
		}
		
		private function resetGame():void
		{
			pc.y = (stage.stageHeight)/2;
			player.y = (stage.stageHeight)/2;
			ball.x = (stage.stageWidth)/2;
			ball.y = (stage.stageHeight)/2;
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
	}
}