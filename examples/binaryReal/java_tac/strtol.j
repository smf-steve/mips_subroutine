public static int glyph2int(char c, int radix) {

        int value;
        int char_0;
        int char_9;
        int char_a;
        int char_f;
        int char_A;
        int char_F;

        value = -1;
        char_0 = '0';
        char_9 = '9';
        char_a = 'a';
        char_f = 'f';
        char_A = 'A';
        char_F = 'F';

        if (char_0 <= c ) {
            if (c <= char_9) {
              value = c - '0';
            }
            // goto fi_2
        }
fi_1:   ;
        if (char_a <= c ) {
            if (c <= char_f) {
              value = c - 'a';
              value = value + 10;
            }
            // goto fi_2
        }
fi_2:   ;
        if (char_A <= c ) {
            if (c <= char_F) {
              value = c - 'A'; 
              value = value + 10;
              // goto fi_3
            }
        }
fi_3:   ;
        if (value >= radix) {
            value = -1;
            // goto fi_4
        }
fi_4:   ;
        return value;
}


public static int strtol(char[] buffer, int radix) {

        int retval;

        int digit;
        int value;
        int i;
        char glyph;
        int neg_one;

        neg_one = -1;
        value = 0;
        i = 0;

        glyph = buffer[i];
loop1:  for (;  glyph != '\0' ;) {
           digit = glyph2int(glyph, radix);

           if (digit == neg_one ) break loop1;
           value = value * radix; 
           value = value + digit;
           i++;
           glyph = buffer[i];
           continue loop1;
        }
done1:  ;
        return value;
}

