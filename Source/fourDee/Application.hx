package fourDee;

import lime.graphics.Renderer;
import lime.graphics.GLRenderContext;
import lime.graphics.opengl.GL;
import lime.ui.Window;

/**
  * Base class of all FourDee applications. Your main class must
  * extend this.
  */
class Application extends lime.app.Application
{
	/**
	  * Currently active 4D space.
	  */
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
	
	/**
	  * Background color of the application.
	  */
	public var color(default, set):Int = 0;
	private function set_color(v:Int) : Int
	{
		GL.clearColor((v >> 16) / 255, ((v >> 8) & 0xff) / 255, (v & 0xff) / 255, alpha);
		return color = v;
	}
	
	/**
	  * Alpha value of the background color.
	  */
	public var alpha(default, set):Float = 1.;
	private function set_alpha(v:Float) : Float
	{
		alpha = Math.min(1, Math.max(0, v));
		color = color; // update background alpha
		return alpha;
	}
	
	public function new()
	{
		super();
		space4D = null;
		GL.clearColor(0, 0, 0, 1);
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
	
	override public function update(dt:Int)
	{
		super.update(dt);
		space4D.update(dt);
	}
	
	@:final
	override public function render(r:Renderer)
	{
		super.render(r);
		switch(r.context)
		{
			case OPENGL(gl):
				gl.viewport(0, 0, window.width, window.height);
				gl.clear(gl.COLOR_BUFFER_BIT);
				space4D.render(gl);
			default:
				throw "Renderer is not OpenGL. Aborting";
		}
	}
}