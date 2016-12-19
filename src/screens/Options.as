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
		
		//This is where the user name is stored that the user has logged in as
		public var welcome:Welcome = new Welcome();
		public var userName:TextField = new TextField(0,0,"");
		
		//All the buttons and text
		private var mainMenuButton:Button;
		private var deleteButton:Button;
		private var notification:TextField = new TextField(2000, 200, "");
		
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
			notification.x = stage.stageWidth/2 - notification.width/2;
			notification.y = 220;
			notification.color = 0xffffff;
			notification.fontSize = 30;
			addChild(notification);
			
			deleteButton = new Button(Assets.getTexture("DeleteButton"));
			deleteButton.x = stage.stageWidth/2 - deleteButton.width/2;
			deleteButton.y = 400;
			deleteButton.downState = Assets.getTexture("DeleteButton");
			this.addChild(deleteButton);
			
			mainMenuButton = new Button(Assets.getTexture("MainMenuButton"));
			mainMenuButton.x = stage.stageWidth/2 - mainMenuButton.width/2;
			mainMenuButton.y = 20;
			mainMenuButton.downState = Assets.getTexture("MainMenuButton");
			this.addChild(mainMenuButton);
			this.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
		}
		
		//If main menu button is clicked it goes to the main screen
		//IF delete button is clicked the delete function is called
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
			}
		}
		
		//Delete data from the leaderboard
		//We take the user id (which is currently not implemented in the leaderboard)
		//and then send a post request to delete the data with the specific id
		private function deleteData():void
		{			
			//
			var id:int = 13;
			var userData:String = "%22" + id + "%22";
			var header:URLRequestHeader = new URLRequestHeader("token", "$/>?&ReqEQjs7ih");
			var url:String = "http://andrew.coventry.domains/removeData?query=id=" + id;
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
		
		//Leaderboard listeners
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
			//var loader:URLLoader = URLLoader(event.target);
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
	}
}