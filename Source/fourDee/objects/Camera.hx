package fourDee.objects;

import fourDee.Object4D;
import fourDee.math.Euler3;
import fourDee.math.Intersector;
import fourDee.math.Vector3;
import fourDee.math.Vector4;
import fourDee.render.Face3;
import fourDee.render.ObjectSlice3D;

import lime.math.Matrix4;

typedef Vector3 = lime.math.Vector4;

/**
  * A camera is important in both 3D and 4D space, as its
  * field of view spans a 3D hyperplane in 4D space.
  * It has 4D coordinates and virtual 3D coordinates (they
  * are always 0 as it is the center of all 4D to 3D
  * projection). Because of this, it has a 4D position
  * but only a 3D rotation descriptor. Instead, it holds
  * an intersector, which will take care of projecting
  * the 4D objects onto the 3D field of view. Similarly,
  * scale is used as the zoom of the camera, but the W
  * scale coordinate is never used.
  */
class Camera extends Object4D
{
	private var intersector:Intersector;
	
	/**
	  * 3D rotation of the camera in the base of the intersector.
	  */
	public var rotation3D:Euler3 = new Euler3();
	
	/**
	  * Projection matrix of the camera.
	  */
	public var pmat:Matrix4 = new Matrix4();
	/**
	  * Matrix form of the rotation3D field. This is
	  * updated on each `update` call.
	  */
	public var matrix3D:Matrix4 = new Matrix4();
	/**
	  * Inverse of the matrix3D matrix.
	  */
	public var invMatrix3D:Matrix4;
	
	public function new()
	{
		super();
		intersector = new Intersector(this);
	}
	
	// Calculate the matrix only once per frame
	override public function update(dt:Int)
	{
		matrix3D = getMatrix3D();
		invMatrix3D = getInvMatrix3D();
	}
	
	// The camera is always the center of 3D space
	private function getMatrix3D() : Matrix4
	{
		var m = rotation3D.makeInverseMatrix();
		m.appendScale(scale.x, scale.y, scale.z);
		return m;
	}

	private function getInvMatrix3D() : Matrix4
	{
		var m = rotation3D.makeMatrix();
		m.prependScale(1. / scale.x, 1. / scale.y, 1. / scale.z);
		return m;
	}

	/**
	 * Moves the camera inside the hyperplane with a 3D movement
	 * vector.
	 * @param	dr	displacement vector
	 */
	 inline public function move3D(dr:Vector3)
	 {
	 	position = intersector.switchBase(invMatrix3D.transformVector(dr));
	 }

	/**
	  * Calculates the 3D slice of an Object4D.
	  * @param	obj	Object4D to slice
	  * @return	3D slice of the 4D object as an ObjectSlice3D
	  */
	public function intersect(obj:Object4D) : ObjectSlice3D
	{
		if(obj.intersectable)
		{
			var r = new ObjectSlice3D(cast(Reflect.field(obj, "material"), Material));
			var geom:Geometry4D = Reflect.field(obj, "geometry");
			var v:Array<Vector4> = geom.vertices;
			var cm = rotation.makeInverseMatrix();
			var m = cm * obj.rotation.makeMatrix();
			var o = (cm * obj.position.sub(position)).add(position);
			var centroid = intersector.switchBase(o);
			for(f in geom.cells)
			{
				var v1 = (m * v[f.a]).add(o),
					v2 = (m * v[f.b]).add(o),
					v3 = (m * v[f.c]).add(o),
					v4 = (m * v[f.d]).add(o);
				
				var inter = intersector.intersectTetra(v1, v2, v3, v4);
				var offset = r.vertices.length;
				for(v in inter)
					r.vertices.push(intersector.switchBase(v));
				
				// Resulting intersections are triangles, quadrilaterals or tetrahedra
				if(inter.length >= 3)
					pushDirect(new Face3(0 + offset, 1 + offset, 2 + offset), centroid, r);
				if(inter.length == 4)
				{
					// Reorder vertices to have minimum successive angle difference
					var v1 = r.vertices[offset],
						v2 = r.vertices[offset + 1],
						v3 = r.vertices[offset + 2],
						v4 = r.vertices[offset + 3];
					var v2v1 = v2.subtract(v1), v3v2 = v3.subtract(v2);
					if(Vector3.angleBetween(v2v1, v3v2) > Vector3.angleBetween(v2v1, v4.subtract(v2)))
					{
						r.vertices[offset+2] = v4;
						r.vertices[offset+3] = v3;
						v3 = v4;
					}
					pushDirect(new Face3(0 + offset, 2 + offset, 3 + offset), centroid, r);
					
					// Check for tetrahedron
					var n = v2.subtract(v1).crossProduct(v3.subtract(v1));
					// Tetrahedron
					if(n.dotProduct(v4.subtract(v3)) != 0)
					{
						pushDirect(new Face3(0 + offset, 1 + offset, 3 + offset), centroid, r);
						pushDirect(new Face3(1 + offset, 2 + offset, 3 + offset), centroid, r);
					}
				}
			}
			return r;
		}
		else
			throw "RenderMode.Intersect object has no geometry or material";
	}
	
	// Pushes a CCW-winded triangle to an object slice
	private function pushDirect(f:Face3, centroid:Vector3, obj:ObjectSlice3D)
	{
		var v1 = obj.vertices[f.a],
			v2 = obj.vertices[f.b],
			v3 = obj.vertices[f.c];
		var e = 0.001;
		// if(Math.abs(v1.z - v2.z) < e && Math.abs(v1.z - v3.z) < e)
			// trace(v1, v2, v3);
		var n = v2.subtract(v1).crossProduct(v3.subtract(v1));
		if(n.dotProduct(centroid.subtract(v1)) > 0)
		{
			var t = f.b;
			f.b = f.c;
			f.c = t;
		}
		obj.faces.push(f);
	}
}