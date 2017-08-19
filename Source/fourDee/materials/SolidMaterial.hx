package fourDee.materials;

import fourDee.Material;
import fourDee.objects.Box;
import fourDee.render.Camera;
import fourDee.render.ObjectSlice3D;

import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLUniformLocation;
import lime.math.Matrix4;

/**
  * Material with a solid color ; does not take
  * any lighting into account and does not cast
  * shadows.
  */
class SolidMaterial extends Material
{
	inline static private var solidVert =
		"
		attribute vec3 aPosition;
		uniform mat4 mat;
		uniform mat4 rmat;
		
		void main()
		{
			gl_Position = mat * vec4(aPosition, 1.);
		}
		";
	inline static private var solidFrag =
#if !desktop
		"precision mediump float;" +
#end
		"
			uniform vec4 color;
			
			void main()
			{
				gl_FragColor = color;
			}
		";
	
	/**
	  * Solid color of the material.
	  */
	public var color:Int;
	
	private var glUColor:GLUniformLocation;
	
	/**
	  * @param	c	color of the material
	  */
	public function new(c:Int)
	{
		super(solidVert, solidFrag);
		color = c;
		glUColor = GL.getUniformLocation(program, "color");
	}
	
	override public function setupRender(gl:lime.graphics.GLRenderContext, obj:ObjectSlice3D, glBuffer:GLBuffer, camera:Camera)
	{
		super.setupRender(gl, obj, glBuffer, camera);
		gl.uniform4f(glUColor, (color >> 16) / 255, ((color >> 8) & 0xff) / 255, (color & 0xff) / 255, 1.);
	}
}