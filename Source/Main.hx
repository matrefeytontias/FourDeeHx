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

#if cpp
import cpp.vm.Profiler;
#end

class Main extends Application
{
	private var hcube1:Mesh4D;
	private var hcube2:Mesh4D;
	
	public function new()
	{
		super();
	}
	
	override public function onWindowCreate(window:Window)
	{
		super.onWindowCreate(window);
		space4D = new Space4D(window.width, window.height);
		
		// Screen width, screen height, fov in degrees
		space4D.attachCamera(new PerspectiveCamera(90, window.width / window.height, 0.1, 10));
		
		hcube1 = new Mesh4D(new BoxGeometry4D(1, 0.5, 1, 1), new LambertMaterial(0xff0000, 1));
		hcube2 = new Mesh4D(new BoxGeometry4D(0.5, 1, 1, 1), new SolidMaterial(0x0000ff));
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
	
#if cpp
	override public function onKeyDown(window:Window, key:KeyCode, modifier:KeyModifier)
	{
		super.onKeyDown(window, key, modifier);
		if(key == KeyCode.P)
		{
			Profiler.start("profile.log");
			trace("Started profiling");
		}
		if(key == KeyCode.S)
		{
			Profiler.stop();
			trace("Stopped profiling");
		}
	}
#end
	
	override public function update(dt:Int)
	{
		hcube1.rotation.xw -= dt / 1000;
		hcube2.rotation.xy -= dt / 1000;
		hcube1.rotation.xz += dt / 1000;
		hcube2.rotation.xz += dt / 1000;
		super.update(dt);
	}
}