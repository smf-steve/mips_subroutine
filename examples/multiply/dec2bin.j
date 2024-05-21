public  static int dec2bin(int number) {

               int count = 0;
               int n = number;
               int d = 4;
               int r = 0;
      
   forloop:    for(; n != 0; ) {
   body :         ; 
                  r = n % 2;     
                  n = n / 2;
                  mips.push(r);
                  count = count + 1;
                  continue forloop;
               }
   end:        ;
   scndloop:   for ( ; count > 0; ) {
                  d = (Integer) mips.pop();
                  mips.print_d(d);
                  count = count - 1;
                  continue scndloop;
               } 
   done:       ;  
               mips.print_ci('\n');
      return number;
      
   }         
