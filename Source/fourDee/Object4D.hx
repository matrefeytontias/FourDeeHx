package fourDee;

import fourDee.math.Euler4;
import fourDee.math.Vector4;
import fourDee.objects.Camera;
import fourDee.render.RenderMethod;

/**
  * Base class for 4D objects in 4D space.
  */
class Object4D
{
	/**
	  * Position in 4D space.
	  */
	public var position:Vector4 = new Vector4();
	/**
	  * Angles on the 6 planes of rotation of 4D space.
	  */
	public var rotation:Euler4 = new Euler4();
	/**
	  * Scaling factors along every axis.
	  */
	public var scale:Vector4 = new Vector4(1., 1., 1., 1.);
	
	/**
	  * Whether the object can be rendered by intersection.
	  * This is true when the 4D object has a "geometry"
	  * and a "material" field.
	  */
	public var intersectable(get, never):Bool;
	private function get_intersectable() : Bool
	{
		return Reflect.field(this, "geometry") != null && Reflect.field(this, "material") != null;
	}
	
	/**
	  * Tells the engine how to render the object.
	  */
	public var renderMethod:RenderMethod = RenderMethod.None;
	
	private function new()
	{
	}
	
	/**
	  * Called every frame. Override this in your
	  * own Object4D child classes.
	  * @param	dt	milliseconds since last frame
	  */
	public function update(dt:Int)
	{
	}
	
	/**
	  * Called every frame. Override this in your
	  * own Object4D child classes.
	  * @param	gl		target OpenGL rendering context
	  * @param	camera	active Camera object
	  */
	public function render(gl:lime.graphics.GLRenderContext, camera:Camera)
	{
	}
}
