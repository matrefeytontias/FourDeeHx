package fourDee.render;

import lime.math.Matrix4;
import lime.utils.Float32Array;

/**
  * Camera that implements perspective projection.
  */
class PerspectiveCamera extends Camera
{
	private var dNear:Float;
	
	/**
	  * @param	fov			field of view in degress
	  * @param	aspectRatio	ratio between the width and the height of the viewport
	  */
	public function new(fov:Float, aspectRatio:Float)
	{
		super();
		var d = 1 / Math.tan(fov * Math.PI / 180 / 2);
		pmat = new Matrix4(new Float32Array([ d, 0, 0, 0, 0, d * aspectRatio, 0, 0, 0, 0, d, -1, 0, 0, 0, 0 ]));
	}
}