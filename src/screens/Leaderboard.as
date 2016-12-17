package screens
{
	import com.adobe.serialization.json;
	
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TextEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Leaderboard extends Sprite
	{	
		private var welcome:Welcome = new Welcome();
		private var player:Multiplayer = new Multiplayer();
		private var myPaddlePosition:int;
		private var multiplayer:Multiplayer = new Multiplayer();
		private var loader:URLLoader;
		private var textInput:TextField = new TextField();
		private var textOutput:TextField = new TextField();
		private var userName:String = new String();
		private var country:String = new String();
		private var suggestedText:String = "Type your text here.";
		
		public function Leaderboard()
		{				
			
			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			loader = new URLLoader();
			configureListeners(loader);
			
			//trace("leaderboard player : " + player.playerScore);
			//trace("leaderboard pc : " + player.pcScore);
						
			//this.addChild(multiplayer);
			
			/*var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = "%22Username%22:%22Alice%22,%22Country%22:%22USA%22,%22Scored%22:12,%22Conceded%22:2";
			var urlRequest:URLRequest = new URLRequest(url);
			//var variables:URLVariables = new URLVariables();
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(header);
			
			//variables.ball_x_position = 0;
			//variables.ball_y_position = 0;
			//variables.player_one_y_position = 0;
			//variables.player_two_y_position = 0;
			
			//urlRequest.data = variables;
			
			try
			{
				loader.load(urlRequest);
			}
			catch(error:Error)
			{
				trace("Unable to load the data from the leaderboard");
			}*/
			
			//serverSocket.addEventListener(Event.CONNECT,socketConnected);
			//serverSocket.addEventListener(ProgressEvent.SOCKET_DATA,socketData);
			//serverSocket.connect(ip, port);*/
			
			//Add in variables that are collected from the game
			//Include input data so the player can create a new account
			//Set paddle position in EnterFrame function (connection lost af
			//When user clicks on "Multiplayer" the message "establishing connection" appears
			//If connection is established - "connected" or if not "could not establish connection"
			
			// connect to server
			// get a message that you are connected
			// get list of players available
			// send a match message
			// receive you are matched
			// you receive player has joined
			// wait for connection
			// when game is ready, you receive you can play
			// you receive the game has started
			// if playter quits
			// if player offline
			// send paddle and who scored
			
			// visualizing:
			//
			
			//Check the data you receive is what you expect. For example if the paddle position can only be in range of 0 - 500, anything outside of this is not a valid value.
			//Leaderboard[0]["Name"] - use a JSON parser in built in as3 [array size]
			//Set the code to be Observer, Controller, Singleton

			
			// ------------------------------------- POST REQUEST ----------------------------------------- //
			/*var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = "http://andrew.coventry.domains/parseData?data={%22Username%22:%22Rober%22,%22Country%22:%22West Virginia%22,%22Scored%22:400,%22Conceded%22:242}";
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
			}*/
			
			// ------------------------------------- GET REQUEST ----------------------------------------- //
			
			/*var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = "http://andrew.coventry.domains//returnWeek";
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
			}*/
			
			// ---------------------------------- DELETE DATA ------------------------------------------//
			
			/*var header:URLRequestHeader = new URLRequestHeader("token", "$/>?&ReqEQjs7ih");
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
			}	*/					

			/*var textFormat:TextFormat = new TextFormat("Arial", 24, 0xFF0000);			
			textInput = new TextField();
			textInput.type = TextFieldType.INPUT;
			textInput.background = true;
			textInput.border = true;
			textInput.text = userName;*/
			//textInput.addEventListener(TextEvent. TEXT_INPUT, newPlayer);			
		}

		private function onEnterFrame(event:Event):void
		{
			multiplayer.getPlayerScore();
			multiplayer.getPCScore();
			
			trace(multiplayer.getPCScore());
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void
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
		}
	}
}