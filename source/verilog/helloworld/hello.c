//-------------------------------------------------------------------------
// File       : hello.c
// Design     : hello
// Descrition : Print "Hello World" in console, using PLI.
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 19 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------
#include "veriuser.h"
static int hello()
{
  io_printf("Hello World!\n");
}
static s_tfcell veriusertfs[] = {    // define task
  {usertask, 0, 0, 0, hello, 0, "$hello", 0},
  {0}
};
void init_usertfs()    // function to init!
{
  p_tfcell usertf;
  for (usertf = veriusertfs; usertf; usertf++) {
    if (usertf->type == 0)
      return;
    mti_RegisterUserTF(usertf);
  }
}


