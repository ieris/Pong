package screens
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
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
		static var half_Stage_Height = stage.stageHeight/2;
		static var half_Stage_Width = stage.stageWidth/2;
		
		//Here we have all of the player properties
		private var playerSpeed:Number = 4;
		private var player_velocity = 0;
		public var playerScore:int = 0;
		static var half_Player_Height = player.height/2;
		static var half_Player_Width = player.width/2;
		
		
		//Here we have all of the PC properties
		private var pcSpeed:Number = 4;
		private var pc_velocity = 0;
		public var pcScore:int = 0;
		static var half_PC_Height = pc.height/2;
		static var half_PC_Width = pc.width/2;
		
		//Here we have all of the ball properties
		private var ballSpeedX:int = -3;
		private var ballSpeedY:int = -2;
		private var ball_xVelocity = -ballSppeed;
		private var ball_yVelocity = ballSppeed;
		static var half_Ball_Height = ball.height/2;
		static var half_Ball_Width = ball.width/2;
		
		//Here are the score variables
		public var txt:TextField;
		
		//Here we initialize all of the event listeners
		public function OnePlayer()
		{
			super();			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		
		//Game over function		
		private function gameOver():void
		{
			this.removeEventListener(Event.ENTER_FRAME, gameOver);
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
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
			this.addEventListener(Event.ENTER_FRAME, playerMove);
			
			ball = new Image(Assets.getTexture("ball"));
			ball.x = 0;
			ball.y = 0;
			this.addChild(ball);
			this.addEventListener(Event.ENTER_FRAME, ballMove);
			
			//This is where we have our scores
			
			playerScoreText = new TextField(10, 200, "Arial");
			playerScoreText.text = (playerScoreText);
			this.addChild(playerScoreText);
			
			pcScoreText = new TextField(10, 200, "Arial");
			pcScoreText.text = String(pcScoreText);
			this.addChild(pcScoreText);
			
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
			if(player.y - half_Player_Height <= 0)
			{
				player.y = half_Player_Height;
			}
			else if(player.y + half_Player_Height >= stage.stageHeight)
			{
				player.y = stage.stageHeight - half_Player_Height;
			}
			
			//Moving the pc around the screen
			if(pc.y half_PC_Height +  < ball.y)
			{
				pcVelocity = -ballSpeed;
			}
			else
			{
				pcVelocity = ballSpeed;
			}
			
			pc.y += pcVelocity;
			
			//Restricting the pc from moving beyond the screen
			if(pc.y - half_PC_Height <= 0)
			{
				pc.y = half_PC_Height;
			}
			else if(pc.y + half_PC_Height >= stage.stageHeight)
			{
				pc.y = stage.stageHeight - half_PC_Height;
			}
			
			//Moving the ball around the scene
			ball.x += ball_xVelocity;
			ball.y += ball_yVelocity;
			
			//COLLISION
			
			//Collision between player and ball
			if (ball.x - half_Ball_Width <= player.x + half_Player_Width)
			{
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
				//Collision between pc and ball
			else if (ball.x + half_Ball_Width >= pc.x + half_PC_Width)
			{
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
				//Collision between ball and vertical walls
			else if(ball.x - half_Ball_Width <= 0)
			{
				pcScore += 1;
				pcScoreText.text = String(pcScore);
				resetGame();
			}
			else if (ball.x + half_Ball_Width >= stage.stageWidth)
			{
				playerScore += 1;
				playerScoreText.text = String(playerScore);
				resetGame();
			}
				//Collision between ball and horizontal walls
			else if(ball.y - half_Ball_Height <= 0)
			{
				//Rebound ball from top wall
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
			else if (ball.y + half_Ball_Height >= stage.stageHeight)
			{
				//Rebound ball from bottom wall
				ball_xVelocity *= -1;
				ball_yVelocity *= -1;
			}
		}
		
		private function onKeyPress(event:KeyboardEvent):void
		{
			//Then we listen out for keyboard commands and move the paddle accordingly
			if(event.Keycode == Keyboard.W || event.Keycode == Keyboard.UP)
			{
				playerVelocity = -playerSpeed;
			}
			else if(event.Keycode == Keyboard.S || event.Keycode == Keyboard.DOWN)
			{
				playerVelocity = playerSpeed;
			}
			else if(event.Keycode == Keyboard.SPACE)
			{
				releaseBall();
			}
		}
		
		private function onKeyRelease(event:KeyboardEvent):void 
		{
			if(event.Keycode == Keyboard.W || event.Keycode == Keyboard.UP || event.Keycode == Keyboard.S || event.Keycode == Keyboard.DOWN)
			{
				playerVelocity = 0;
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
			pc.y = half_Stage_Height;
			player.y = half_Stage_Height;
			ball.x = half_Stage_Width;
			ball.y = half_Stage_Height;
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