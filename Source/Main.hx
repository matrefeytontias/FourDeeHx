import fourDee.Application;
import fourDee.Space4D;
import fourDee.geometries.BoxGeometry4D;
import fourDee.materials.SolidMaterial;
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
		
		// Screen width, screen width, fov in degrees
		space4D.attachCamera(new PerspectiveCamera(90));
		
		hcube = new Mesh4D(new BoxGeometry4D(1, 1, 1, 1), new SolidMaterial(0xff0000));
		space4D.add(hcube);
		hcube.position.z = -5;
	}
	
	override public function update(dt:Int)
	{
		hcube.rotation.xz += dt;
		hcube.rotation.yz -= dt / 2;
		super.update(dt);
	}
}