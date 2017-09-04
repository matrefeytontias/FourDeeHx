package fourDee.render;

import fourDee.math.Vector2;

/**
  * Represents a 3-dimensional triangular face.
  */
class Face3
{
	/**
	  * Indexes of vertices in the parent geometry.
	  */
	public var a:Int;
	public var b:Int;
	public var c:Int;
	
	/**
	  * Texture coordinates per vertex.
	  */
	public var ta:Vector2 = null;
	public var tb:Vector2 = null;
	public var tc:Vector2 = null;
	
	/**
	  * Tells whether the face is fit for use in
	  * texturing.
	  */
	public var isTextured(get, never):Bool;
	inline private function get_isTextured() : Bool
	{
		return ta != null && tb != null && tc != null;
	}
	
	/**
	  * @param	a	index of the 1st vertex
	  * @param	b	index of the 2nd vertex
	  * @param	c	index of the 3rd vertex
	  */
	public function new(a:Int, b:Int, c:Int)
	{
		this.a = a;
		this.b = b;
		this.c = c;
	}
	
	public function toString() : String
	{
		return "Face3(" + a + ", " + b + ", " + c + ")";
	}
}
