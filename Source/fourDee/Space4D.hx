package fourDee;

import fourDee.render.Camera;
import fourDee.render.ObjectSlice3D;

import lime.graphics.opengl.GL;
import lime.graphics.GLRenderContext;

/**
  * Describes a 4D space and all the 4D objects
  * in it. Takes care of the rendering of said
  * 4D objects on a specific part of the screen.
  */
class Space4D
{
	/**
	  * TODO
	  */
	public var renderX:Int = 0;
	public var renderY:Int = 0;
	public var renderWidth:Int;
	public var renderHeight:Int;
	
	private var objects:Array<Object4D> = new Array<Object4D>();
	private var slices:Array<ObjectSlice3D> = new Array<ObjectSlice3D>();
	
	public var camera(default, null):Camera;
	
	/**
	  * @param	w	width in pixels of the viewport
	  * @param	h	height in pixels of the viewport
	  * @param	x	x coordinate in pixels of the top-left corner of the viewport
	  * @param	y	y coordinate in pixels of the top-left corner of the viewport
	  */
	public function new(w:Int, h:Int, x:Int = 0, y:Int = 0)
	{
		renderWidth = w;
		renderHeight = h;
		renderX = x;
		renderY = y;
		// GL.enable(GL.SCISSOR_TEST);
	}
	
	/**
	  * Call this upon changing the dimensions of
	  * the Space4D's viewport programmatically.
	  */
	inline public function updateScreenRegion()
	{
		// GL.scissor(renderX, renderY, renderWidth, renderHeight);
	}
	
	/**
	  * Adds a 4D object to the 4D space for
	  * further rendering.
	  * @param	obj	4D object to add to the space
	  */
	inline public function add(obj:Object4D)
	{
		objects.push(obj);
	}
	
	/**
	  * Removes a 4D object from the 4D space. Has
	  * no effect if the object was not previously
	  * added.
	  * @param	obj	4D object to remove from the space
	  */
	inline public function remove(obj:Object4D)
	{
		objects.remove(obj);
	}
	
	/**
	  * Attach a Camera object to the space. The 4D
	  * space is seen through the eye of this camera.
	  * @param	cam	Camera object to use to render this space
	  */
	inline public function attachCamera(cam:Camera)
	{
		camera = cam;
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
	  * @param	gl	target OpenGL rendering context
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