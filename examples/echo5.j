public static int  echo5 (int a, char[] b, int c, int d) {
            // The fifth element is on the stack

    char[] e = new char[1];  // array has to be initalized

    e = mips.pop(e);

    mips.print_d(a); mips.print_ci(' ');
    mips.print_s(b); mips.print_ci(' ');
    mips.print_d(c); mips.print_ci(' ');
    mips.print_d(d); mips.print_ci(' '); 
    mips.print_s(e); mips.print_ci('\n');
    return 5;
}
