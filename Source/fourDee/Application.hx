package fourDee;

import lime.graphics.Renderer;
import lime.graphics.GLRenderContext;
import lime.ui.Window;

class Application extends lime.app.Application
{
	public var space4D(default, set):Space4D = null;
	private function set_space4D(v:Space4D) : Space4D
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
	
	override public function onWindowCreate(window:Window)
	{
		super.onWindowCreate(window);
		switch(window.renderer.context)
		{
			case OPENGL(gl):
			default:
				throw "Renderer is not OpenGL. Aborting";
		}
	}
	
	// Override this
	override public function update(dt:Int)
	{
		super.update(dt);
		space4D.update(dt);
	}
	
	override public function render(r:Renderer)
	{
		super.render(r);
		switch(r.context)
		{
			case OPENGL(gl):
				gl.viewport(0, 0, window.width, window.height);
				space4D.render(gl);
			default:
				throw "Renderer is not OpenGL. Aborting";
		}
	}
}