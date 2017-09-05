package fourDee;

import fourDee.objects.Camera;
import fourDee.render.ObjectSlice3D;

import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLUniformLocation;
import lime.math.Matrix4;
import lime.math.Vector4;
import lime.utils.GLUtils;

/**
  * Base class for the rendering of 3D slices of
  * 4D objects. This describes how the triangles
  * resulting from the slicing are drawn.
  */
class Material
{
	// Material expects vertex attributes for
	// position and normal by default. Geometries
	// are always expected to provide them.
	private var program:GLProgram;
	private var glAPosition:Int;
	private var glANormal:Int;
	private var glUMat:GLUniformLocation;
	
	private function new(d:{vertex:String, fragment:String})
	{
		program = GLUtils.createProgram(d.vertex, d.fragment);
		glAPosition = GL.getAttribLocation(program, "aPosition");
		glANormal = GL.getAttribLocation(program, "aNormal");
		if(glAPosition >= 0)
			GL.enableVertexAttribArray(glAPosition);
		if(glANormal >= 0)
			GL.enableVertexAttribArray(glANormal);
		glUMat = GL.getUniformLocation(program, "mat");
	}
	
	/**
	  * Setup the shader program for rendering a particular object slice.
	  * @param	gl			target OpenGL rendering context
	  * @param	obj			object slice being rendered
	  * @param	glBuffer	buffered data of the current object slice
	  * @param	camera		active Camera object
	  */
	public function setupRender(gl:lime.graphics.GLRenderContext, obj:ObjectSlice3D, glBuffer:GLBuffer, camera:Camera)
	{
		gl.useProgram(program);
		gl.bindBuffer(gl.ARRAY_BUFFER, glBuffer);
		if(glAPosition >= 0)
			gl.vertexAttribPointer(glAPosition, 3, gl.FLOAT, false, 6 * 4, 0);
		if(glANormal >= 0)
			gl.vertexAttribPointer(glANormal, 3, gl.FLOAT, false, 6 * 4, 3 * 4);
		var mat = camera.matrix3D.clone();
		mat.append(camera.pmat);
		gl.uniformMatrix4fv(glUMat, 1, false, mat);
	}
	
	/**
	  * Performs any necessary cleaning after a render pass.
	  * @param	gl	target OpenGL rendering context
	  */
	public function cleanupRender(gl:lime.graphics.GLRenderContext)
	{
		gl.bindBuffer(gl.ARRAY_BUFFER, null);
	}
}