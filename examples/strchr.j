public static char[] strchr(char[] A, int c);`
   match:  for(i=0; A[i]!='\0'; i++) {
             if (A[i] == c) {
               break match;
           }
           return A[i];
}
