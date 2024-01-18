public static int echo_list( int count, char[] one, char[] two, char[] three) {
  // Here is a limitation of Java
  // This subroutine must have at least 4 arguments          

  int sum = 0;
  int i = 0;
  char[] value = null;


  if (count > 0) mips.println_s(one);
  if (count > 1) mips.println_s(two);
  if (count > 2) mips.println_s(three);

  for (i=3; count > i; i++)  {
     // value =  (char []) mips.pop();            # Bug needs to be converted from object?
     mips.print_s(value);
  }
  return count;
}