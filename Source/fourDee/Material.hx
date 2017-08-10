package fourDee;

import fourDee.Object4D;
import fourDee.render.Camera;

import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;

class Material
{
	private var program:GLProgram;
	
	private function new()
	{
	}
	
	public function setupRender(gl:lime.graphics.GLRenderContext, obj:Object4D, glBuffer:GLBuffer, camera:Camera)
	{
		trace("Woops");
	}
	
	public function cleanupRender(gl:lime.graphics.GLRenderContext)
	{
	}
}