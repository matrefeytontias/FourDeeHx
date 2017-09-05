package fourDee.materials.shaders;

enum ShaderNode
{
	SolidColor;
	AmbientLight;
	PointLight;
}

enum ShaderList
{
	Output;
	Node(type:ShaderNode, next:ShaderList, shaderVars:Array<ShaderVar>);
}

typedef ShaderSource = { vertex:String, fragment:String };
// File is "vert" or "frag" ; absence of type means "varying", else "uniform"
typedef ShaderVar = { ?file:String, type:String, name:String };

class ShaderListHelper
{
	static private var current:ShaderList = null;
	static private var length:Int = 0;
	
	static public var globalVars = new Array<ShaderVar>();
	
	inline static public function newList()
	{
		current = ShaderList.Output;
		length = 1;
	}
	
	static private function addNode(n:ShaderNode, v:Array<ShaderVar>) : Int
	{
		if(current == null)
			throw "ShaderListHelper : no shader list was attached";
		current = Node(n, current, v);
		return length++;
	}
	
	inline static public function addColor() : Int
	{
		return addNode(ShaderNode.SolidColor, [
			{ file: "frag", type:"vec4", name:"color_SC_" + length } ]);
	}
	
	inline static public function addAmbientLight() : Int
	{
		var v = new Array<ShaderVar>();
		v.push({ file: "frag", type: "vec4", name:"color_AL_" + length });
		v.push({ file: "frag", type: "float", name:"strength_AL_" + length });
		return addNode(ShaderNode.AmbientLight, v);
	}
	
	inline static public function addPointLight() : Int
	{
		var v = new Array<ShaderVar>();
		v.push({ file: "frag", type: "vec4", name:"color_PL_" + length });
		v.push({ file: "frag", type: "float", name:"strength_PL_" + length });
		v.push({ file: "frag", type: "vec4", name:"position_PL_" + length });
		return addNode(ShaderNode.PointLight, v);
	}
	
	static public function buildShaders() : ShaderSource
	{
		function build(l:ShaderList, accVert = "", mainVert = "", accFrag = "", mainFrag = "", i:Int) : ShaderSource
		{
			switch(l)
			{
				case Output:
					accVert += "void main() {\nvec4 position = vec4(aPosition, 1.);\n" + mainVert + "gl_Position = mat * position;\n}";
					accFrag += "void main() {\nvec4 color = vec4(0.);\n" + mainFrag + "gl_FragColor = color;\n}";
                    return { vertex: accVert, fragment: accFrag };
				case Node(type, next, vars):
					for(v in vars)
					{
						if(Reflect.hasField(v, "file"))
						{
							if(v.file== "frag")
								accFrag += 'uniform ${v.type} ${v.name};\n';
							if(v.file == "vert")
								accVert += 'uniform ${v.type} ${v.name};\n';
						}
						else
						{
							accFrag += 'varying ${v.type} ${v.name};\n';
							accVert += 'varying ${v.type} ${v.name};\n';
						}
					}
					switch(type)
					{
						case SolidColor:
                            mainFrag += "color = color_SC_" + i + ";\n";
						case AmbientLight:
							mainFrag += "color += color_AL_" + i + ";\n";
						case PointLight:
							mainFrag +=
								"color += color_PL_" + i + " * dot(normalize(position_PL_" + i + " - position), normal);\n";
					}
					return build(next, accVert, mainVert, accFrag, mainFrag, i - 1);
			};
		}
		
		return build(current, "attribute vec3 aPosition; attribute vec3 aNormal; uniform mat4 mat;\n",
			"",
			#if desktop "" #else "precision mediump float;" #end,
			"",
			length - 1
		);
	}
}
