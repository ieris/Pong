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
		
		[Embed(source="../Assets/Welcome/OnePlayerButton.jpg")]
		public static const OnePlayerButton:Class;
		
		[Embed(source="../Assets/Welcome/TwoPlayerButton.jpg")]
		public static const TwoPlayerButton:Class;
		
		[Embed(source="../Assets/Welcome/LeaderboardButton.jpg")]
		public static const LeaderboardButton:Class;
		
		[Embed(source="../Assets/Welcome/OptionsButton.jpg")]
		public static const OptionsButton:Class;
		
		[Embed(source="../Assets/Welcome/WelcomeBG.jpg")]
		public static const WelcomeBG:Class;
		
		[Embed(source="../Assets/Welcome/GameLogo.png")]
		public static const GameLogo:Class;
		
		[Embed(source="../Assets/Welcome/BallSelector.png")]
		public static const BallSelector:Class;
		
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