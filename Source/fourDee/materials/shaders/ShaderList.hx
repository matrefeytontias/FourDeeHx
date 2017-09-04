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
	
	inline static public function newList()
	{
		current = ShaderList.Output;
		length = 1;
	}
	
	static private function addNode(n:ShaderNode, v:Array<ShaderVar>)
	{
		if(current == null)
			throw "ShaderListHelper : no shader list was attached";
		current = Node(n, current, v);
        length++;
	}
	
	inline static public function addColor()
	{
		addNode(ShaderNode.SolidColor, [
			{ file: "frag", type:"vec4", name:"color_SC_" + length } ]);
	}
	
	inline static public function addAmbientLight()
	{
		var v = new Array<ShaderVar>();
		v.push({ file: "frag", type: "vec4", name:"color_AL_" + length });
		v.push({ file: "frag", type: "float", name:"strength_AL_" + length });
		addNode(ShaderNode.AmbientLight, v);
	}
	
	inline static public function addPointLight()
	{
		var v = new Array<ShaderVar>();
		v.push({ file: "frag", type: "vec4", name:"color_PL_" + length });
		v.push({ file: "frag", type: "float", name:"strength_PL_" + length });
		v.push({ file: "frag", type: "vec4", name:"position_PL_" + length });
		addNode(ShaderNode.PointLight, v);
	}
	
	static public function buildShaders() : ShaderSource
	{
		function build(l:ShaderList, accVert = "", mainVert = "", accFrag = "", mainFrag = "", i:Int) : ShaderSource
		{
			switch(l)
			{
				case Output:
					accVert += "void main() {\n" + mainVert + "gl_Position = mat * vec4(position, 1.);\n}";
					accFrag += "void main() {\nvec4 color = vec4(0.);\n" + mainFrag + "gl_FragColor = color;\n}";
                    return { vertex: accVert, fragment: accFrag };
				case Node(type, next, vars):
					for(v in vars)
					{
						if(Reflect.hasField(v, "file"))
						{
							if(v.file== "frag")
								accFrag = 'uniform ${v.type} ${v.name};\n' + accFrag;
							if(v.file == "vert")
								accVert = 'uniform ${v.type} ${v.name};\n' + accVert;
						}
						else
						{
							accFrag = 'varying ${v.type} ${v.name};\n' + accFrag;
							accVert = 'varying ${v.type} ${v.name};\n' + accVert;
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
		
		return build(current, "", "", "", "", length - 1);
	}
}