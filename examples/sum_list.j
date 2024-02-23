public static int sum_list( int count, int one, int two, int three) {
  // Here is a limitation of Java
  // This subroutine must have at least 4 arguments          

  int sum = 0;
  int value = 0;
  int i = 0;

  if (count > 0) sum = sum + one;
  if (count > 1) sum = sum + two;
  if (count > 2) sum = sum + three;

  for (i=3; count > i; i++)  {
     value = mips.pop();
     sum = sum + value;
  }
  return sum;
}
