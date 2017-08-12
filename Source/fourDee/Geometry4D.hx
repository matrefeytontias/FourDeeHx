package fourDee;

import fourDee.math.Vector4;
import fourDee.render.Face3;
import fourDee.render.Cell4;

typedef Vector3 = lime.math.Vector4;

class Geometry4D
{
	public var vertices:Array<Vector4>;
	public var cells:Array<Cell4>;
	
	private function new(?v:Array<Vector4>, ?c:Array<Cell4>)
	{
		vertices = v == null ? new Array<Vector4>() : v;
		cells = c == null ? new Array<Cell4>() : c;
	}
	
	public function from3D(vertices3D:Array<Vector3>, faces3D:Array<Face3>, duth:Float)
	{
		var extraVertexOffset = vertices3D.length;
		var d = duth / 2;
		var v4 = new Vector4();
		for(i in 0 ... vertices3D.length)
		{
			// Copy the "normal" vectors
			var v = vertices3D[i];
			v4.setTo(v.x, v.y, v.z, -d);
			vertices.push(v4.clone());
		}
		// Extrude all vertices along w
		for(i in 0 ... vertices3D.length)
		{
			v4.copyFrom(vertices[i]);
			v4.w = d;
			vertices.push(v4.clone());
		}
		// Make a 4D prism by extruding triangles along w
		// A prism is made of 3 tetrahedra ; those are the 4D model's cells
		for(f3 in 0 ... faces3D.length)
		{
			var face = faces3D[f3];
			var a = face.a, b = face.b, c = face.c,
			d = face.a + extraVertexOffset, e = face.b + extraVertexOffset, f = face.c + extraVertexOffset;
			// Draw it if you don't believe me
			cells.push(new Cell4(a, c, e, d));
			cells.push(new Cell4(b, e, c, a));
			cells.push(new Cell4(c, e, f, d));
		}
	}
}