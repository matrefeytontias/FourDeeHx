import fourDee.Application;
import fourDee.math.*;

class Main extends Application
{
	public function new()
	{
		super();
		
		var v = new Vector4();
		var e = new Euler4(Math.PI / 2);
		e.center.x = -1.;
		var m = e.makeMatrix();
		trace(m);
		trace(m * v);
	}
}