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
	  * @param	near		Z coordinate of the near plane
	  * @param	far			Z coordinate of the far plane
	  */
	public function new(fov:Float, aspectRatio:Float, near:Float, far:Float)
	{
		super();
		var d = 1 / Math.tan(fov * Math.PI / 180 / 2);
		var ir = 1. / (near - far);
		pmat = new Matrix4(new Float32Array([ d, 0, 0, 0, 0, d * aspectRatio, 0, 0, 0, 0, (near + far) * ir, -1, 0, 0, 2 * near * far * ir, 0 ]));
	}
	
	/**
	  * Changes the aspect ratio used for perspective.
	  * @param	ar	the new aspect ratio
	  */
	public function updateAspectRatio(ar:Float)
	{
		pmat[5] = pmat[0] * ar;
	}
}