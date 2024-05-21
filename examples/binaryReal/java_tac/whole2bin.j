public static int whole2bin(int number) {

        int n;
        int remainder;
        int digit;
        int count;
      
        n = number;
        count = 0;
loop1:  for (; n != 0 ;){
          remainder = n & 1;
          n = n >>> 1;
          mips.push(remainder);
          count ++;
          continue loop1;
        }
done1:  ;        
loop2:  for (; count > 0 ;) {
          digit = (Integer) mips.pop();
          mips.print_d(digit);
          count --;
          continue loop2;
        }
done2:  ; 
        return 0;
}
