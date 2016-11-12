package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	//import starling.textures.TextureAtlas;
	
	public class Assets
	{
		// In game screen
		
		[Embed(source="../Assets/ball.png")]
		public static var Ball:Class;
		
		[Embed(source="../Assets/gameLogo.png")]
		public static var GameLogo:Class;
		
		[Embed(source="../Assets/playerOne.png")]
		public static var PlayerOne:Class;
		
		[Embed(source="../Assets/playerTwo.png")]
		public static var PlayerTwo:Class;
		
		[Embed(source="../Assets/screenBackground.jpg")]
		public static var ScreenBackground:Class;
		
		//public static var UpgradeTable:Class;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		/*private static var gameTextureAtlas:TextureAtlas;
		private static var gameTextures2:Dictionary = new Dictionary();
		private static var gameTextureAtlas2:TextureAtlas;
		*/
		
		//Fire ball
		
		/*[Embed(source="../Media of Fire Run/fireBall/Sprite Sheet/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source = "../Media of Fire Run/fireBall/Sprite Sheet/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		[Embed(source="../Media of Fire Run/Sprites/oSprite.png")]
		public static const AtlasTextureObstacles:Class;
		
		[Embed(source = "../Media of Fire Run/Sprites/oSprite.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlObstacles:Class;
		*/
		
		/*public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getAtlas2():TextureAtlas
		{
			if (gameTextureAtlas2 == null)
			{
				var textureO:Texture = getTexture("AtlasTextureObstacles");
				var xmlO:XML = XML(new AtlasXmlObstacles());
				gameTextureAtlas2 = new TextureAtlas(textureO, xmlO);
			}
			return gameTextureAtlas2;
		}
		*/
		
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