public static int fractional2bin(int number, int max_bits) {

          int n;
          int max;
          int count;

          n = number;
          max = value_of_max(n);

          count=0;
loop1:    for (; count < max_bits ;) {
             n = n << 1;
             if (n == 0) break loop1;
             if ( n >= max) {
cons:           ;               
                mips.print_ci('1');
                n = n - max; 
                // goto end_if
             } else {
alt:            ;               
                mips.print_ci('0');
                // goto end_if
             }
end_if:      ;
             count ++;
             continue loop1;
          }
done1:    ;          
          return 0;
}

public static int value_of_max(int number) {

         int _8;
         int _10;

         int max;
         int i;

         _8  =  8;
         _10 = 10;

         max = 10;
         i   =  0;

loop2:   for (; number >= max ;) {
            if( i > _8) break loop2;
            max = max * _10;
            i++;
            continue loop2;
         }
done2:   ;
         return max;
}
