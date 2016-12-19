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
	
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Leaderboard extends Sprite
	{	
		private var loader:URLLoader;
		private var userName:TextField;
		private var country:TextField;
		private var rank:TextField;
		private var score:TextField
		private var mainMenuButton:Button;
		
		public function Leaderboard()
		{				
			super();
			
			loader = new URLLoader();	
			configureListeners(loader);
			
			//Get data from the leaderboard by wrapping a token in a header and sending it over
			
			var header:URLRequestHeader = new URLRequestHeader("token", "NG$c0#f5H9EL~_o");
			var url:String = "http://andrew.coventry.domains//returnTop10";
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
			rank.y = 160;
			rank.fontSize = 30;
			rank.color = 0xffffff;
			this.addChild(rank);
			
			userName = new TextField(200, 200, "Username");
			userName.x = 1280;
			userName.y = 160;
			userName.fontSize = 30;
			userName.color = 0xffffff;
			this.addChild(userName);
			
			country = new TextField(200, 200, "Country");
			country.x = 1920;
			country.y = 160;
			country.fontSize = 30;
			country.color = 0xffffff;
			this.addChild(country);
			
			score = new TextField(200, 200, "Score");
			score.x = 2560;
			score.y = 160;
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
			dispatcher.addEventListener(flash.events.Event.COMPLETE, complete);
			dispatcher.addEventListener(flash.events.Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		private function complete(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			trace("completeHandler: " + loader.data);
			
			//Rank
			var rank1:TextField = new TextField(100, 100, "1");
			var rank2:TextField = new TextField(100, 100, "2");
			var rank3:TextField = new TextField(100, 100, "3");
			var rank4:TextField = new TextField(100, 100, "4");
			var rank5:TextField = new TextField(100, 100, "5");
			var rank6:TextField = new TextField(100, 100, "6");
			var rank7:TextField = new TextField(100, 100, "7");
			var rank8:TextField = new TextField(100, 100, "8");
			var rank9:TextField = new TextField(100, 100, "9");
			var rank10:TextField = new TextField(100, 100, "10");
			
			rank1.x = 680;
			rank1.y = 300;
			rank1.fontSize = 20;
			rank1.color = 0xffffff;
			this.addChild(rank1);
			
			rank2.x = 680;
			rank2.y = 400;
			rank2.fontSize = 20;
			rank2.color = 0xffffff;
			this.addChild(rank2);
			
			rank3.x = 680;
			rank3.y = 500;
			rank3.fontSize = 20;
			rank3.color = 0xffffff;
			this.addChild(rank3);
			
			rank4.x = 680;
			rank4.y = 600;
			rank4.fontSize = 20;
			rank4.color = 0xffffff;
			this.addChild(rank4);
			
			rank5.x = 680;
			rank5.y = 700;
			rank5.fontSize = 20;
			rank5.color = 0xffffff;
			this.addChild(rank5);
			
			rank6.x = 680;
			rank6.y = 800;
			rank6.fontSize = 20;
			rank6.color = 0xffffff;
			this.addChild(rank6);
			
			rank7.x = 680;
			rank7.y = 900;
			rank7.fontSize = 20;
			rank7.color = 0xffffff;
			this.addChild(rank7);
			
			rank8.x = 680;
			rank8.y = 1000;
			rank8.fontSize = 20;
			rank8.color = 0xffffff;
			this.addChild(rank8);
			
			rank9.x = 680;
			rank9.y = 1100;
			rank9.fontSize = 20;
			rank9.color = 0xffffff;
			this.addChild(rank9);
			
			rank10.x = 680;
			rank10.y = 1200;
			rank10.fontSize = 20;
			rank10.color = 0xffffff;
			this.addChild(rank10);
			
			//Username
			
			var info:Object = JSON.parse(loader.data);
			var name1:TextField = new TextField(100, 100, (info["leaderboardData"][0]["Username"]));
			var name2:TextField = new TextField(100, 100, (info["leaderboardData"][1]["Username"]));
			var name3:TextField = new TextField(100, 100, (info["leaderboardData"][2]["Username"]));
			var name4:TextField = new TextField(100, 100, (info["leaderboardData"][3]["Username"]));
			var name5:TextField = new TextField(100, 100, (info["leaderboardData"][4]["Username"]));
			var name6:TextField = new TextField(100, 100, (info["leaderboardData"][5]["Username"]));
			var name7:TextField = new TextField(100, 100, (info["leaderboardData"][6]["Username"]));
			var name8:TextField = new TextField(100, 100, (info["leaderboardData"][7]["Username"]));
			var name9:TextField = new TextField(100, 100, (info["leaderboardData"][8]["Username"]));
			var name10:TextField = new TextField(100, 100, (info["leaderboardData"][9]["Username"]));

			name1.x = 1330;
			name1.y = 300;
			name1.fontSize = 20;
			name1.color = 0xffffff;
			this.addChild(name1);
			
			name2.x = 1330;
			name2.y = 400;
			name2.fontSize = 20;
			name2.color = 0xffffff;
			this.addChild(name2);

			name3.x = 1330;
			name3.y = 500;
			name3.fontSize = 20;
			name3.color = 0xffffff;
			this.addChild(name3);
			
			name4.x = 1330;
			name4.y = 600;
			name4.fontSize = 20;
			name4.color = 0xffffff;
			this.addChild(name4);
			
			name5.x = 1330;
			name5.y = 700;
			name5.fontSize = 20;
			name5.color = 0xffffff;
			this.addChild(name5);
			
			name6.x = 1330;
			name6.y = 800;
			name6.fontSize = 20;
			name6.color = 0xffffff;
			this.addChild(name6);
			
			name7.x = 1330;
			name7.y = 900;
			name7.fontSize = 20;
			name7.color = 0xffffff;
			this.addChild(name7);
			
			name8.x = 1330;
			name8.y = 1000;
			name8.fontSize = 20;
			name8.color = 0xffffff;
			this.addChild(name8);
			
			name9.x = 1330;
			name9.y = 1100;
			name9.fontSize = 20;
			name9.color = 0xffffff;
			this.addChild(name9);
			
			name10.x = 1330;
			name10.y = 1200;
			name10.fontSize = 20;
			name10.color = 0xffffff;
			this.addChild(name10);
			
			//Country

			var country1:TextField = new TextField(100, 100, (info["leaderboardData"][0]["Country"]));
			var country2:TextField = new TextField(100, 100, (info["leaderboardData"][1]["Country"]));
			var country3:TextField = new TextField(100, 100, (info["leaderboardData"][2]["Country"]));
			var country4:TextField = new TextField(100, 100, (info["leaderboardData"][3]["Country"]));
			var country5:TextField = new TextField(100, 100, (info["leaderboardData"][4]["Country"]));
			var country6:TextField = new TextField(100, 100, (info["leaderboardData"][5]["Country"]));
			var country7:TextField = new TextField(100, 100, (info["leaderboardData"][6]["Country"]));
			var country8:TextField = new TextField(100, 100, (info["leaderboardData"][7]["Country"]));
			var country9:TextField = new TextField(100, 100, (info["leaderboardData"][8]["Country"]));
			var country10:TextField = new TextField(100, 100, (info["leaderboardData"][9]["Country"]));
			
			country1.x = 1960;
			country1.y = 300;
			country1.fontSize = 20;
			country1.color = 0xffffff;
			this.addChild(country1);
			
			country2.x = 1960;
			country2.y = 400;
			country2.fontSize = 20;
			country2.color = 0xffffff;
			this.addChild(country2);
			
			country3.x = 1960;
			country3.y = 500;
			country3.fontSize = 20;
			country3.color = 0xffffff;
			this.addChild(country3);
			
			country4.x = 1960;
			country4.y = 600;
			country4.fontSize = 20;
			country4.color = 0xffffff;
			this.addChild(country4);
			
			country5.x = 1960;
			country5.y = 700;
			country5.fontSize = 20;
			country5.color = 0xffffff;
			this.addChild(country5);
			
			country6.x = 1960;
			country6.y = 800;
			country6.fontSize = 20;
			country6.color = 0xffffff;
			this.addChild(country6);
			
			country7.x = 1960;
			country8.y = 900;
			country8.fontSize = 20;
			country8.color = 0xffffff;
			this.addChild(country8);
			
			country8.x = 1960;
			country8.y = 1000;
			country8.fontSize = 20;
			country8.color = 0xffffff;
			this.addChild(country8);
			
			country9.x = 1960;
			country9.y = 1100;
			country9.fontSize = 20;
			country9.color = 0xffffff;
			this.addChild(country9);
			
			country10.x = 1960;
			country10.y = 1200;
			country10.fontSize = 20;
			country10.color = 0xffffff;
			this.addChild(country10);
			
			
			//Score
			var score1:TextField = new TextField(100, 100, (info["leaderboardData"][0]["Score"]));
			var score2:TextField = new TextField(100, 100, (info["leaderboardData"][1]["Score"]));
			var score3:TextField = new TextField(100, 100, (info["leaderboardData"][2]["Score"]));
			var score4:TextField = new TextField(100, 100, (info["leaderboardData"][3]["Score"]));
			var score5:TextField = new TextField(100, 100, (info["leaderboardData"][4]["Score"]));
			var score6:TextField = new TextField(100, 100, (info["leaderboardData"][5]["Score"]));
			var score7:TextField = new TextField(100, 100, (info["leaderboardData"][6]["Score"]));
			var score8:TextField = new TextField(100, 100, (info["leaderboardData"][7]["Score"]));
			var score9:TextField = new TextField(100, 100, (info["leaderboardData"][8]["Score"]));
			var score10:TextField = new TextField(100, 100, (info["leaderboardData"][9]["Score"]));
			
			score1.x = 2600;
			score1.y = 300;
			score1.fontSize = 20;
			score1.color = 0xffffff;
			this.addChild(score1);
			
			score2.x = 2600;
			score2.y = 400;
			score2.fontSize = 20;
			score2.color = 0xffffff;
			this.addChild(score2);
			
			score3.x = 2600;
			score3.y = 500;
			score3.fontSize = 20;
			score3.color = 0xffffff;
			this.addChild(score3);
			
			score4.x = 2600;
			score4.y = 600;
			score4.fontSize = 20;
			score4.color = 0xffffff;
			this.addChild(score4);
			
			score5.x = 2600;
			score5.y = 700;
			score5.fontSize = 20;
			score5.color = 0xffffff;
			this.addChild(score5);
			
			score6.x = 2600;
			score6.y = 800;
			score6.fontSize = 20;
			score6.color = 0xffffff;
			this.addChild(score6);
			
			score7.x = 2600;
			score7.y = 900;
			score7.fontSize = 20;
			score7.color = 0xffffff;
			this.addChild(score7);
			
			score8.x = 2600;
			score8.y = 1000;
			score8.fontSize = 20;
			score8.color = 0xffffff;
			this.addChild(score8);
			
			score9.x = 2600;
			score9.y = 1100;
			score9.fontSize = 20;
			score9.color = 0xffffff;
			this.addChild(score9);
			
			score10.x = 2600;
			score10.y = 1200;
			score10.fontSize = 20;
			score10.color = 0xffffff;
			this.addChild(score10);
			
			mainMenuButton = new Button(Assets.getTexture("MainMenuButton"));
			mainMenuButton.x = 1500;
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