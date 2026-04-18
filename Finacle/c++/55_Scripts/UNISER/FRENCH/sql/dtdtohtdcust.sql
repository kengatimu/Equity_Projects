/
REM ###########################################################################
REM File        : DTD_TO_HTD.SQL
REM
REM Description :    This sql is used to move the records directly from DTD to HTD 
REM                  and from DTH to HTD
REM                  The sql queries only on DTD and assumes that a tran id present 
REM                     in DTD will be present in DTH as well .
REM                     FoR movement to HTD , all the part trans within a tran id 
REM                     must have their EAB-GST and ISO recon completed.
REM                     Transactions are moved  tran-id wise and not part -tran 
REM                     wise .i.e in case even one part tran fails the above conditions 
REM                     the entire transaction will not be moved 
REM
REM Author      : Pramod Kamath
REM
REM Date        : 28-Nov-2006
REM ###########################################################################

SET HEAD OFF
SET FEEDBACK OFF
SET ECHO OFF
SET TERMOUT OFF
SET VERIFY OFF
whenever sqlerror exit sql.sqlcode

BEGIN--{

    insert into tbaadm.TTT
        select distinct tran_date,tran_id,bank_id
        from
        (
         select tran_date,tran_id,bank_id,cnt,sum(s1)
         over (partition by tran_date,tran_id,bank_id) s
         from
         (
          select /*+ index( dtd idx_dtd_init_sol_id) */ tran_date,tran_id,
          bank_id, count(*)
          over (partition by tran_date,tran_id,bank_id) cnt,
          case when
          ((eabfab_upd_flg = 'Y' and  GST_UPD_FLG in('Y','T')
            AND iso_flg!='N' and del_flg != 'Y')
           OR (del_flg='Y'))  then 1 else 0 end s1
          from tbaadm.DTD  where
               tran_date <= to_date('19-dec-2016','DD-MM-YYYY') and
          bank_id='54'
         )
        )
        where cnt = s;

    insert into 
        tbaadm.HTH
        ( 
         select * from tbaadm.DTH 
         where
         (tran_id ,tran_date,bank_id) in
         ( select  tran_id,tran_date,bank_id from tbaadm.TTT )) ;

    insert into tbaadm.HTD
        (  
         select * from tbaadm.DTD
         where (tran_id,tran_date,bank_id) in
         ( select tran_id,tran_date,bank_id from tbaadm.TTT ));
    --
    delete from tbaadm.DTD where (tran_id ,tran_date,bank_id) in (select tran_id,tran_date,bank_id from tbaadm.TTT) ;

    delete from tbaadm.DTH  where (tran_id ,tran_date,bank_id) in (select tran_id,tran_date,bank_id from tbaadm.TTT) ;

    delete from tbaadm.TTT;

    commit;
    end; --}
/
commit;
/
exit
/
