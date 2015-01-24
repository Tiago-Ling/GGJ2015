package ;

import haxe.xml.Fast;
import openfl.Assets;

// This class holds all the configurations of the game read from config xml
class Configuration
{
	public static function load(filePath:String):Void
	{
		Assets.loadText(filePath, function (data:String):Void {
			var xml = Xml.parse(data);
			var config = new Fast(xml.firstElement());
		});
	}
}
