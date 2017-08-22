package fourDee.math;

import lime.math.Matrix4;
import lime.math.Vector4;

/**
  * Describes a rotation in 3D space. Assumes order XYZ.
  * All angles are in radians.
  */
class Euler3
{
	/**
	  * Rotation along the X axis.
	  */
	public var x:Float;
	/**
	  * Rotation along the Y axis.
	  */
	public var y:Float;
	/**
	  * Rotation along the Z axis.
	  */
	public var z:Float;
	
	/**
	  * @param	x	rotation around the X axis
	  * @param	y	rotation around the Y axis
	  * @param	z	rotation around the Z axis
	  */
	public function new(x = 0., y = 0., z = 0.)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	/**
	  * Returns a Matrix4 object representing the rotation in 3D.
	  * @return the rotation as a Matrix4
	  */
	public function makeMatrix() : Matrix4
	{
		var r = new Matrix4();
		if(x != 0)
			r.appendRotation(x * 180 / Math.PI, Vector4.X_AXIS);
		if(y != 0)
			r.appendRotation(y * 180 / Math.PI, Vector4.Y_AXIS);
		if(z != 0)
			r.appendRotation(z * 180 / Math.PI, Vector4.Z_AXIS);
		return r;
	}
}