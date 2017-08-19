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
  * Material with basic lighting capabilities. Applies
  * a Lambert model, where the illumination of a pixel
  * is relative to the angle between the face's normal
  * and the direction to the light source.
  */
class LambertMaterial extends Material
{
	inline static private var lambertVert =
		"
		attribute vec3 aPosition;
		attribute vec3 aNormal;
		
		uniform mat4 mat;
		
		varying vec3 position;
		varying vec3 normal;
		
		void main()
		{
			normal = aNormal;
			position = aPosition;
			gl_Position = mat * vec4(aPosition, 1.);
		}
		";
	inline static private var lambertFrag =
#if !desktop
		"precision mediump float;" +
#end
		"
			uniform vec4 color;
			uniform float diffuse;
			
			varying vec3 position;
			varying vec3 normal;
			
			void main()
			{
				float shade = dot(-normalize(position), normal) * diffuse;
				gl_FragColor = vec4(color.rgb * shade, color.a);
			}
		";
	
	public var color:Int;
	public var diffuse:Float;
	
	private var glUColor:GLUniformLocation;
	private var glUDiffuse:GLUniformLocation;
	
	/**
	  * @param	c	color of the material
	  * @param	d	diffusion coefficient
	  */
	public function new(c:Int, d:Float = 1.)
	{
		super(lambertVert, lambertFrag);
		color = c;
		diffuse = d;
		glUColor = GL.getUniformLocation(program, "color");
		glUDiffuse = GL.getUniformLocation(program, "diffuse");
	}
	
	override public function setupRender(gl:lime.graphics.GLRenderContext, obj:ObjectSlice3D, glBuffer:GLBuffer, camera:Camera)
	{
		super.setupRender(gl, obj, glBuffer, camera);
		gl.uniform4f(glUColor, (color >> 16) / 255, ((color >> 8) & 0xff) / 255, (color & 0xff) / 255, 1.);
		gl.uniform1f(glUDiffuse, diffuse);
	}
}