import fourDee.Application;
import fourDee.Space4D;
import fourDee.geometries.BoxGeometry4D;
import fourDee.materials.*;
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
		
		hcube = new Mesh4D(new BoxGeometry4D(1, 1, 1, 1), new LambertMaterial(0xff0000, 2));
		// hcube = new Mesh4D(new BoxGeometry4D(1, 1, 1, 1), new SolidMaterial(0xff0000));
		space4D.add(hcube);
		hcube.position.z = -5;
		
		var GL = lime.graphics.opengl.GL;
	}
	
	override public function update(dt:Int)
	{
		// hcube.rotation.xw -= dt / 1000;
		hcube.rotation.xy -= dt / 1000;
		hcube.rotation.xz += dt / 1000;
		super.update(dt);
	}
}