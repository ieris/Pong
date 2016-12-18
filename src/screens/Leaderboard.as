package screens
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class Leaderboard extends Sprite
	{	
		private var loader:URLLoader;
		private var userName:TextField;
		private var country:TextField;
		private var rank:TextField;
		private var score:TextField
		
		public function Leaderboard()
		{				
			super();
			
			loader = new URLLoader();	
			configureListeners(loader);
			
			//Get data from the leaderboard by wrapping a token in a header and sending it over
			
			var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
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
			}
			
			visualize();
			//this.addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:flash.events.Event):void
		{		
			visualize();
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function visualize():void
		{
			rank = new TextField(200, 200, "Rank");
			rank.x = 640;
			rank.y = 60;
			rank.fontSize = 30;
			rank.color = 0xffffff;
			this.addChild(rank);
			
			userName = new TextField(200, 200, "Username");
			userName.x = 1280;
			userName.y = 60;
			userName.fontSize = 30;
			userName.color = 0xffffff;
			this.addChild(userName);
			
			country = new TextField(200, 200, "Country");
			country.x = 1920;
			country.y = 60;
			country.fontSize = 30;
			country.color = 0xffffff;
			this.addChild(country);
			
			score = new TextField(200, 200, "Score");
			score.x = 2560;
			score.y = 60;
			score.fontSize = 30;
			score.color = 0xffffff;
			this.addChild(score);
			
			//var format:TextFormat = new TextFormat();
			//format.font = "Arial";
			//format.color = 0xFF0000;
			//format.size = 40;
		}		
		
		private function configureListeners(dispatcher:flash.events.IEventDispatcher):void
		{
			//trace("completeHandler: " + loader.data);
			dispatcher.addEventListener(Event.COMPLETE, complete);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
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
		
		private function securityErrorHandler(event:flash.events.SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function httpStatusHandler(event:flash.events.HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandler(event:flash.events.IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		
		private function onEnterFrame(event:flash.events.Event):void
		{

		}
	}
}