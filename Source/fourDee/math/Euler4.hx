package fourDee.math;

import fourDee.math.Matrix5.Rotation4D;

/**
  * Represents a rotation in 4D space.
  * All angles are in radians.
  */
class Euler4
{
	static public var defaultOrder = [ Rotation4D.XY, Rotation4D.XZ, Rotation4D.XW, Rotation4D.YZ, Rotation4D.YW, Rotation4D.ZW ];
	/**
	  * Rotation on the XY plane.
	  */
	public var xy:Float;
	/**
	  * Rotation on the XZ plane.
	  */
	public var xz:Float;
	/**
	  * Rotation on the XW plane.
	  */
	public var xw:Float;
	/**
	  * Rotation on the YZ plane.
	  */
	public var yz:Float;
	/**
	  * Rotation on the YW plane.
	  */
	public var yw:Float;
	/**
	  * Rotation on the ZW plane.
	  */
	public var zw:Float;
	/**
	  * Order in which the rotations are applied.
	  */
	public var order:Array<Rotation4D>;
	/**
	  * Center of rotation.
	  */
	public var center:Vector4;
	
	/**
	  * @param	xy		rotation on the XY plane
	  * @param	xz		rotation on the XZ plane
	  * @param	xw		rotation on the XW plane
	  * @param	yz		rotation on the YZ plane
	  * @param	yw		rotation on the YW plane
	  * @param	zw		rotation on the ZW plane
	  * @param	order	order of the rotations
	  */
	public function new(xy = 0., xz = 0., xw = 0., yz = 0., yw = 0., zw = 0., ?order:Array<Rotation4D>)
	{
	  this.xy = xy;
	  this.xz = xz;
	  this.xw = xw;
	  this.yz = yz;
	  this.yw = yw;
	  this.zw = zw;
	  this.order = order == null ? defaultOrder : order;
	  this.center = new Vector4();
	}
	
	/**
	  * Returns a copy of the Euler4.
	  * @return	copy of the object
	  */
	public function clone()
	{
		var c = new Euler4(xy, xz, xw, yz, yw, zw, order);
		c.center = center.clone();
		return c;
	}
	
	private function getRot(r:Rotation4D) : Float
	{
		return Reflect.field(this, Type.enumConstructor(r).toLowerCase());
	}
	
	/**
	  * Returns a Matrix5 object representing the rotatoin in 4D.
	  * @return	the rotation as a Matrix5
	  */
	public function makeMatrix() : Matrix5
	{
		var m:Matrix5 = new Matrix5(), r = new Matrix5();
		var n = order.length - 1;
		
		for(i in 0 ... n + 1)
		{
			var rot = order[n - i];
			var theta = getRot(rot);
			if(theta != 0.)
				m = m * r.makeRotation(rot, theta);
		}
		
		return m + (center.sub(m * center));
	}
}