package fourDee;

import fourDee.math.Vector4;
import fourDee.render.Face4;

class Geometry4D
{
	public var vertices:Array<Vector4>;
	public var faces:Array<Face4>;
	
	private function new(?v:Array<Vector4>, ?f:Array<Face4>)
	{
		vertices = v == null ? new Array<Vector4>() : v;
		faces = f == null ? new Array<Face4>() : f;
	}
}