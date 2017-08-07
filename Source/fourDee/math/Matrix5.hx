package fourDee.math;

import haxe.ds.Vector;

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
			this[0] = this[6] = this[12] = this[18] = this[24] = 1.;
#if !cpp
			this[1] = this[2] = this[3] = this[4] = this[5] = 0.;
			this[7] = this[8] = this[9] = this[10] = this[11] = 0.;
			this[13] = this[14] = this[15] = this[16] = this[17] = 0.;
			this[19] = this[20] = this[21] = this[22] = this[23] = 0.;
#end
		}
	}
	
	public function clone() : Matrix5
	{
		return new Matrix5(this.toArray());
	}
}