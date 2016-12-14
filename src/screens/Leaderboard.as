package screens
{
	import com.adobe.serialization.json;
	
	import flash.events.Event;
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
	
	public class Leaderboard extends Sprite
	{	
		private var loader:URLLoader;
	
		private var textInput:TextField = new TextField();
		private var textOutput:TextField = new TextField();
		private var userName:String = new String();
		private var country:String = new String();
		private var suggestedText:String = "Type your text here.";
		
		public function Leaderboard()
		{				
			loader = new URLLoader();
			configureListeners(loader);
			
			
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

			/*var textFormat:TextFormat = new TextFormat("Arial", 24, 0xFF0000);			
			textInput = new TextField();
			textInput.type = TextFieldType.INPUT;
			textInput.background = true;
			textInput.border = true;
			textInput.text = userName;*/
			//textInput.addEventListener(TextEvent. TEXT_INPUT, newPlayer);			
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
		
		private function newPlayer(event:TextEvent):void
		{

		}
	}
}