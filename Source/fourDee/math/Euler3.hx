package fourDee.math;

import lime.math.Matrix4;
import lime.math.Vector4;

// Used exclusively by Camera
class Euler3
{
	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	public function new(x = 0., y = 0., z = 0.)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	public function makeMatrix() : Matrix4
	{
		var r = new Matrix4();
		if(x != 0)
			r.prependRotation(x * 180 / Math.PI, Vector4.X_AXIS);
		if(y != 0)
			r.prependRotation(y * 180 / Math.PI, Vector4.Y_AXIS);
		if(z != 0)
			r.prependRotation(z * 180 / Math.PI, Vector4.Z_AXIS);
		return r;
	}
}