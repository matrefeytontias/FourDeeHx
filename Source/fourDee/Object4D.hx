package fourDee;

import fourDee.math.Euler4;
import fourDee.math.Vector4;

import lime.graphics.opengl.GLBuffer;

class Object4D
{
	private var glVertexData:GLBuffer;
	private var glPosA:Int;
	
	public var position:Vector4 = new Vector4();
	public var rotation:Euler4 = new Euler4();
	public var scale:Vector4 = new Vector4(1., 1., 1., 1.);
	public var geometry:Geometry4D;
	public var material:Material;
	
	public function new(g:Geometry4D, m:Material)
	{
		geometry = g;
		material = m;
	}
	
	public function render(camera:Camera)
	{
		if(geometry == null || material == null)
			return;
		// Render object with material
		glProgram = material.getShader();
		
	}
}