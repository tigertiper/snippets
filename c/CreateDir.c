#include<stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
int CreateDir(const char *sPathName)  
  {  
      char DirName[256];  
      strcpy(DirName, sPathName);  
      int i,len = strlen(DirName);
      for(i=1; i<len; i++)  
      {  
          if(DirName[i]=='/')  
          {  
              DirName[i] = 0; 
              if(access(DirName, NULL)!=0)  
              {  
                  if(mkdir(DirName, 0755)==-1)  
                  {   
                      printf("mkdir   error\n");   
                      return -1;   
                  }  
              }  
              DirName[i] = '/';  

          }  
      }  

      return 0;  
  } 

void main(){
    CreateDir("/dev/zvol/test/2/");
    symlink("/dev/dm-0", "/dev/zvol/test/2/1");  
}
