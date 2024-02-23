public static int strtofrac(char[] buffer, int radix) {

        int i;
        char glyph;
        int digit;
        int value;
        int neg_one;

        double d_value;
        double d_radix;
        double d_denom;
        double d_fraction;
        double d_digit;

        double d_10;

        neg_one = -1;
        d_10    = (double) 10;

        d_value = (double) 0;
        d_radix = (double) radix;
        d_denom = (double) d_radix;

        i = 0;
        glyph = buffer[i];
loop1:  for (; glyph != '\0' ;) {
           digit = glyph2int(glyph, radix);

           if (digit == -1 ) break loop1;

           d_digit    = (double) digit;
           d_fraction = (double) d_digit / d_denom;

           d_value  = (double) d_value + d_fraction;
           d_denom  = (double) d_denom * d_radix;

           i++;
           glyph = buffer[i];
           continue loop1;
        }
done1:  ;
loop2:  for (; i > 0 ;) {
          d_value = (double) d_value * d_10;
          i--;
          continue loop2;
        }
done2:  ;
        value = (int) d_value;
        return value;
}

