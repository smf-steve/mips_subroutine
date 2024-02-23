public static int binaryReal(char[] arg0, char[] arg1, char[] arg2, char[] arg3) {
   char [] arg4 = null;     // Additional Formal Arguments which is on the static

   int  radix;
   char sharp;
   int  whole;
   int  point;
   int  fractional;

   final int max_bits = 23;

   arg4 = mips.pop(arg4);

   radix      = strtol(arg0, 10);
   sharp      = arg1[0];
   whole      = strtol(arg2, radix);
   point      = arg3[0];
   fractional = strtofrac(arg4, radix);

   mips.print_ci('2'); 
   mips.print_ci('#');
   mips.print_ci(' ');

   whole2bin(whole);     
   mips.print_ci('.');
   fractional2bin(fractional, max_bits);
   mips.print_ci('\n');

   return radix;
}
