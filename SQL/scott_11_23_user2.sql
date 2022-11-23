SQL> conn test/1234
Connected.
SQL> select * from tab;

no rows selected

SQL> create table aaa(
  2  f1 number not null,
  3  f2 varchar2(20));
create table aaa(
*
ERROR at line 1:
ORA-01031: insufficient privileges 


SQL> conn system/981024
Connected.
SQL> -- test에게 테이블 생성 또는 변경할 수 있는 권한 설정하기
SQL> grant create table to test;

Grant succeeded.

SQL> conn test/1234
Connected.
SQL> create table aaa(
  2  f1 number not null,
  3  f2 varchar2(20));

Table created.

SQL> conn system/981024
Connected.
SQL> -- 롤 : 권한 묶음
SQL> -- connect : 접속
SQL> -- resource : 테이블 객체 관련 권한 설정
SQL> -- dba : 관리자 권한 설정
SQL> grant connect, resource to test;

Grant succeeded.

SQL> conn test/1234
Connected.
SQL> select * from tab;

TNAME                                                                           
--------------------------------------------------------------------------------
TABTYPE        CLUSTERID                                                        
------------- ----------                                                        
AAA                                                                             
TABLE                                                                           
                                                                                

SQL> insert into aaa values(1, 'DDDD');
insert into aaa values(1, 'DDDD')
            *
ERROR at line 1:
ORA-01950: no privileges on tablespace 'USERS' 


SQL> conn system/981024
Connected.
SQL> grant connect, resource to test;

Grant succeeded.

SQL> conn test/1234
Connected.
SQL> insert into aaa values (1, 'DDDD');
insert into aaa values (1, 'DDDD')
            *
ERROR at line 1:
ORA-01950: no privileges on tablespace 'USERS' 


SQL> conn system/981024
Connected.
SQL> grant unlimited tablespace to test;

Grant succeeded.

SQL> conn test/1234;
Connected.
SQL> insert into aaa values(1, 'DDDD');

1 row created.

SQL> conn system/981024
Connected.
SQL> create user test2 identified by 1234;

User created.

SQL> grant connect, resource, dba to test2;

Grant succeeded.

SQL> conn test2/1234
Connected.
SQL> -- test2계정에서 사용자계정 생성ㅅ
SQL> create user test3 identified by 1234;

User created.

SQL> conn test/1234
Connected.
SQL> create user test4 identified by 1234;
create user test4 identified by 1234
*
ERROR at line 1:
ORA-01031: insufficient privileges 


SQL> conn test2/1234
Connected.
SQL> grant resource, connect to test3;

Grant succeeded.

SQL> grant unlimited tablespace to test3;

Grant succeeded.

SQL> conn test3/1234
Connected.
SQL> create table BBBB(
  2  xxx number(3),
  3  yyy varchar2(10));

Table created.

SQL> insert into bbbb
  2  values(123, 'ABCD');

1 row created.

SQL> select * from bbbb;

       XXX YYY                                                                  
---------- ----------                                                           
       123 ABCD                                                                 

SQL> -- 권한 회수
SQL> conn test2/1234
Connected.
SQL> revoke dba from test2;

Revoke succeeded.

SQL> conn system/981024
Connected.
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
TEST2                                                                           
REMOTE_SCHEDULER_AGENT                                                          
SYS$UMF                                                                         
SYSBACKUP                                                                       
SYSRAC                                                                          
DIP                                                                             
SCOTT                                                                           

USERNAME                                                                        
--------------------------------------------------------------------------------
OPS$ORACLE                                                                      
DGPDB_INT                                                                       
TEST3                                                                           

36 rows selected.

SQL> -- test계정 비밀번호를 5678로 변경하라
SQL> alter user test identified by 5678;

User altered.

SQL> conn test/5678
Connected.
SQL> select * from tab;

TNAME                                                                           
--------------------------------------------------------------------------------
TABTYPE        CLUSTERID                                                        
------------- ----------                                                        
AAA                                                                             
TABLE                                                                           
                                                                                

SQL> conn system/981024
Connected.
SQL> -- 계정 잠그기
SQL> -- lock, unlock
SQL> alter user test account lock;

User altered.

SQL> conn test/5678
ERROR:
ORA-28000: The account is locked. 


Warning: You are no longer connected to ORACLE.
SQL> conn system/981024
Connected.
SQL> alter user test account unlock;

User altered.

SQL> conn test/5678
Connected.
SQL> select * from tab;

TNAME                                                                           
--------------------------------------------------------------------------------
TABTYPE        CLUSTERID                                                        
------------- ----------                                                        
AAA                                                                             
TABLE                                                                           
                                                                                

SQL> conn system/981024
Connected.
SQL> -- 계정 삭제하기
SQL> drop user test;
drop user test
*
ERROR at line 1:
ORA-01922: CASCADE must be specified to drop 'TEST' 


SQL> -- test계정에는 데이터가 있어서 삭제 불가
SQL> drop user test2;

User dropped.

SQL> drop user test cascade;

User dropped.

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
SYSDG                                                                           

USERNAME                                                                        
--------------------------------------------------------------------------------
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
DGPDB_INT                                                                       

USERNAME                                                                        
--------------------------------------------------------------------------------
TEST3                                                                           

34 rows selected.

SQL> drop user test3 cascade;

User dropped.

SQL> spool off
