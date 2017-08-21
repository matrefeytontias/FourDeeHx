package fourDee.math;

/**
  * Describes a vector in 4D space.
  */
class Vector4
{
	/**
	  * Canonical X axis.
	  */
	static public var X_AXIS = new Vector4(1, 0, 0, 0);
	/**
	  * Canonical Y axis.
	  */
	static public var Y_AXIS = new Vector4(0, 1, 0, 0);
	/**
	  * Canonical Z axis.
	  */
	static public var Z_AXIS = new Vector4(0, 0, 1, 0);
	/**
	  * Canonical W axis.
	  */
	static public var W_AXIS = new Vector4(0, 0, 0, 1);
	
	/**
	  * X coordinate of the vector.
	  */
	public var x:Float;
	/**
	  * Y coordinate of the vector.
	  */
	public var y:Float;
	/**
	  * Z coordinate of the vector.
	  */
	public var z:Float;
	/**
	  * W coordinate of the vector.
	  */
	public var w:Float;
	
	/**
	  * Component swizzling. Returns Vector3's based on the
	  * order of the components.
	  */
	public var xyz(get, never):Vector3;
	private function get_xyz() : Vector3
	{
		return new Vector3(x, y, z);
	}
	
	public var xyw(get, never):Vector3;
	private function get_xyw() : Vector3
	{
		return new Vector3(x, y, w);
	}
	
	public var xzw(get, never):Vector3;
	private function get_xzw() : Vector3
	{
		return new Vector3(x, z, w);
	}
	
	public var yzw(get, never):Vector3;
	private function get_yzw() : Vector3
	{
		return new Vector3(y, z, w);
	}
	
	/**
	  * Squared length of the vector.
	  */
	public var lengthSquared(get, never):Float;
	inline private function get_lengthSquared() : Float
	{
		return dot(this);
	}
	
	/**
	  * Length of the vector.
	  */
	public var length(get, never):Float;
	inline private function get_length() : Float
	{
		return Math.sqrt(lengthSquared);
	}
	
