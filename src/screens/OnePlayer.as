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
		private var gameBG:Image;
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
			this.addEventListener(Event.ENTER_FRAME, collision);
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
			/*gameBG = new Image(Assets.getTexture("GameBG"));
			gameBG.x = 0;
			gameBG.y = 0;
			this.addChild(gameBG);
			*/
			player = new Image(Assets.getTexture("PlayerOne"));
			player.x = player.width;
			player.y = stage.stageHeight/2;
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
			
			/*playerTxt = new TextField(10, 200, "Arial");
			playerTxt.text = String(playerTxt);
			this.addChild(playerTxt);
			
			pcTxt = new TextField(10, 200, "Arial");
			pcTxt.text = String(pcTxt);
			this.addChild(pcTxt);
			
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0xFF0000;
			format.size = 10;*/
		}
		
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
			if (ball.x + ball.width/2 >= stage.stageWidth)
			{
				ball_xVelocity *= -1;
				playerScore += 1;		
			}
			// <
			else if (ball.x + ball.width/2 <= 0)
			{
				ball_xVelocity *= -1;
				pcScore += 1;
			}
			// ^
			else if (ball.y + ball.height/2 <= 0)
			{
				ball_yVelocity *= -1;
			}
			// v
			else if (ball.y + ball.height >= stage.stageHeight)
			{
				ball_yVelocity *= -1;
			}
			
			//Ball collision with the pc paddles
			if ((ball.x + ball.width >= pc.x && ball.x <= pc.x + pc.width) && (ball.y >= pc.y && ball.y + ball.height <= pc.y - pc.height))
			{
				ball_xVelocity *= -1;
			}
			//Ball collision with the player paddles
			else if ((ball.x + ball.width/2 <= player.x + player.width && ball.x + ball.width >= player.x) && (ball.y <= player.y && ball.y >= player.y - player.height))
			{
				ball_xVelocity *= -1;
			}
		}
		
		private function onEnterFrame(event:Event):void
		{
			//Moving the player
			player.y += player_velocity;
			
			
			
			//Moving the pc around the screen
			/*if(pc.y + pc.height/2  < ball.y)
			{
				pc_velocity = -pcSpeed;
			}
			else
			{
				pc_velocity = pcSpeed;
			}
			
			pc.y += pc_velocity;
			*/
			
			
			
			//Moving the ball around the scene
			ball.x -= ball_xVelocity;
			ball.y -= ball_yVelocity;
			
			
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
			ball.x = 350;
			ball.y = 100;
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