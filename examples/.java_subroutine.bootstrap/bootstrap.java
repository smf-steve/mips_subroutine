class echo4 {
   static MIPS_OS_Interface mips = new MIPS_OS_Interface();

public static int  echo4 (char[] a, char[] b, char[] c, char[] d) {

	System.out.prin tln(a);
	System.out.println(b);
	System.out.println(c);
	System.out.println(d);
	return 4;
}
  public static void main(String[] args) {
  
    int index;
    int  $a0   = 3;
    int  $a1   = 4;
    int  $a2   = 5;
    int  $a3   = 2;

    int $v0 = echo4($a0, $a1, $a2, $a3);

    // Augment this code based upon desired output type

    mips.print_ci('\n');   // Print extra \n incase user did not
    mips.print_d($v0);
    mips.print_ci('\n');
    return;
  }
}
