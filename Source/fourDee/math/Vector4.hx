package fourDee.math;

class Vector4
{
	static public var X_AXIS = new Vector4(1, 0, 0, 0);
	static public var Y_AXIS = new Vector4(0, 1, 0, 0);
	static public var Z_AXIS = new Vector4(0, 0, 1, 0);
	static public var W_AXIS = new Vector4(0, 0, 0, 1);
	
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var w:Float;
	
	public var lengthSquared(get, never):Float;
	inline private function get_lengthSquared() : Float
	{
		return dot(this);
	}
	
	public var length(get, never):Float;
	inline private function get_length() : Float
	{
		return Math.sqrt(lengthSquared);
	}
	
	public function new(x = 0., y = 0., z = 0., w = 0.)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}
	
	inline public function add(a:Vector4) : Vector4
	{
		return new Vector4(x + a.x, y + a.y, z + a.z, w + a.w);
	}
	
	inline static public function angleBetween(a:Vector4, b:Vector4) : Float
	{
		return Math.acos(a.dot(b) / (a.length * b.length));
	}
	
	inline public function clone() : Vector4
	{
		return new Vector4(x, y, z, w);
	}
	
	inline public function copyFrom(a:Vector4) : Vector4
	{
		x = a.x;
		y = a.y;
		z = a.z;
		w = a.w;
		return this;
	}
	
	inline public function decrementBy(a:Vector4) : Vector4
	{
		x -= a.x;
		y -= a.y;
		z -= a.z;
		w -= a.w;
		return this;
	}
	
	inline static public function distance(a:Vector4, b:Vector4) : Float
	{
		var x = a.x - b.x,
			y = a.y - b.y,
			z = a.z - b.z,
			w = a.w - b.w;
		
		return Math.sqrt(x * x + y * y + z * z + w * w);
	}
	
	inline public function dot(a:Vector4) : Float
	{
		return x * a.x + y * a.y + z * a.z + w * a.w;
	}
	
	inline public function equals(a:Vector4) : Bool
	{
		return x == a.x && y == a.y && z == a.z && w == a.w;
	}
	
	inline public function incrementBy(a:Vector4) : Vector4
	{
		x += a.x;
		y += a.y;
		z += a.z;
		w += a.w;
		return this;
	}
	
	inline public function nearEquals(a:Vector4, epsilon:Float) : Bool
	{
		return Math.abs(x - a.x) < epsilon
			&& Math.abs(y - a.y) < epsilon
			&& Math.abs(z - a.z) < epsilon
			&& Math.abs(w - a.w) < epsilon;
	}
	
	inline public function negate() : Vector4
	{
		x = -x;
		y = -y;
		z = -z;
		w = -w;
		return this;
	}
	
	inline public function normalize() : Float
	{
		var l = length;
		if(l != 0)
		{
			x /= l;
			y /= l;
			z /= l;
			w /= l;
		}
		return l;
	}
	
	inline public function scaleBy(v:Float) : Vector4
	{
		x *= v;
		y *= v;
		z *= v;
		w *= v;
		return this;
	}
	
	inline public function setTo(x:Float, y:Float, z:Float, w:Float) : Vector4
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
		return this;
	}
	
	inline public function sub(a:Vector4) : Vector4
	{
		return new Vector4(x - a.x, y - a.y, z - a.z, w - a.w);
	}
	
	inline public function toString() : String
	{
		return "Vector4(" + x + ", " + y + ", " + z + ", " + w + ")";
	}
}