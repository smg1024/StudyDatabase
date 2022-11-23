SQL> conn system/981024
Connected.
SQL> drop user test;

User dropped.

SQL> create user test identified by 1234;

User created.

SQL> select username from dba_users;

USERNAME                                                                        
--------------------------------------------------------------------------------
SYS                                                                             
SYSTEM                                                                          
OUTLN                                                                           
LBACSYS                                                                         
XS$NULL                                                                         
GGSYS                                                                           
ANONYMOUS                                                                       
DVF                                                                             
DBSNMP                                                                          
GSMADMIN_INTERNAL                                                               
MDSYS                                                                           

USERNAME                                                                        
--------------------------------------------------------------------------------
XDB                                                                             
CTXSYS                                                                          
AUDSYS                                                                          
DBSFWUSER                                                                       
DVSYS                                                                           
APPQOSSYS                                                                       
POBY                                                                            
GSMUSER                                                                         
MDDATA                                                                          
GSMROOTUSER                                                                     
TEST                                                                            

USERNAME                                                                        
--------------------------------------------------------------------------------
SYSDG                                                                           
SYSKM                                                                           
ORACLE_OCM                                                                      
GSMCATUSER                                                                      
REMOTE_SCHEDULER_AGENT                                                          
SYS$UMF                                                                         
SYSBACKUP                                                                       
SYSRAC                                                                          
DIP                                                                             
SCOTT                                                                           
OPS$ORACLE                                                                      

USERNAME                                                                        
--------------------------------------------------------------------------------
DGPDB_INT                                                                       

34 rows selected.

SQL> -- 생성한 test계정 접속하기
SQL> conn test/1234
ERROR:
ORA-01045: user TEST lacks CREATE SESSION privilege; logon denied 


Warning: You are no longer connected to ORACLE.
SQL> -- 접속실패로 원래 접속되어있던 system도 접속이 끊어짐
SQL> conn system/981024
Connected.
SQL> -- test에게 접속 권한 부여
SQL> grant create session to test;

Grant succeeded.

SQL> conn test/1234
Connected.
SQL> spool off
