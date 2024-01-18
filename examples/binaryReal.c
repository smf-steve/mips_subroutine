1. Define the MIPS OS interace for C
   - Include the following definitios

// redefine public
#define public
// redefine final
#define final const
#define null '\0'




//#undef strtol
extern int strtol_mine(char*, int);
extern int strtofrac(char*, int);
extern int whole2bin(int);
extern int fractional2bin(int, int);

//

public static int binaryReal(char* arg0, char* arg1, char* arg2, char* arg3) {
   char * arg4 = null;     // Additional Formal Arguments which is on the static

   int  radix;
   char sharp;
   int  whole;
   int  point;
   int  fractional;

   final int max_bits = 23;

   arg4 = mips.pop();

   radix      = strtol_mine(arg0, 10);
   sharp      = arg1[0];
   whole      = strtol_mine(arg2, radix);
   point      = arg3[0];
   fractional = strtofrac(arg4, radix);

   mips.print_ci('2'); 
   mips.print_ci('#');
   mips.print_ci(' ');

   whole2bin(whole);     
   mips.print_ci('.');
   fractional2bin(fractional, max_bits);
   mips.print_ci('\n');

   return radix;
}
