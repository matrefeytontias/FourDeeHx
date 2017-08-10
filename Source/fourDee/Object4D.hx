package fourDee;

import fourDee.math.Euler4;
import fourDee.math.Vector4;
import fourDee.render.Camera;

class Object4D
{
	public var position:Vector4 = new Vector4();
	public var rotation:Euler4 = new Euler4();
	public var scale:Vector4 = new Vector4(1., 1., 1., 1.);
	
	private function new()
	{
	}
	
	// Override these
	public function update(dt:Int)
	{
	}
	
	public function render(gl:lime.graphics.GLRenderContext, camera:Camera)
	{
	}
}
