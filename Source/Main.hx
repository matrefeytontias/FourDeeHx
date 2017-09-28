import fourDee.Application;
import fourDee.Space4D;
import fourDee.geometries.BoxGeometry4D;
import fourDee.materials.*;
import fourDee.math.Vector4;
import fourDee.objects.Mesh4D;
import fourDee.objects.PerspectiveCamera;

import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.ui.Window;

class Main extends Application
{
	static private var SPEED(default, never) = 0.1;
	private var hcube1:Mesh4D;
	private var hcube2:Mesh4D;

	private var camera:PerspectiveCamera;
	
	public function new()
	{
		super();
	}
	
	override public function onWindowCreate(window:Window)
	{
		super.onWindowCreate(window);
		space4D = new Space4D(window.width, window.height);
		
		// Screen width, screen height, fov in degrees
		camera = new PerspectiveCamera(90, window.width / window.height, 0.1, 10);
		space4D.attachCamera(camera);
		
		hcube1 = new Mesh4D(new BoxGeometry4D(1, 0.5, 1, 1), new LambertMaterial(0xff0000, 1));
		hcube2 = new Mesh4D(new BoxGeometry4D(0.5, 1, 1, 1), new LambertMaterial(0x0000ff, 1));
		space4D.add(hcube2);
		space4D.add(hcube1);
		hcube1.position.z = -5;
		hcube2.position.z = -3;
		
		color = 0x330000;
	}
	
	override public function onWindowResize(window:Window, width:Int, height:Int)
	{
		super.onWindowResize(window, width, height);
		cast(space4D.camera, PerspectiveCamera).updateAspectRatio(width / height);
	}
	
	override public function onKeyDown(window:Window, key:KeyCode, modifier:KeyModifier)
	{
		super.onKeyDown(window, key, modifier);
		if(key == KeyCode.Z)
			camera.position.y += SPEED;
		if(key == KeyCode.S)
			camera.position.y -= SPEED;
		if(key == KeyCode.UP)
			camera.position.z -= SPEED;
		if(key == KeyCode.DOWN)
			camera.position.z += SPEED;
		if(key == KeyCode.RIGHT)
			camera.position.x += SPEED;
		if(key == KeyCode.LEFT)
			camera.position.x -= SPEED;
		if(key == KeyCode.NUMPAD_6)
			camera.rotation.xz += SPEED / 2;
		if(key == KeyCode.NUMPAD_4)
			camera.rotation.xz -= SPEED / 2;
	}
	
	override public function update(dt:Int)
	{
		hcube1.rotation.xw -= dt / 1000;
		hcube2.rotation.xy -= dt / 1000;
		hcube1.rotation.xz += dt / 1000;
		hcube2.rotation.xz += dt / 1000;
		super.update(dt);
	}
}