package fourDee.ds;

/**
  * Holds a value of one of two types.
  */
enum Either<L, R>
{
	Left(v:L);
	Right(v:R);
}
