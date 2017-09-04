package fourDee.render;

import fourDee.math.Vector2;
import fourDee.math.Vector4;

/**
  * Represents a minimal 4-dimensional cell, that is,
  * a tetrahedron.
  */
class Cell4
{
	/**
	  * Indexes of the tetrahedron's vertices in
	  * the parent geometry.
	  */
	public var a:Int;
	public var b:Int;
	public var c:Int;
	public var d:Int;
	
	/**
	  * Texture coordinates per vertex.
	  */
	public var ta:Vector2 = null;
	public var tb:Vector2 = null;
	public var tc:Vector2 = null;
	public var td:Vector2 = null;
	
	/**
	  * Tells whether the face is fit for use in
	  * texturing.
	  */
	public var isTextured(get, never):Bool;
	inline private function get_isTextured() : Bool
	{
		return ta != null && tb != null && tc != null && td != null;
	}
	
	/**
	  * Normal vector to the tetrahedron. It is
	  * important to note that in 4D space,
	  * surfaces have infinitely many different
	  * normal vectors, just like lines do in 3D
	  * space. However, just like surfaces in 3D
	  * space, volumes have exactly two normal
	  * vectors of opposite sign, computed with
	  * the 4D cross product. They have all the same
	  * properties as the "classic" normal vectors.
	  */
	public var normal(default, set):Vector4 = null;
	private function set_normal(v:Vector4) : Vector4
	{
		v.directionalOnly = true;
		return normal = v;
	}
	
	/**
	  * @param	a	index of the 1st vertex
	  * @param	b	index of the 2nd vertex
	  * @param	c	index of the 3rd vertex
	  * @param	d	index of the 4th vertex
	  */
	public function new(a:Int, b:Int, c:Int, d:Int)
	{
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}
	
	public function toString() : String
	{
		return "Cell4(" + a + ", " + b + ", " + c + ", " + d + ")";
	}
}
