package screens
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Options extends Sprite
	{
		//Leaderboard variables
		private var loader:URLLoader;
		public var welcome:Welcome = new Welcome();
		public var userName:TextField;
		
		private var mainMenuButton:Button;
		private var deleteButton:Button;
		private var notification:TextField = new TextField(200, 200, "");
		
		public function Options()
		{
			super();
			//Create a loader for the leaderboard
			loader = new URLLoader();
			configureLeaderboardListeners(loader);
			
			//Add all of the event listeners here		
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, drawGame);
		}
		
		//Draw assets function
		private function drawGame():void
		{					
			notification.x = stage.stageWidth - 200 - notification.width;
			notification.y = 300;
			notification.color = 0xffffff;
			notification.fontSize = 30;
			addChild(notification);
			
			deleteButton = new Button(Assets.getTexture("DeleteButton"));
			deleteButton.x = stage.stageWidth/2 - deleteButton.width/2;
			deleteButton.y = 20;
			deleteButton.downState = Assets.getTexture("DeleteButton");
			this.addChild(deleteButton);
			this.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			
			mainMenuButton = new Button(Assets.getTexture("MainMenuButton"));
			mainMenuButton.x = stage.stageWidth/2 - mainMenuButton.width/2;
			mainMenuButton.y = 20;
			mainMenuButton.downState = Assets.getTexture("MainMenuButton");
			this.addChild(mainMenuButton);
			this.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
		}
		
		public function onButtonClick(event:starling.events.Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if ((buttonClicked as Button == mainMenuButton))
			{
				trace("pressed main menu button");
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
				this.removeEventListener(starling.events.Event.TRIGGERED, onButtonClick);		
			}
			else if ((buttonClicked as Button == deleteButton))
			{
				trace("pressed main menu button");
				deleteData();
				this.removeEventListener(starling.events.Event.TRIGGERED, onButtonClick);		
			}
		}
		
		//Delete data from the leaderboard
		private function deleteData():void
		{			
			userName = welcome.getPlayerName();
			var header:URLRequestHeader = new URLRequestHeader("token", "$/>?&ReqEQjs7ih");
			var url:String = "http://andrew.coventry.domains/removeData?query=username=" + userName;
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
			
			notification.text = "Your game data has been deleted";
		}
		
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
			
			var info:Object = JSON.parse(loader.data);
			trace("username is: " + info["leaderboardData"][0]["Username"]);
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
	}
}