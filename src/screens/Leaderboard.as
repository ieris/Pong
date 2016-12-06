package screens
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Mouse;	
	import starling.display.Sprite;
	
	public class Leaderboard extends Sprite
	{	
		private var textInput:TextField = new TextField();
		private var textOutput:TextField = new TextField();
		private var userName:String = new String();
		private var country:String = new String();
		private var suggestedText:String = "Type your text here.";
		
		public function Leaderboard()
		{				
			/*var loader:URLLoader = new URLLoader;
			var url:String = "http://andrew.coventry.domains/";
			var urlRequest:URLRequest = new URLRequest(url);
			var variables:URLVariables = new URLVariables;
			
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			urlRequest.method = URLRequestMethod.POST;
			
			//variables.userName = "Albert";
			variables.country = "Park";
			variables.score = "355";
			
			urlRequest.data = variables;
			
			loader.addEventListener(Event.COMPLETE, complete);
			loader.load(urlRequest);*/
			super();
			
			var textFormat:TextFormat = new TextFormat("Arial", 24, 0xFF0000);
			
			textInput = new TextField();
			textInput.type = TextFieldType.INPUT;
			textInput.background = true;
			textInput.border = true;
			textInput.text = userName;
			//textInput.addEventListener(TextEvent. TEXT_INPUT, newPlayer);			
		}
		
		public function complete(event:Event):void
		{
			trace(event.target.data);
		}
		
		public function newPlayer(event:TextEvent):void
		{

		}
	}
}