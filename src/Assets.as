package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets
	{
		// One Player / Two Player screen
		
		[Embed(source="../Assets/Ball.png")]
		public static const Ball:Class;
		
		[Embed(source="../Assets/PlayerOne.jpg")]
		public static const PlayerOne:Class;
		
		[Embed(source="../Assets/PlayerTwo.jpg")]
		public static const PlayerTwo:Class;
		
		[Embed(source="../Assets/GameBG.jpg")]
		public static const GameBG:Class;
		
		//Welcome screen
		
		[Embed(source="../Assets/Welcome/MultiplayerButton.jpg")]
		public static const MultiplayerButton:Class;
		
		[Embed(source="../Assets/Welcome/SingleplayerButton.jpg")]
		public static const SingleplayerButton:Class;
		
		[Embed(source="../Assets/Welcome/LeaderboardButton.jpg")]
		public static const LeaderboardButton:Class;
		
		[Embed(source="../Assets/Welcome/OptionsButton.jpg")]
		public static const OptionsButton:Class;
		
		[Embed(source="../Assets/Welcome/DeleteButton.png")]
		public static const DeleteButton:Class;
		
		[Embed(source="../Assets/Welcome/GameLogo.png")]
		public static const GameLogo:Class;
		
		[Embed(source="../Assets/Welcome/BallSelector.png")]
		public static const BallSelector:Class;
		
		//Multiplayer/Singleplayer assets
		
		[Embed(source="../Assets/UserInputBox.png")]
		public static const UserInputBox:Class;

		[Embed(source="../Assets/logInButton.png")]
		public static const LogInButton:Class;
		
		//Log in assets
		
		[Embed(source="../Assets/Name1.png")]
		public static const Name1:Class;
		
		[Embed(source="../Assets/Name2.png")]
		public static const Name2:Class;
		
		[Embed(source="../Assets/Name3.png")]
		public static const Name3:Class;
		
		//Game over screen
		
		[Embed(source="../Assets/GameOver.png")]
		public static const GameOver:Class;
		
		[Embed(source="../Assets/MainMenuButton.png")]
		public static const MainMenuButton:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}