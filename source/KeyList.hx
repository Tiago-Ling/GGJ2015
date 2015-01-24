package ;

import flixel.input.FlxBaseKeyList;

class KeyList extends FlxBaseKeyList
{

	public function checkKey(key:Int):Bool
	{
		return this.check(key);
	}
}