package fourDee.math;

import haxe.ds.Vector;

enum Rotation4D
{
	XY;
	XZ;
	XW;
	YZ;
	YW; 
	ZW;
}

@:forward(get, set, toArray)
abstract Matrix5(Vector<Float>)
{
	public function new(?e:Array<Float>)
	{
		this = new Vector<Float>(25);
		if(e != null)
		{
			if(e.length != 25)
				throw "new Matrix5: elements array must contain 25 values";
			for(k in 0 ... 25)
				this[k] = e[k];
		}
		else
		{
			identity();
		}
	}
	
	@:op(A + B) public function add(b:Matrix5) : Matrix5
	{
		var r = new Matrix5();
		for(k in 0 ... 25)
			r[k] = this[k] + b[k];
		return r;
	}
	
	@:op(A * B) public function applyToVec4(v:Vector4) : Vector4
	{
		var temp = new Vector4();
		// Basically a multiplication by a Vector5 with t = 1
		temp.x = this[0] * temp.x + this[1] * temp.y + this[2] * temp.z + this[3] * temp.w + this[4];
		temp.y = this[5] * temp.x + this[6] * temp.y + this[7] * temp.z + this[8] * temp.w + this[9];
		temp.z = this[10] * temp.x + this[11] * temp.y + this[12] * temp.z + this[13] * temp.w + this[14];
		temp.w = this[15] * temp.x + this[16] * temp.y + this[17] * temp.z + this[18] * temp.w + this[19];
		var t = this[20] * temp.x + this[21] * temp.y + this[22] * temp.z + this[23] * temp.w + this[24];
		temp.scaleBy(1 / t);
		return temp;
	}
	
	public function clone() : Matrix5
	{
		return new Matrix5(this.toArray());
	}
	
	public function identity()
	{
		this[0] = this[6] = this[12] = this[18] = this[24] = 1.;
		this[1] = this[2] = this[3] = this[4] = this[5] = 0.;
		this[7] = this[8] = this[9] = this[10] = this[11] = 0.;
		this[13] = this[14] = this[15] = this[16] = this[17] = 0.;
		this[19] = this[20] = this[21] = this[22] = this[23] = 0.;
	}
	
	public function makeRotation(r:Rotation4D, theta:Float)
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
		this[i * 5 + j] = s;
		this[j * 5 + i] = -s;
	}
	
	@:op(A * B) public function multiply(b:Matrix5) : Matrix5
	{
		var r = new Matrix5();
		for(i in 0 ... 5)
		{
			for(j in 0 ... 5)
			{
				var cell:Float = 0.;
				for(k in 0 ... 5)
				{
					cell += this[i * 5 + k] * b[k * 5 + j];
				}
				r[i * 5 + j] = cell;
			}
		}
		return r;
	}
	
	public function negate()
	{
		for(k in 0 ... 25)
			this[k] = -this[k];
	}
	
	inline public function postMultiply(v:Vector4) : Vector4
	{
		return transposed() * v;
	}
	
	public function transpose()
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
	}
	
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
	
	@:op(-A) public function unaryNeg() : Matrix5
	{
		var r = new Matrix5();
		for(k in 0 ... 25)
			r[k] = -this[k];
		return r;
	}
}