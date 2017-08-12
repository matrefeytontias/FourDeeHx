package fourDee.objects;

class Mesh4D extends Object4D
{
	public var geometry:Geometry4D;
	public var material:Material;
	
	public function new(g:Geometry4D, m:Material)
	{
		super();
		geometry = g;
		material = m;
	}
}