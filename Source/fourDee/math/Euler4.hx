package fourDee.math;

import fourDee.math.Matrix5.Rotation4D;

class Euler4
{
	static public var defaultOrder = [ Rotation4D.XY, Rotation4D.XZ, Rotation4D.XW, Rotation4D.YZ, Rotation4D.YW, Rotation4D.ZW ];
	public var xy:Float;
	public var xz:Float;
	public var xw:Float;
	public var yz:Float;
	public var yw:Float;
	public var zw:Float;
	public var order:Array<Rotation4D>;
	public var center:Vector4;
	
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
	
	public function makeMatrix() : Matrix5
	{
		var m:Matrix5 = new Matrix5(), r = new Matrix5();
		var n = order.length - 1;
		
		for(i in 0 ... n + 1)
		{
			var rot = order[n - i];
			var theta = getRot(rot);
			trace(theta);
			if(theta != 0.)
				m = m * r.makeRotation(rot, theta);
		}
		
		return m + (center.subtract(m * center));
	}
}