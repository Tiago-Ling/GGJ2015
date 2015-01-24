package ;

import haxe.xml.Fast;
import openfl.Assets;

// This class holds all the configurations of the game read from config xml
class Configuration
{
	public function new()
	{

	}

	public function load(filePath:String):Void
	{
		var fileData = Assets.getText(filePath);
		var xml = Xml.parse(fileData);

		var config = new Fast(xml.firstElement());
		trace(config.node.test.att.name);
	}


}
