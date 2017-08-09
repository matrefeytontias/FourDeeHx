package fourDee.render;

import lime.math.Matrix4;
import lime.utils.Float32Array;

class PerspectiveCamera extends Camera
{
	private var dNear:Float;
	private var pmat:Matrix4;
	
	public var matrix:Matrix4;
	
	// FOV is in degrees ; aspect ratio is width / height
	public function new(fov:Float, aspectRatio:Float)
	{
		var d = 1 / Math.tan(fov * Math.PI / 180 / 2);
		pmat = new Matrix4(new Float32Array([
			d, 0,  0, 0,
			0, d,  0, 0,
			0, 0,  d, 0,
			0, 0, -1, 0
		]));
		pmat[5] *= aspectRatio;
		pmat.transpose(); // because Lime
	}
	
	override private function getMatrix3D() : Matrix4
	{
		var r = super.getMatrix3D();
		r.prepend(pmat);
		return r;
	}
}