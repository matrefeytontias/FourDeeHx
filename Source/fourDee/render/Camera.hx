package fourDee.render;

import fourDee.math.Euler3;
import fourDee.math.Intersector;

import lime.math.Matrix4;
import lime.utils.Float32Array;

/**
  * A camera is important in both 3D and 4D space, as its
  * field of view spans a 3D hyperplane in 4D space.
  * It has 4D coordinates and virtual 3D coordinates (they
  * are always 0 as it is the center of all 4D to 3D
  * projection). Because of this, it has a 4D position
  * but only a 3D rotation descriptor. Instead, it holds
  * an intersector, which will take care of projecting
  * the 4D objects onto the 3D field of view. Similarly,
  * scale is used as the zoom of the camera, but the W
  * scale coordinate is never used.
  */
class Camera extends Object4D
{
	private var intersector:Intersector;
	
	public var rotation3D:Euler3 = new Euler3();
	
	public var pmat:Matrix4 = new Matrix4();
	public var matrix3D:Matrix4;
	
	public function new()
	{
		super();
	}
	
	// Calculate the matrix only once per frame
	override public function update(dt:Int)
	{
		matrix3D = getMatrix3D();
	}
	
	// The camera is always the center of 3D space
	private function getMatrix3D() : Matrix4
	{
		var m = rotation3D.makeMatrix();
		m.appendScale(scale.x, scale.y, scale.z);
		return m;
	}
}