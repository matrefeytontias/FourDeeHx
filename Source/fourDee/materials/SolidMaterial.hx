package fourDee.materials;

import fourDee.Application;
import fourDee.Material;
import fourDee.render.Camera;

import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLUniformLocation;
import lime.math.Matrix4;
import lime.math.Vector4;
import lime.utils.GLUtils;
import lime.utils.Float32Array;

class SolidMaterial extends Material
{
	inline static private var solidVert =
		"
		attribute vec3 aPosition;
		uniform mat4 mat;
		
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
	
	public var color:Int;
	
	private var glAPosition:Int;
	private var glUMat:GLUniformLocation;
	private var glUColor:GLUniformLocation;
	
	public function new(c:Int)
	{
		super();
		color = c;
		program = GLUtils.createProgram(solidVert, solidFrag);
		glAPosition = GL.getAttribLocation(program, "aPosition");
		GL.enableVertexAttribArray(glAPosition);
		glUMat = GL.getUniformLocation(program, "mat");
		glUColor = GL.getUniformLocation(program, "color");
	}
	
	override public function setupRender(gl:lime.graphics.GLRenderContext, obj:Object4D, glBuffer:GLBuffer, camera:Camera)
	{
		gl.useProgram(program);
		gl.bindBuffer(gl.ARRAY_BUFFER, glBuffer);
		gl.vertexAttribPointer(glAPosition, 3, gl.FLOAT, false, 6 * 4, 0);
		gl.uniform4f(glUColor, (color >> 16) / 255, ((color >> 8) & 0xff) / 255, (color & 0xff) / 255, 1.);
		var mat = camera.matrix3D;
		var pos = new Vector4(obj.position.x, obj.position.y, obj.position.z, 1.);
		mat.append(camera.pmat);
		var v = mat.transformVector(pos);
		mat.prependTranslation(v.x, v.y, v.z);
		gl.uniformMatrix4fv(glUMat, 1, false, mat);
	}
	
	override public function cleanupRender(gl:lime.graphics.GLRenderContext)
	{
		gl.bindBuffer(gl.ARRAY_BUFFER, null);
	}
}