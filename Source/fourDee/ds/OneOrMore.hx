package fourDee.ds;

enum OneOrMore<T>
{
	One(v:T);
	More(v:Array<T>);
}
