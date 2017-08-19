package fourDee.ds;

/**
  * Holds a value of a given type, or an array of values
  * of that type.
  */

enum OneOrMore<T>
{
	One(v:T);
	More(v:Array<T>);
}
