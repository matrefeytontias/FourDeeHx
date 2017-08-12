package fourDee;

import fourDee.render.Camera;
import fourDee.render.ObjectSlice3D;

import lime.graphics.opengl.GL;
import lime.graphics.GLRenderContext;

class Space4D
{
	public var renderX:Int = 0;
	public var renderY:Int = 0;
	public var renderWidth:Int;
	public var renderHeight:Int;
	
	private var objects:Array<Object4D> = new Array<Object4D>();
	private var slices:Array<ObjectSlice3D> = new Array<ObjectSlice3D>();
	
	public var camera:Camera;
	public var gl:GLRenderContext;
	
	public function new(w:Int, h:Int, x:Int = 0, y:Int = 0)
	{
		renderWidth = w;
		renderHeight = h;
		renderX = x;
		renderY = y;
		// GL.enable(GL.SCISSOR_TEST);
	}
	
	inline public function updateScreenRegion()
	{
		// GL.scissor(renderX, renderY, renderWidth, renderHeight);
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
	
	inline public function update(dt:Int)
	{
		camera.update(dt);
	}
	
	/**
	  * Renders all the 4D objects in the space.
	  * 4D rendering is in two major steps :
	  * - intersector operation : the intersector calculates the
	  *   3D slices of the 4D objects and arranges them into 3D triangles
	  *   for the renderer to draw. The intersector is attached to the
	  *   camera
	  * - 3D rendering : actual rendering of the 3D slices
	  */
	inline public function render(gl)
	{
		for(k in 0 ... slices.length)
			slices.pop();
		for(o in objects)
			camera.intersect(o, slices);
		for(s in slices)
			s.render(gl, camera);
	}
}