	/**
	  * @param	x	X coordinate
	  * @param	y	Y coordinate
	  * @param	z	Z coordinate
	  * @param	w	W coordinate
	  */
	public function new(x = 0., y = 0., z = 0., w = 0.)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}
	
	/**
	  * Adds a Vector4 to the vector.
	  * @param	a	Vector4 to add
	  * @return	the result of the operation as a new Vector4
	  */
	inline public function add(a:Vector4) : Vector4
	{
		return new Vector4(x + a.x, y + a.y, z + a.z, w + a.w);
	}
	
	/**
	  * Returns the angle between two Vector4.
	  * @param	a	first vector
	  * @param	b	second vector
	  * @return	angle in radians between a and b
	  */
	inline static public function angleBetween(a:Vector4, b:Vector4) : Float
	{
		return Math.acos(a.dot(b) / (a.length * b.length));
	}
	
	/**
	  * Returns a copy of the vector.
	  * @return	copy of the vector
	  */
	inline public function clone() : Vector4
	{
		return new Vector4(x, y, z, w);
	}
	
	/**
	  * Sets the contents of the vector to those
	  * of another Vector4.
	  * @param	a	source vector
	  * @return	this vector
	  */
	inline public function copyFrom(a:Vector4) : Vector4
	{
		x = a.x;
		y = a.y;
		z = a.z;
		w = a.w;
		return this;
	}
	
	/**
	  * Computes the 4D cross product of 3 vectors. It has all
	  * the properties of the 3D cross product of 2 vectors,
	  * including the fact that it is orthogonal to all 3 vectors
	  * that were used to calculate it.
	  */
	static public function crossProduct4D(v1:Vector4, v2:Vector4, v3:Vector4) : Vector4
	{
		var r = new Vector4();
		r.x = -v3.yzw.dotProduct(v1.yzw.crossProduct(v2.yzw));
		r.y = v3.xzw.dotProduct(v1.xzw.crossProduct(v2.xzw));
		r.z = -v3.xyw.dotProduct(v1.xyw.crossProduct(v2.xyw));
		r.w = v3.xyz.dotProduct(v1.xyz.crossProduct(v2.xyz));
		return r;
	}
	
	/**
	  * Subtracts another Vector4 to this vector in-place.
	  * @param	a	vector to subtract from this vector
	  * @return	this vector
	  */
	inline public function decrementBy(a:Vector4) : Vector4
	{
		x -= a.x;
		y -= a.y;
		z -= a.z;
		w -= a.w;
		return this;
	}
	
	/**
	  * Returns the distance between the points whose
	  * coordinates are given by two vectors.
	  * @param	a	vector 1
	  * @param	b	vector 2
	  * @return	distance between a and b
	  */
	inline static public function distance(a:Vector4, b:Vector4) : Float
	{
		var x = a.x - b.x,
			y = a.y - b.y,
			z = a.z - b.z,
			w = a.w - b.w;
		
		return Math.sqrt(x * x + y * y + z * z + w * w);
	}
	
	/**
	  * Performs a dot product between this vector and another.
	  * @param	a	other vector
	  * @return dot product between this vector and the other
	  */
	inline public function dot(a:Vector4) : Float
	{
		return x * a.x + y * a.y + z * a.z + w * a.w;
	}
	
	/**
	  * Checks for equality of two vectors.
	  * @param	a	other vector
	  * @return true if all 4 coordinates are equal, false otherwise
	  */
	inline public function equals(a:Vector4) : Bool
	{
		return x == a.x && y == a.y && z == a.z && w == a.w;
	}
	
	/**
	  * Adds another Vector4 to this vector in-place.
	  * @param	a	vector to add to this vector
	  * @return	this vector
	  */
	inline public function incrementBy(a:Vector4) : Vector4
	{
		x += a.x;
		y += a.y;
		z += a.z;
		w += a.w;
		return this;
	}
	
	/**
	  * Checks for near equality of two vectors.
	  * @param	a		other vector
	  * @param	epsilon	absolute error permitted on each coordinate
	  * @return true if all 4 coordinates are equal, plus or minus epsilon or less ; false otherwise
	  */
	inline public function nearEquals(a:Vector4, epsilon:Float) : Bool
	{
		return Math.abs(x - a.x) < epsilon
			&& Math.abs(y - a.y) < epsilon
			&& Math.abs(z - a.z) < epsilon
			&& Math.abs(w - a.w) < epsilon;
	}
	
	/**
	  * Negates this vector in-place.
	  * @return	this vector
	  */
	inline public function negate() : Vector4
	{
		x = -x;
		y = -y;
		z = -z;
		w = -w;
		return this;
	}
	
	/**
	  * Sets the length of this vector, given that
	  * it is non-zero. If this vector is zero, it
	  * remains unchanged.
	  * @param _l	target length
	  * @return	this vector
	  */
	inline public function normalize(_l:Float = 1.) : Float
	{
		var l = length;
		if(l != 0)
		{
			var nl = _l / l;
			x *= nl;
			y *= nl;
			z *= nl;
			w *= nl;
		}
		return l;
	}
	
	/**
	  * Multiplies this vector by a scalar in-place.
	  * @param	v	value of the scale
	  * @return	this vector
	  */
	inline public function scaleBy(v:Float) : Vector4
	{
		x *= v;
		y *= v;
		z *= v;
		w *= v;
		return this;
	}
	
	/**
	  * Sets the coordinates of this vector.
	  * @param	x	X coordinate
	  * @param	y	Y coordinate
	  * @param	z	Z coordinate
	  * @param	w	W coordinate
	  * @return	this vector
	  */
	inline public function setTo(x:Float, y:Float, z:Float, w:Float) : Vector4
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
		return this;
	}
	
	/**
	  * Returns the subtraction of a vector from this vector.
	  * @param	a	other vector
	  * @return	the result of the operation as a new Vector4
	  */
	inline public function sub(a:Vector4) : Vector4
	{
		return new Vector4(x - a.x, y - a.y, z - a.z, w - a.w);
	}
	
	inline public function toString() : String
	{
		return "Vector4(" + x + ", " + y + ", " + z + ", " + w + ")";
	}
}