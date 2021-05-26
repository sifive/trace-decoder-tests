
#include <stdio.h>
#include <string.h>

void ascii_line_to_binary_line(char *bin, char *ascii) ;

int main(int argc, char **argv){

  //                         #chars + \n + \0
  const int  max_line_bufsz = 32     + 1  + 1 ;
  char       ascii_line[max_line_bufsz] ;
  int        input_lineno = 1 ;

  char   binary_line[16] ;
  
  while( fgets(ascii_line, max_line_bufsz, stdin) != NULL){
    int bytes_remaining ;

    if(strlen(ascii_line) != max_line_bufsz-1){
      printf("%s:%d: input format error: line length %d is not %d: %s",
	     __FILE__, __LINE__, (int) strlen(ascii_line),  (max_line_bufsz-1), ascii_line) ;
    return(1) ;
    }

    ascii_line_to_binary_line(binary_line, ascii_line) ;

    if(input_lineno == 1){
      // first line contains count of bytes in subsequent lines as 32-bit word [2]
      bytes_remaining =
	               binary_line[ 8]
	+         256* binary_line[ 9]
	+     256*256* binary_line[10]
	+ 256*256*256* binary_line[11] ;
    } else{
      int remaining_this_line=0 ;
      
      while(remaining_this_line++ < 16 && bytes_remaining--)
	fputc(*(binary_line + remaining_this_line -1), stdout) ;

    }

    if(bytes_remaining<0) break ;
    input_lineno++ ;
  }  // while lines left

  return (0) ;
} // main()


// asssumes lowercase ASCII
char hex_nybble_to_int(char n){
  return( (n >= 'a') ? n - 'a' + 10 : n - '0') ;
}
char hex_byte_to_bin(char *two_hex_digits){
  return( 16*hex_nybble_to_int(*two_hex_digits) + hex_nybble_to_int(*(two_hex_digits+1)) ) ;
}
void ascii_line_to_binary_line(char *binary, char *ascii){
  for(int i=0; i<16; i++)
    binary[16-i-1] = hex_byte_to_bin(ascii + 2*i) ;
}  // ascii_line_to_binary_line()

