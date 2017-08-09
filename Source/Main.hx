import fourDee.Application;
import fourDee.math.*;
import fourDee.math.Matrix5.Rotation4D;

class Main extends Application
{
	public function new()
	{
		super();
		
		var v = new Vector4(1, 2, 3, 4);
		var m = new Matrix5();
		m.makeRotation(Rotation4D.XY, Math.PI / 2);
		var v2 = m * v;
		trace(v, v2);
	}
}