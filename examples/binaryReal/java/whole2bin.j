public static int whole2bin(int number) {

   int n;
   int remainder;
   int digit;
   int count;

   n = number;
   for (count = 0; n != 0 ; count++){
     remainder = n % 2;
     n = n / 2;
     mips.push(remainder);
   }
   for (; count > 0; count--) {
     digit = mips.pop();
     mips.print_d(digit);
   }
   return 0;
}
