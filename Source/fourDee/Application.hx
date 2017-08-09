package fourDee;

import lime.graphics.Renderer;
import lime.graphics.RenderContext;

class Application extends lime.app.Application
{
	private var space4D(default, set):Space4D = null;
	private var set_space4D(v:Space4D) : Space4D
	{
		if(v != null)
		{
			if(window != null && window.renderer != null)
			{
				space4D = v;
				switch(renderer.context)
				{
					case OPENGL(gl):
						space4D.gl = gl;
					default:
						throw "Renderer is not OpenGL ; aborting";
				}
			}
			else
			{
				space4D = null;
				trace("No active window or renderer ; space4D cannot be set");
			}
		else
			space4D = null;
		return space4D;
	}
	
	public function new()
	{
		super();
		space4D = null;
	}
	
	// Override this
	override public function update(dt:Int)
	{
	}
	
	override public function render(r:Renderer)
	{
		space4D.render();
	}
}