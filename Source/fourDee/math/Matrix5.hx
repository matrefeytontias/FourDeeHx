package fourDee.math;

import haxe.ds.Vector;

/**
  * Designates 4D rotation planes.
  */
enum Rotation4D
{
	XY;
	XZ;
	XW;
	YZ;
	YW; 
	ZW;
}

/**
  * 5x5 square matrix. Used to hold 4D affine transformations,
  * such as rotation, translation and scaling.
  */
@:forward(toArray)
abstract Matrix5(Vector<Float>)
{
	@:from
	static inline public function fromVector(v:Vector<Float>)
	{
		return new Matrix5(v);
	}
	
	/**
	  * @param	v	Vector of 25 floats to fill the matrix with (optional)
	  * @param	e	Array of 25 floats to fill the matrix with (optional)
	  */
	inline public function new(?v:Vector<Float>, ?e:Array<Float>)
	{
		if(v == null)
		{
			this = new Vector<Float>(25);
			if(e == null)
				identity();
			else
			{
				if(e.length != 25)
					throw "new Matrix5: elements array must contain 25 values";
				for(k in 0 ... 25)
					v[k] = e[k];
			}
		}
		else if(v.length == 25)
			this = v;
		else throw "new Matrix5: initialization vector must contain 25 values";
	}
	
	/**
	  * Term-by-term addition ; does not change the current matrix.
	  * Use as + operator.
	  * @param	b	matrix to add to the current one
	  * @return	new Matrix5 containing the result of the operation
	  */
	@:op(A + B) inline public function add(b:Matrix5) : Matrix5
	{
		var r = new Matrix5();
		for(k in 0 ... 25)
			r[k] = this[k] + b[k];
		return r;
	}
	
	/**
	  * Applies the transformations described by the matrix to
	  * a Vector4 object. Use as * operator between a Matrix5
	  * and a Vector4, in that order.
	  * @param	v	Vector4 to apply the matrix to
	  * @return	a new Vector4 that is the result of the operation
	  */
	@:op(A * B) public function applyToVec4(v:Vector4) : Vector4
	{
		var temp = new Vector4();
		// Basically a multiplication by a Vector5 with t = 1
		temp.x = this[0] * v.x + this[1] * v.y + this[2] * v.z + this[3] * v.w + this[4];
		temp.y = this[5] * v.x + this[6] * v.y + this[7] * v.z + this[8] * v.w + this[9];
		temp.z = this[10] * v.x + this[11] * v.y + this[12] * v.z + this[13] * v.w + this[14];
		temp.w = this[15] * v.x + this[16] * v.y + this[17] * v.z + this[18] * v.w + this[19];
		var t = this[20] * v.x + this[21] * v.y + this[22] * v.z + this[23] * v.w + this[24];
		temp.scaleBy(1 / t);
		return temp;
	}
	
	/**
	  * Returns a copy of the matrix.
	  * @return	a copy of the matrix
	  */
	public function clone() : Matrix5
	{
		return new Matrix5(this.toArray());
	}
	
	@:arrayAccess public function get(i:Int) : Float
	{
		return this.get(i);
	}
	
	/**
	  * Sets the matrix to the 5x5 identity.
	  */
	public function identity() : Matrix5
	{
		this[0] = this[6] = this[12] = this[18] = this[24] = 1.;
		this[1] = this[2] = this[3] = this[4] = this[5] = 0.;
		this[7] = this[8] = this[9] = this[10] = this[11] = 0.;
		this[13] = this[14] = this[15] = this[16] = this[17] = 0.;
		this[19] = this[20] = this[21] = this[22] = this[23] = 0.;
		return this;
	}
	
	/**
	  * Sets this matrix to be a specific 4D rotation.
	  * @param	r		rotation plane used to set this matrix
	  * @param	theta	angle of the rotation
	  * @return	this matrix after being set to the rotation
	  */
	public function makeRotation(r:Rotation4D, theta:Float) : Matrix5
	{
		identity();
		var c = Math.cos(theta), s = Math.sin(theta);
		var i, j;
		switch(r)
		{
			case XY:
				i = 0; j = 1;
			case XZ:
				i = 0; j = 2;
			case XW:
				i = 0; j = 3;
			case YZ:
				i = 1; j = 2;
			case YW:
				i = 1; j = 3;
			case ZW:
				i = 2; j = 3;
		}
		this[i * 6] = this[j * 6] = c;
		this[j * 5 + i] = s;
		this[i * 5 + j] = -s;
		return this;
	}
	
	/**
	  * Performs matrix multiplication between two Matrix5. The
	  * operation is non-commutative.
	  * Use as * operator between two Matrix5.
	  * @param	b	other matrix
	  * @return	new Matrix5 containing the result of the operation
	  */
	@:op(A * B) public function multiply(b:Matrix5) : Matrix5
	{
		var r = new Matrix5();
		for(i in 0 ... 5)
		{
			for(j in 0 ... 5)
			{
				var cell:Float = 0.;
				for(k in 0 ... 5)
					cell += this[i * 5 + k] * b[k * 5 + j];
				r[i * 5 + j] = cell;
			}
		}
		return r;
	}
	
	/**
	  * Negates all the cells of the matrix.
	  * @return this matrix after negation
	  */
	inline public function negate() : Matrix5
	{
		for(k in 0 ... 25)
			this[k] = -this[k];
		return this;
	}
	
	/**
	  * Post-multiplies a Vector4 by the matrix, effectively
	  * applying the transposed matrix to the vector. Use as
	  * * operator, between a Vector4 and a Matrix5 in that
	  * order.
	  * @param	v	Vector4 operand
	  * @param	m	Matrix5 operand
	  *	@return	a new Vector4 containing the result of the operation
	  */
	@:op(A * B) inline static public function postMultiply(v:Vector4, m:Matrix5) : Vector4
	{
		return m.transposed() * v;
	}
	
	/**
	  * Appends a scale operation to the matrix.
	  * @param	x	scale along the X axis
	  * @param	y	scale along the Y axis
	  * @param	z	scale along the Z axis
	  * @param	w	scale along the W axis
	  * @return	this matrix after the scale operation
	  */
	inline public function scale(x = 1., y = 1., z = 1., w = 1.) : Matrix5
	{
		this[0] *= x;
		this[6] *= y;
		this[12] *= z;
		this[18] *= w;
		return this;
	}
	
	@:arrayAccess inline public function set(index:Int, v:Float) : Float
	{
		return this[index] = v;
	}
	
	inline public function toString() : String
	{
		var r = "[ ";
		for(i in 0 ... 5)
		{
			for(j in 0 ... 5)
			{
				r += this[i * 5 + j] + ", ";
			}
			r += i < 4 ? "\n" : "]";
		}
		return r;
	}
	
	/**
	  * Appends a translation operation to the matrix.
	  * @param	x	translation along the X axis
	  * @param	y	translation along the Y axis
	  * @param	z	translation along the Z axis
	  * @param	w	translation along the W axis
	  * @return this matrix after the translation operation
	  */
	inline public function translate(x = 0., y = 0., z = 0., w = 0.) : Matrix5
	{
		this[4] += x;
		this[9] += y;
		this[14] += z;
		this[19] += w;
		return this;
	}
	
	/**
	  * Appends a translation given by a Vector4 to the
	  * matrix.
	  * @param	v	Vector4 describing the translation
	  * @return this matrix after the translation operation
	  */
	@:op(A + B) inline public function translateVec(v:Vector4) : Matrix5
	{
		return translate(v.x, v.y, v.z, v.w);
	}
	
	/**
	  * Appends a translation given by the negation of a
	  * Vector4 to the matrix.
	  * @param	v	Vector4 describing the translation
	  * @return this matrix after the translation operation
	  */
	@:op(A - B) inline public function translateMinusVec(v:Vector4) : Matrix5
	{
		return translate(-v.x, -v.y, -v.z, -v.w);
	}
	
	/**
	  * Transposes the matrix in-place.
	  * @return	this matrix after the transpose operation
	  */
	public function transpose() : Matrix5
	{
		var t:Float;
		for(i in 0 ... 5)
		{
			for(j in i + 1 ... 5)
			{
				t = this[i * 5 + j];
				this[i * 5 + j] = this[j * 5 + i];
				this[j * 5 + i] = t;
			}
		}
		return this;
	}
	
	/**
	  * Return the transposed matrix. This does not
	  * modify the matrix.
	  * @return	the transposed matrix.
	  */
	public function transposed() : Matrix5
	{
		var r = new Matrix5();
		for(i in 0 ... 5)
		{
			r[i * 6] = this[i * 6]; // i * 5 + i
			for(j in i + 1 ... 5)
			{
				r[i * 5 + j] = this[j * 5 + i];
				r[j * 5 + i] = this[i * 5 + j];
			}
		}
		return r;
	}
	
	/**
	  * Returns the negation of the matrix. This does
	  * not modify the matrix. Use as unary - operator.
	  * @return	the negation of the matrix
	  */
	@:op(-A) public function unaryNeg() : Matrix5
	{
		var r = new Matrix5();
		for(k in 0 ... 25)
			r[k] = -this[k];
		return r;
	}
}