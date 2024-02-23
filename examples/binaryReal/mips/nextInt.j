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


static char [] buffer = new char[100];

public static int nextInt(int radix){

    int retval;

    int digit;
    int value;
    int i;

    mips.read_s(buffer, 256);
    retval = mips.retval();

    value = 0;
    for (i=0; buffer[i] != '\0'; i++ ) {
       digit = glyph2int(buffer[i], radix);

       if (digit == -1 ) break;
       value = value * radix + digit;
    }

    return value;
}

