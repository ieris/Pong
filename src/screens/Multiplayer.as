package screens
{
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class Multiplayer extends Sprite
	{	
		//Leaderboard variables
		private var loader:URLLoader;		
		
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
		private var pcSpeed:int = 2.5;
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
		
		public var welcome:Welcome = new Welcome();
		public var userName:TextField = new TextField();
		private var country:TextField = new TextField();
		private var finalScore:int;
		private var concededScore:int;
		
		//Here we initialize all of the event listeners
		public function Multiplayer()
		{
			super();		
			//Create a loader for the leaderboard
			loader = new URLLoader();
			//configureListeners(loader);			
			
			//Add all of the event listeners here		
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(Event.ENTER_FRAME, collision);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		
		//Game over function
		
		//Dispatch events instead of using function ------------------------------------------------------------------------------------!!!!
		public function gameOver():void
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
		public function drawGame():void
		{		
			trace(" getPlayerName: " + welcome.getPlayerName().text);
					
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
					resetGame();
					resetBall();
					//gameover
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
					resetGame();
					sendData();
					//game over
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
		
		//dipatch event reset game / game over
		private function resetGame():void
		{
			resetBall();
			pcScore = 0;
			playerScore = 0;
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
		
		//Send data to the leaderboard
		//Include variables
		private function sendData()
		{
			trace("sending score");
			userName = welcome.getPlayerName();
			country.text = "GB";
			var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = "http://andrew.coventry.domains/parseData?data={%22Username%22:%22 " + userName.text + "%22,%22Country%22:%22" + country.text  + "%22,%22Scored%22:" + playerScore + ",%22Conceded%22:" + pcScore + "}";
			var urlRequest:URLRequest = new URLRequest(url);	
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(header);
			
			try
			{
				trace("data was successully sent");
				loader.load(urlRequest);
			}
			catch(error:Error)
			{
				trace("Unable to load the data from the leaderboard");
			}
		}
		
		//Get data from the leaderboard
		private function getData()
		{
			var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = "http://andrew.coventry.domains//returnAll";
			var urlRequest:URLRequest = new URLRequest(url);	
			urlRequest.method = URLRequestMethod.GET;
			urlRequest.requestHeaders.push(header);
			
			try
			{
				loader.load(urlRequest);
			}
			catch(error:Error)
			{
				trace("Unable to load the data from the leaderboard");
			}
		}
		
		//Delete data from the leaderboard
		private function deleteData()
		{
			var header:URLRequestHeader = new URLRequestHeader("token", "$/>?&ReqEQjs7ih");
			var url:String = "http://andrew.coventry.domains/removeData?query=id=20";
			var urlRequest:URLRequest = new URLRequest(url);	
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(header);
			
			try
			{
				loader.load(urlRequest);
			}
			catch(error:Error)
			{
				trace("Unable to load the data from the leaderboard");
			}
		}
		
		//Leaderboard listeners
		/*private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, complete);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function complete(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			trace("completeHandler: " + loader.data);
		}
		
		private function openHandler(event:Event):void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}*/
	}
}