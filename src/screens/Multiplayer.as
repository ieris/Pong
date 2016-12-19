package screens
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.ui.Keyboard;	
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
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
		private var pcSpeed:int = 2;
		private var pc_velocity:int = 0;
		public var pcScore:int = 0;
		
		//Here we have all of the ball properties
		private var ballSpeedX:int = -6;
		private var ballSpeedY:int = -4;
		private var ball_xVelocity:int = -ballSpeedX;
		private var ball_yVelocity:int = ballSpeedY;
		
		//Here are the score variables
		static public var playerTxt:TextField = new TextField(200, 100, "");
		static public var pcTxt:TextField = new TextField(200, 100, "");;
		
		//Here are the keyboard properties, to see when the ball should be released
		private var space:Boolean = true;
		
		//Here are the variables which will hold the data that is sent over to the leaderboard
		public var welcome:Welcome = new Welcome();
		public var userName:TextField = new TextField(200, 100, "");
		private var country:TextField = new TextField(200, 100, "");
		private var finalScore:int;
		private var concededScore:int;
		
		//Button back to the main menu
		private var mainMenuButton:Button;
		
		//Server variables
		private var socket:Socket;
		private var IP:String ="127.0.0.1";
		private var txt:TextField;
		private var response:String;
		//private var serverStatus:ByteArray;
				
		//Here we initialize all of the event listeners
		public function Multiplayer()
		{
			//Create a loader for the leaderboard and call the functions to
			//deal with loader events
			loader = new URLLoader();
			configureLeaderboardListeners(loader);
			
			//Add all of the event listeners here		
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
			this.addEventListener(starling.events.Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(starling.events.Event.ENTER_FRAME, collision);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		
		//Draw assets function
		private function drawGame():void
		{		
			//Here we create the socket connection to port 5555 and localhost
			//We add events to track when the socket is connected and when data is received
			socket = new Socket();
			socket.addEventListener(flash.events.Event.CONNECT, onConnected);
			socket.addEventListener(flash.events.ProgressEvent.SOCKET_DATA, sendPlayerPosition);
			socket.connect(IP, 5555);
			
			//We collect the player name the user logged in as here
			trace("Your player name: " + welcome.getPlayerName().text);
					
			//Draw all the assets
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
			
			//This is where we have our score text					
			playerTxt.x = 200;
			playerTxt.y = 0;
			playerTxt.color = 0xffffff;
			playerTxt.fontSize = 60;
			playerTxt.text = String(playerScore);
			addChild(playerTxt);

			pcTxt.x = stage.stageWidth - 200 - pcTxt.width;
			pcTxt.y = 0;
			pcTxt.color = 0xffffff;
			pcTxt.fontSize = 60;
			pcTxt.text = String(pcScore);
			addChild(pcTxt);
			
			//We call an event listener to track button clicks
			mainMenuButton = new Button(Assets.getTexture("MainMenuButton"));
			mainMenuButton.x = stage.stageWidth/2 - mainMenuButton.width/2;
			mainMenuButton.y = 20;
			mainMenuButton.downState = Assets.getTexture("MainMenuButton");
			this.addChild(mainMenuButton);
			this.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
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
		
		//Collision function for the paddle and ball
		private function collision(event:starling.events.Event):void
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
			//If player scores
			if (ball.x + ball.width >= stage.stageWidth)
			{
				//When score is less than 2, the score is added, score text
				//is updated and the score is sent to the server
				//Othe game over event is sent and data is sent to the leaderboard
				if(playerScore <= 2)
				{
					ball_xVelocity *= -1;
					playerScore += 1;
					playerTxt.text = String(playerScore);
					space = false;
					trace("player : " + playerScore);
					sendPlayerScore()
					resetBall();
				}
				else
				{
					gameOver();
					sendDataToLeaderboard();
				}
			}
				// <
			//If player 2 scores
			else if (ball.x <= 0)
			{
				if(pcScore <= 2)
				{
					ball_xVelocity *= -1;
					pcScore += 1;
					pcTxt.text = String(pcScore);
					trace("pc : " + pcScore);
					sendPCScore();
					space = false;
					resetBall();
				}
				else
				{
					gameOver();								
					sendDataToLeaderboard();
				}
			}
			// ^ Collision with top wall
			else if (ball.y <= 0)
			{
				ball_yVelocity *= -1;
			}
			// v Collision with bottom wall
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
		private function onEnterFrame(event:starling.events.Event):void
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
		
		//Reset the ball and paddles when ball is collided with vertical wall
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
			//reset ball position and hide all of the elements
			resetBall();
			ball.visible = false;
			player.visible = false;
			pc.visible = false;
			
			//remove event listeners and Oberserver launches the game over condition
			this.removeEventListener(starling.events.Event.ENTER_FRAME, gameOver);
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
			this.removeEventListener(starling.events.Event.ENTER_FRAME, onEnterFrame);
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
		
		//Send data to the leaderboard

		private function sendDataToLeaderboard():void
		{
			//Send data to the leaderboard when the game is finished
			//Wrap a token in the header for security
			//Send over the data as variables for reusability
			//Hardcoded country due to no user input support (problem not clear)
			trace("sending score");
			userName = welcome.getPlayerName();
			trace(playerScore);
			country.text = "GB";
			var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = 
			"http://andrew.coventry.domains/parseData?data={%22Username%22:%22 " + 
			userName.text + "%22,%22Country%22:%22" + country.text  + 
			"%22,%22Scored%22:" + playerScore + ",%22Conceded%22:" + 
			pcScore + "}";			
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
		
		//When main menu button is clicked the welcome screen is launched
		public function onButtonClick(event:starling.events.Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if ((buttonClicked as Button == mainMenuButton))
			{
				trace("pressed main menu button");
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
				this.removeEventListener(starling.events.Event.TRIGGERED, onButtonClick);		
			}
		}
		
		//This is where the leadeboard sends data if it is connected
		//It also performs error checks incase a certain error is encountered
		private function configureLeaderboardListeners(dispatcher:flash.events.IEventDispatcher):void
		{
			//trace("completeHandler: " + loader.data);
			dispatcher.addEventListener(flash.events.Event.COMPLETE, complete);
			dispatcher.addEventListener(flash.events.Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandlerLeaderboard);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandlerLeaderboard);
		}
		private function complete(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			trace("completeHandler: " + loader.data);
		}
		
		private function openHandler(event:flash.events.Event):void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:flash.events.ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandlerLeaderboard(event:flash.events.SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function httpStatusHandler(event:flash.events.HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandlerLeaderboard(event:flash.events.IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		
		protected function onConnected(event:flash.events.Event):void
		{			
			trace("Connection has been established");
			this.addEventListener(starling.events.Event.ENTER_FRAME, sendAllDataToServer);
		}
		
		//Sending player position to the server
		//We convert data to string first and then we send it over and flush the socket
		private function sendPlayerPosition():void
		{
			var playerYData:String = player.y.toString();
			socket.writeUTFBytes("Player y: ");
			socket.writeUTFBytes(playerYData);
			socket.writeUTFBytes("\n");
			socket.flush();
		}
		
		//Send ball position to the server in the same manner
		private function sendBallPosition():void
		{
			var ballXPosition:String = ball.x.toString();
			var ballYPosition:String = ball.y.toString();
			
			//Attempting to send player position to server
			socket.writeUTFBytes("Ball x: ");
			socket.writeUTFBytes(ballXPosition);
			socket.writeUTFBytes("\n");
			socket.flush();
			
			socket.writeUTFBytes("Ball y: ");
			socket.writeUTFBytes(ballYPosition);
			socket.writeUTFBytes("\n");
			socket.flush();
					
		}
		
		//Send the player score and let teh server know who scored
		private function sendPlayerScore():void
		{			
			var playerScoreData:String = playerScore.toString();
			
			socket.writeUTFBytes("Player scored! Player score: ");
			socket.writeUTFBytes(playerScoreData);
			socket.writeUTFBytes("\n");
			socket.flush();		
		}
		
		private function sendPCScore():void
		{
			trace("getBallPosition function called");
			
			var pcScoreData:String = pcScore.toString();
			
			socket.writeUTFBytes("Player 2 scored! Player 2 score: ");
			socket.writeUTFBytes(pcScoreData);
			socket.writeUTFBytes("\n");
			socket.flush();			
		}
		
		//This is where the data is sent at every frame to the server
		private function sendAllDataToServer(event:starling.events.Event):void
		{
			sendPlayerPosition();
			sendBallPosition();
		}
	}
}