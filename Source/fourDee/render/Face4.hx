package fourDee.render;

/**
  * Represents a 4-dimensional face, that is,
  * a tetrahedron.
  */
class Face4
{
	public var a:Int;
	public var b:Int;
	public var c:Int;
	public var d:Int;
	
	public function new(a:Int, b:Int, c:Int, d:Int)
	{
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}
}