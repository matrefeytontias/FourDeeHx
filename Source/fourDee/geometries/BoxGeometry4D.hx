package fourDee.geometries;

import fourDee.math.Vector3;
import fourDee.render.Face3;

/**
  * Geometry4D for a 4D hypercube of given
  * width, height, depth and duth.
  */
class BoxGeometry4D extends Geometry4D
{
	static private var cubeFaces = [ new Face3(0, 1, 2), new Face3(0, 2, 3),
		new Face3(4, 6, 5), new Face3(4, 7, 6),
		new Face3(0, 3, 7), new Face3(0, 7, 4),
		new Face3(1, 6, 2), new Face3(1, 5, 6),
		new Face3(2, 6, 7), new Face3(2, 7, 3),
		new Face3(1, 0, 4), new Face3(1, 4, 5)
	];
	
	/**
	  * @param	w	width
	  * @param	h	height
	  * @param	d	depth
	  * @param	du	duth ; "length" along the 4th axis
	  */
	public function new(w:Float, h:Float, d:Float, du:Float)
	{
		super();
		
		var vertices3 = [ new Vector3(-w / 2, -h / 2, d / 2),
			new Vector3(w / 2, -h / 2, d / 2),
			new Vector3(w / 2, h / 2, d / 2),
			new Vector3(-w / 2, h / 2, d / 2),
			new Vector3(-w / 2, -h / 2, -d / 2),
			new Vector3(w / 2, -h / 2, -d / 2),
			new Vector3(w / 2, h / 2, -d / 2),
			new Vector3(-w / 2, h / 2, -d / 2)
		];
		
		from3D(vertices3, cubeFaces, du);
	}
}
