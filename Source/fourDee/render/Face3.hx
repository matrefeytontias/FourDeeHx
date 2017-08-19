package fourDee.render;

/**
  * Represents a 3-dimensional triangular face.
  */
class Face3
{
	public var a:Int;
	public var b:Int;
	public var c:Int;
	
	/**
	  * @param	a	index of the 1st face
	  * @param	b	index of the 2nd face
	  * @param	c	index of the 3rd face
	  */
	public function new(a:Int, b:Int, c:Int)
	{
		this.a = a;
		this.b = b;
		this.c = c;
	}
}
