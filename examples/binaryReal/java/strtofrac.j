public static int strtofrac(char[] buffer, int radix) {

    int retval;

    double value;
    double denom;

    int i;
    int digit;


    value = 0;
    denom = radix;
    for (i=0; buffer[i] != '\0'; i++ ) {
       digit = glyph2int(buffer[i], radix);

       if (digit == -1 ) break;
       
       value = value +  digit / denom;
       denom = denom * radix;
    }

    for (; i > 0 ;) {
        value = value * 10;
        i--;
    }
    return (int) value;
}
