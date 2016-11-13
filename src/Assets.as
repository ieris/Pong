package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets
	{
		// One Player / Two Player screen
		
		[Embed(source="../Assets/ball.png")]
		public static const Ball:Class;
		
		[Embed(source="../Assets/gameLogo.png")]
		public static const GameLogo:Class;
		
		[Embed(source="../Assets/playerOne.png")]
		public static const PlayerOne:Class;
		
		[Embed(source="../Assets/playerTwo.png")]
		public static const PlayerTwo:Class;
		
		[Embed(source="../Assets/screenBackground.jpg")]
		public static const ScreenBackground:Class;
		
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