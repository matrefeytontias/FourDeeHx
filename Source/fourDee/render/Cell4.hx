package fourDee.render;

/**
  * Represents a minimal 4-dimensional cell, that is,
  * a tetrahedron.
  */
class Cell4
{
	public var a:Int;
	public var b:Int;
	public var c:Int;
	public var d:Int;
	
	/**
	  * @param	a	index of the 1st face
	  * @param	b	index of the 2nd face
	  * @param	c	index of the 3rd face
	  * @param	d	index of the 4th face
	  */
	public function new(a:Int, b:Int, c:Int, d:Int)
	{
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}
}
