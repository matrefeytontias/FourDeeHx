import fourDee.Application;
import fourDee.Space4D;
import fourDee.geometries.BoxGeometry4D;
import fourDee.materials.*;
import fourDee.math.Vector4;
import fourDee.objects.Mesh4D;
import fourDee.render.PerspectiveCamera;

import lime.ui.Window;

class Main extends Application
{
	private var hcube:Mesh4D;
	
	public function new()
	{
		super();
	}
	
	override public function onWindowCreate(window:Window)
	{
		super.onWindowCreate(window);
		space4D = new Space4D(window.width, window.height);
		
		// Screen width, screen height, fov in degrees
		space4D.attachCamera(new PerspectiveCamera(90, window.width / window.height));
		
		hcube = new Mesh4D(new BoxGeometry4D(1, 1, 1, 1), new LambertMaterial(0xff0000, 1));
		space4D.add(hcube);
		hcube.position.z = -5;
		
		var GL = lime.graphics.opengl.GL;
		GL.enable(GL.CULL_FACE);
		
		var v = hcube.geometry.vertices,
			v1 = v[0],
			v2 = v[1],
			v3 = v[2],
			v4 = Vector4.crossProduct4D(v1, v2, v3);
		
		trace(v4);
		trace(v1.dot(v4), v2.dot(v4), v3.dot(v4));
	}
	
	override public function onWindowResize(window:Window, width:Int, height:Int)
	{
		super.onWindowResize(window, width, height);
		cast(space4D.camera, PerspectiveCamera).updateAspectRatio(width / height);
	}
	
	override public function update(dt:Int)
	{
		hcube.rotation.xw -= dt / 1000;
		// hcube.rotation.xy -= dt / 1000;
		hcube.rotation.xz += dt / 1000;
		super.update(dt);
	}
}