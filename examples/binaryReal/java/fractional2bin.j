public static int fractional2bin(int number, int max_bits) {

   int n;
   int max;
   int count;

   n = number;
   max = value_of_max(n);

   for (count=0; count < max_bits; count++) {
      n = n * 2;
      if (n == 0) break;
      if ( n >= max) {
         mips.print_ci('1');
         n = n - max; 
      } else {
         mips.print_ci('0');
      }
   }
   return 0;
}

public static int value_of_max(int number) {

   int max;

   max = 10;
   for (int i=0;  number >= max ;i++) {
      if( i > 8) break;
      max = max * 10;
   }
   return max;
}
