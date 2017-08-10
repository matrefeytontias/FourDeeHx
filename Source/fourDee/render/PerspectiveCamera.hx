package fourDee.render;

import lime.math.Matrix4;
import lime.utils.Float32Array;

class PerspectiveCamera extends Camera
{
	private var dNear:Float;
	
	// FOV is in degrees ; aspect ratio is width / height
	public function new(fov:Float, aspectRatio:Float)
	{
		super();
		var d = 1 / Math.tan(fov * Math.PI / 180 / 2);
		pmat = new Matrix4(new Float32Array([ d, 0, 0, 0, 0, d * aspectRatio, 0, 0, 0, 0, d, -1, 0, 0, 0, 0 ]));
	}
}