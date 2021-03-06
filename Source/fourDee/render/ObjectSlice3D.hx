package fourDee.render;

import fourDee.Material;
import fourDee.math.Vector3;
import fourDee.objects.Camera;

import lime.graphics.GLRenderContext;
import lime.graphics.opengl.GLBuffer;
import lime.utils.Float32Array;

using fourDee.render.ObjectSlice3D;

/**
  * Container class for bunches of 3D, ready-to-render triangles.
  * Used as a way to display the result of the intersector's operation,
  * meaning that those are 3D objects, with 3D coordinates expressed in
  * the intersector's base.
  * They are flushed as soon as the intersector changes direction or origin.
  */
class ObjectSlice3D
{
	private var glBuffer:GLBuffer;
	
	/**
	  * Vertices of the object.
	  */
	public var vertices:Array<Vector3>;
	/**
	  * Triangular faces of the object.
	  */
	public var faces:Array<Face3>;
	// True for edge smoothing : TODO
	public var interpolateNormals:Bool = false;
	/**
	  * Material used to render this slice.
	  */
	public var material:Material;
	
	public function new(?v, ?f, ?m)
	{
		vertices = v == null ? new Array<Vector3>() : v;
		faces = f == null ? new Array<Face3>() : f;
		material = m;
	}
	
	public function render(gl:GLRenderContext, camera:Camera)
	{
		if(vertices.length > 0)
		{
			var temp = new Array<Float>();
			for(f in faces)
			{
				var v1 = vertices[f.a],
					v2 = vertices[f.b],
					v3 = vertices[f.c];
				var n = v2.subtract(v1).crossProduct(v3.subtract(v1));
				n.normalize();
				temp.pushVec3(v1);
				temp.pushVec3(n);
				temp.pushVec3(v2);
				temp.pushVec3(n);
				temp.pushVec3(v3);
				temp.pushVec3(n);
			}
			
			glBuffer = gl.createBuffer();
			gl.bindBuffer(gl.ARRAY_BUFFER, glBuffer);
			gl.bufferData(gl.ARRAY_BUFFER, temp.length * 4, new Float32Array(temp), gl.STATIC_DRAW);
			gl.bindBuffer(gl.ARRAY_BUFFER, null);
			
			material.setupRender(gl, this, glBuffer, camera);
			gl.drawArrays(gl.TRIANGLES, 0, faces.length * 3);
			material.cleanupRender(gl);
		}
	}
	
	static inline private function pushVec3(a:Array<Float>, v:Vector3)
	{
		a.push(v.x);
		a.push(v.y);
		a.push(v.z);
	}
}
