package fourDee.geometries;

import fourDee.math.Vector3;
import fourDee.render.Face3;

class BoxGeometry4D extends Geometry4D
{
	static private var cubeFaces = [ new Face3(0, 1, 2), new Face3(0, 2, 3),
		new Face3(4, 6, 5), new Face3(4, 7, 6),
		new Face3(0, 3, 7), new Face3(0, 7, 4),
		new Face3(1, 6, 2), new Face3(1, 5, 6),
		new Face3(2, 6, 7), new Face3(2, 7, 3),
		new Face3(1, 0, 4), new Face3(1, 4, 5)
	];
	
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
