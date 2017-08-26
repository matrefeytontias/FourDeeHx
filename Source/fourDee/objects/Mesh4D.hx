package fourDee.objects;

import fourDee.render.RenderMethod;

/**
  * Generic 4D object, with vertices and materials.
  */
class Mesh4D extends Object4D
{
	/**
	  * Geometry4D describing the vertices and faces
	  * of the object.
	  */
	public var geometry:Geometry4D;
	/**
	  * Material of the object.
	  */
	public var material:Material;
	
	/**
	  * @param	g	Geometry4D to assign to this object
	  * @param	m	Material to use to render this object
	  */
	public function new(g:Geometry4D, m:Material)
	{
		super();
		geometry = g;
		material = m;
		renderMethod = RenderMethod.Intersect;
	}
}