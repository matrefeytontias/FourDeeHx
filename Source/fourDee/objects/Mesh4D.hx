package fourDee.objects;

class Mesh4D extends Object4D
{
	public var geometry:Geometry4D;
	public var material:Material;
	
	public function new(g:Geometry4D, m:Material)
	{
		geometry = g;
		material = m;
	}
	
	override public function render(camera:Camera)
	{
		trace("Insert render process here");
	}
}