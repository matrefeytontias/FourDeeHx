package fourDee.objects;

import fourDee.Application;
import fourDee.Material;
import fourDee.Object4D;
import fourDee.render.Camera;

import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLUniformLocation;
import lime.utils.Float32Array;

using fourDee.objects.Box;

class Box extends Object4D
{
	static private var vertices = [ -1 / 2, -1 / 2, 1 / 2,
		1 / 2, -1 / 2, 1 / 2,
		1 / 2, 1 / 2, 1 / 2,
		-1 / 2, 1 / 2, 1 / 2,
		-1 / 2, -1 / 2, -1 / 2,
		1 / 2, -1 / 2, -1 / 2,
		1 / 2, 1 / 2, -1 / 2,
		-1 / 2, 1 / 2, -1 / 2
	];
	
	static private var faces = [ 0, 1, 2, 0, 2, 3,
		4, 6, 5, 4, 7, 6,
		0, 3, 7, 0, 7, 4,
		1, 6, 2, 1, 5, 6,
		2, 6, 7, 2, 7, 3,
		1, 0, 4, 1, 4, 5
	];
	
	static private var normals = [ 0., 0, 1, 0, 0, 1,
		0, 0, -1, 0, 0, -1,
		-1, 0, 0, -1, 0, 0,
		1, 0, 0, 1, 0, 0,
		0, 1, 0, 0, 1, 0,
		0, -1, 0, 0, -1, 0
	];
	
	public var width:Float;
	public var height:Float;
	public var depth:Float;
	public var material:Material;
	
	private var glBuffer:GLBuffer;
	
	public function new(w:Float, h:Float, d:Float, m:Material)
	{
		super();
		width = w;
		height = h;
		depth = d;
		material = m;
		
		scale.x = w;
		scale.y = h;
		scale.z = d;
		
		// GL buffer setup
		var temp = new Array<Float>();
		for(k in 0 ... faces.length)
		{
			var i = faces[k] * 3;
			temp.pushVec3(vertices, i);
			i = Std.int(k / 3) * 3;
			temp.pushVec3(normals, i);
		}
		
		glBuffer = GL.createBuffer();
		GL.bindBuffer(GL.ARRAY_BUFFER, glBuffer);
		GL.bufferData(GL.ARRAY_BUFFER, temp.length * 4, new Float32Array(temp), GL.STATIC_DRAW);
		GL.bindBuffer(GL.ARRAY_BUFFER, null);
	}
	
	static inline private function pushVec3(a:Array<Float>, tab:Array<Float>, i:Int)
	{
		a.push(tab[i]);
		a.push(tab[i + 1]);
		a.push(tab[i + 2]);
	}
	
	override public function render(gl, camera)
	{
		material.setupRender(gl, this, glBuffer, camera);
		gl.drawArrays(GL.TRIANGLES, 0, 12 * 3);
		material.cleanupRender(gl);
	}
}