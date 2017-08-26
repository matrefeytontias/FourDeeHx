package fourDee.render;

import fourDee.objects.Camera;

import lime.graphics.GLRenderContext;

/**
  * Lists the different render methods for objects.
  */
enum RenderMethod
{
	/**
	  * Do not render the object at all.
	  */
	None;
	/**
	  * Slice the object into an ObjectSlice3D for rendering.
	  */
	Intersect;
	/**
	  * Render the object by calling a render callback.
	  */
	Custom(cb:GLRenderContext -> Camera -> Void);
}
