package fourDee.math;

/**
  * Helper class to calculate the intersection between
  * a 3D hyperplane and a tetrahedron lying in 4D space.
  */
@:allow(fourDee.objects.Camera)
class Intersector
{
	private var ux:Vector4;
	private var uy:Vector4;
	private var uz:Vector4;
	private var normal:Vector4;

	private var anchor:Object4D;
	
	public function new(a:Object4D)
	{
		anchor = a;
		ux = new Vector4(1, 0, 0, 0);
		uy = new Vector4(0, 1, 0, 0);
		uz = new Vector4(0, 0, 1, 0);
		normal = new Vector4(0, 0, 0, 1);
	}
	
	/**
	  * Switches the expression of a 4D point as being either
	  * in canonical 4D space, or in the base of the current
	  * hyperplane. Specifically, if the input is a Vector3,
	  * the return value is a Vector4 containing the 4D
	  * coordinates of that point as expressed in the hyperplane's
	  * base ; if the input is a Vector4, the return value is a
	  * Vector3 containing the projection of the vector onto the
	  * hyperplane expressed in its own base.
	  * @param	vector	Vector3 or Vector4 object
	  * @return	Vector4 or Vector3 object as described above
	  */
	public function switchBase(vector:Vector4D) : Vector4D
	{
		switch(vector.E)
		{
			case Left(v):
				return (new Vector4(
					ux.x * v.x + uy.x * v.y + uz.x * v.z,
					ux.y * v.x + uy.y * v.y + uz.y * v.z,
					ux.z * v.x + uy.z * v.y + uz.z * v.z,
					ux.w * v.x + uy.w * v.y + uz.w * v.z
				)).add(anchor.position);
			case Right(v):
				var nv = v.clone().sub(anchor.position);
				return new Vector3(nv.dot(ux), nv.dot(uy), nv.dot(uz));
		}
	}
	
	/*
	const EPSILON = 0.001;
	const params = "xyzw";
	// Gets rid of imprecisions
	Intersector.prototype.snap = function()
	{
		for(var i = 0; i < params.length; i++)
		{
			var coord = params.charAt(i);
			ux[coord] = Math.abs(ux[coord]) < EPSILON ? 0 : (Math.abs(1 - Math.abs(ux[coord])) < EPSILON ? Math.sign(ux[coord]) : ux[coord]);
			uy[coord] = Math.abs(uy[coord]) < EPSILON ? 0 : (Math.abs(1 - Math.abs(uy[coord])) < EPSILON ? Math.sign(uy[coord]) : uy[coord]);
			uz[coord] = Math.abs(uz[coord]) < EPSILON ? 0 : (Math.abs(1 - Math.abs(uz[coord])) < EPSILON ? Math.sign(uz[coord]) : uz[coord]);
			normal[coord] = Math.abs(normal[coord]) < EPSILON ? 0 : (Math.abs(1 - Math.abs(normal[coord])) < EPSILON ? Math.sign(normal[coord]) : normal[coord]);
		}
		e = -normal.dot(anchor.position);
	}
	*/

	/**
	  * Apply a Matrix5 to the hyperplane's axis system.
	  * This updates the plane's equation's internal factor,
	  * so the anchor.position needs to be updated BEFORE this is called.
	  * @param	m	Matrix5 object describing the transformation
	  */
	public function applyMatrix5(m:Matrix5)
	{
		ux = m * ux;
		uy = m * uy;
		uz = m * uz;
		normal = m * normal;
	}

	// Cartesian equation for the hyperplane
	// ax + by + cz + dw + e = 0
	// with e = -normal.dot(anchor.position)
	private function hyperplane(v:Vector4) : Float
	{
		return normal.dot(v.sub(anchor.position));
	}

	private function lineSpaceIntersect(v1:Vector4, v2:Vector4) : Vector4
	{
		var u = v2.sub(v1);
		u.normalize();
		//                                         never zero
		var t = anchor.position.sub(v1).dot(normal) / u.dot(normal);
		return u.scaleBy(t).add(v1);
	}

	/**
	  * Calculates the intersection between the hyperplane
	  * and a tetrahedron lying in 4D space. The intersection
	  * of a 3-hyperplane and a tetrahedron is either nothing,
	  * one of the vertices, one of the edges, a triangle or
	  * a tetrahedron.
	  * @param	v1	1st vertex of the tetrahedron
	  * @param	v2	2nd vertex of the tetrahedron
	  * @param	v3	3rd vertex of the tetrahedron
	  * @param	v4	4th vertex of the tetrahedron
	  * @return	array of intersected vertices
	  */
	public function intersectTetra(v1:Vector4, v2:Vector4, v3:Vector4, v4:Vector4) : Array<Vector4>
	{
		// First case : the hyperplane doesn't intersect with the geom3
		// This means that all its vertices are on the same side of the hyperplane
		// which cuts the space in 2
		var r = new Array<Vector4>();
		
		var s1 = sign(hyperplane(v1)),
			s2 = sign(hyperplane(v2)),
			s3 = sign(hyperplane(v3)),
			s4 = sign(hyperplane(v4));
		
		if(Math.abs(s1 + s2 + s3 + s4) == 4)
			return r;

		// Second case : if one or more vertices are inside the hyperplane, their number alone
		// determines the shape of the intersection
		var r = [];

		if(s1 == 0) r.push(v1.clone());
		if(s2 == 0) r.push(v2.clone());
		if(s3 == 0) r.push(v3.clone());
		if(s4 == 0) r.push(v4.clone());

		// Third case : the hard one, where the intersection is a triangle or a quad.
		// We intersect all edges with the hyperplane to find points.
		// We know that the line cuts the hyperplane
		if(s1 != s2 && s1 + s2 == 0)
			r.push(lineSpaceIntersect(v1, v2));
		if(s1 != s3 && s1 + s3 == 0)
			r.push(lineSpaceIntersect(v1, v3));
		if(s1 != s4 && s1 + s4 == 0)
			r.push(lineSpaceIntersect(v1, v4));
		if(s2 != s3 && s2 + s3 == 0)
			r.push(lineSpaceIntersect(v2, v3));
		if(s2 != s4 && s2 + s4 == 0)
			r.push(lineSpaceIntersect(v2, v4));
		if(s3 != s4 && s3 + s4 == 0)
			r.push(lineSpaceIntersect(v3, v4));
		return r;
	}
	
	static private function sign(v:Float) : Int
	{
		return v < 0 ? -1 : (v > 0 ? 1 : 0);
	}
}
