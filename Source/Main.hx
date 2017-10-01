import fourDee.Application;
import fourDee.Space4D;
import fourDee.geometries.BoxGeometry4D;
import fourDee.materials.*;
import fourDee.math.Vector3;
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
	private var dr:Vector3; // camera movement in the 3D hyperplane
	
	private var active:Bool = true;

	public function new()
	{
		super();
		dr = new Vector3();
	}
	
	override public function onWindowCreate(window:Window)
	{
		super.onWindowCreate(window);
		space4D = new Space4D(window.width, window.height);
		
		// Screen width, screen height, fov in degrees
		camera = new PerspectiveCamera(90, window.width / window.height, 0.1, 10);
		space4D.attachCamera(camera);
		
		hcube1 = new Mesh4D(new BoxGeometry4D(1, 0.5, 1, 1), new LambertMaterial(0xff0000, 1));
		hcube2 = new Mesh4D(new BoxGeometry4D(0.5, 1, 1, 1), new SolidMaterial(0x0000ff));
		space4D.add(hcube2);
		space4D.add(hcube1);
		hcube1.position.z = -5;
		hcube2.position.z = -3;
		
		color = 0x330000;
	}
	
	override public function onMouseMoveRelative(window:Window, dx:Float, dy:Float)
	{
		camera.rotation3D.y -= dx / window.width;
		camera.rotation3D.x -= dy / window.height;
	}

	override public function onWindowEnter(window:Window)
	{
		lime.ui.Mouse.lock = active = true;
	}

	override public function onWindowLeave(window:Window)
	{
		lime.ui.Mouse.lock = active = false;
	}

	override public function onWindowResize(window:Window, width:Int, height:Int)
	{
		super.onWindowResize(window, width, height);
		cast(space4D.camera, PerspectiveCamera).updateAspectRatio(width / height);
	}
	
	override public function onKeyDown(window:Window, key:KeyCode, modifier:KeyModifier)
	{
		super.onKeyDown(window, key, modifier);
		if(active)
		{
			if(key == KeyCode.UP)
				dr.y += SPEED;
			if(key == KeyCode.DOWN)
				dr.y -= SPEED;
			if(key == KeyCode.Z)
				dr.z -= SPEED;
			if(key == KeyCode.S)
				dr.z += SPEED;
			if(key == KeyCode.D)
				dr.x += SPEED;
			if(key == KeyCode.Q)
				dr.x -= SPEED;
		}
	}
	
	override public function update(dt:Int)
	{
		hcube1.rotation.xw -= dt / 1000;
		hcube1.rotation.xz += dt / 1000;
		hcube2.rotation.xz -= dt / 1000;
		hcube2.rotation.xy += dt / 1000;
		hcube2.rotation.yw += dt / 1000;
		super.update(dt);
		camera.move3D(dr);
		dr.setTo(0., 0., 0.);
	}
}