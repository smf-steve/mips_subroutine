public static int glyph2int(char c, int radix){

    int value;

    value = -1;

    if ('0' <= c && c <= '9') {
        value = c - '0';
    }
    if ('a' <= c && c <= 'f') {
        value = c - 'a' + 10;
    }
    if ('A' <= c && c <= 'F') {
        value = c - 'A' + 10;
    }
    if (value >= radix) {
        value = -1;
    }

    return value;
}


public static int strtol(char[] buffer, int radix){

    int retval;

    int digit;
    int value;
    int i;

    //mips.read_s(buffer, 256);
    //retval = mips.retval();

    value = 0;
    for (i=0; buffer[i] != '\0'; i++ ) {
       digit = glyph2int(buffer[i], radix);

       if (digit == -1 ) break;
       value = value * radix + digit;
    }

    return value;
}

public static int strtol_f(char[] buffer, int radix){

    int retval;

    int digit;
    float value;
    int d;
    int i;

    //mips.read_s(buffer, 256);
    //retval = mips.retval();

    value = 0;
    for (d=0; buffer[d] != '\0'; d++ );
    d = d - 1;

    for (i=d; i >= 0 ; i-- ) {
       digit = glyph2int(buffer[i], radix);

       if (digit == -1 ) break;
       
       value = ( digit + value ) / radix;
    }

    return (int) (value * Math.pow(10, d+1) );
}




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


public static int binaryReal(char[] arg0, char[] arg1, char[] arg2, char[] arg3) {
   // Additional Formal Arguments
   char [] arg4 =  null;

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
   fractional = strtol_f(arg4, radix);

   mips.print_d(whole);      mips.print_ci('\n');
   mips.print_d(fractional); mips.print_ci('\n');


   mips.print_ci('2'); 
   mips.print_ci('#');
   mips.print_ci(' ');

   whole2bin(whole);     
   mips.print_ci('.');
   fractional2bin(fractional, max_bits);
   mips.print_ci('\n');

   return radix;
}
