package fourDee;

import fourDee.render.Camera;

import lime.graphics.opengl.GL;
import lime.graphics.GLRenderContext;

class Space4D
{
	public var renderX:Int = 0;
	public var renderY:Int = 0;
	public var renderWidth:Int;
	public var renderHeight:Int;
	
	private var objects:Array<Object4D> = new Array<Object4D>();
	private var camera:Camera;
	
	@:allow(fourDee.Application)
	private var gl:GLRenderContext;
	
	public function new(w:Int, h:Int, x:Int = 0, y:Int = 0)
	{
		renderWidth = w;
		renderHeight = h;
		renderX = x;
		renderY = y;
		GL.enable(GL.SCISSOR_TEST);
		updateScreenRegion();
	}
	
	inline public function updateScreenRegion()
	{
		GL.scissor(renderX, renderY, renderWidth, renderHeight);
	}
	
	inline public function add(o:Object4D)
	{
		objects.push(o);
	}
	
	inline public function remove(o:Object4D)
	{
		objects.remove(o);
	}
	
	inline public function attachCamera(c:Camera)
	{
		camera = c;
	}
	
	inline public function render()
	{
		for(o in objects)
			o.render(camera);
	}
}