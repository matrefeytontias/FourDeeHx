package fourDee.math;

import fourDee.ds.Either;

/**
  * Defines a 4D vector, possibly expressed in the base
  * of an intersector.
  */
abstract Vector4D(Either<Vector3, Vector4>)
{
	@:allow(fourDee.math.Intersector)
	private var E(get, never):Either<Vector3, Vector4>;
	private function get_E() : Either<Vector3, Vector4>
	{
		return this;
	}
	
	public function new(v:Either<Vector3, Vector4>)
	{
		this = v;
	}
	
	@:from static public function fromL(a:Vector3)
	{
		return new Vector4D(Left(a));
	}
	
	@:from static public function fromR(a:Vector4)
	{
		return new Vector4D(Right(a));
	}
	
	@:to public function toL() : Vector3
	{
		switch(this)
		{
			case Left(a):
				return a;
			default:
				throw "Error : value is Right instead of Left";
		}
	}
	
	@:to public function toR() : Vector4
	{
		switch(this)
		{
			case Right(a):
				return a;
			default:
				throw "Error : value is Left instead of Right";
		}
	}
}