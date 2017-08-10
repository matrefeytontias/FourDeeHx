import fourDee.Application;
import fourDee.Space4D;
import fourDee.geometries.BoxGeometry4D;
import fourDee.materials.SolidMaterial;
import fourDee.objects.Box;
import fourDee.render.PerspectiveCamera;

import lime.ui.Window;

class Main extends Application
{
	private var hcube:Box;
	
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
		
		hcube = new Box(1, 1, 1, new SolidMaterial(0xff0000));
		space4D.add(hcube);
		hcube.position.z = -5;
	}
	
	override public function update(dt:Int)
	{
		// hcube.rotation.xz += dt;
		// hcube.rotation.yz -= dt / 2;
		space4D.camera.rotation3D.x -= dt / 1000;
		space4D.camera.rotation3D.y += dt / 1000;
		super.update(dt);
	}
}