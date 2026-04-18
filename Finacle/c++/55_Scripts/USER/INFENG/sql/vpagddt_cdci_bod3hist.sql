Rem : File Name         vpagddthist.sql 
Rem : Date              28-09-2022
Rem : Description       Purge data from agddt to agddt_hist_tbl ( cdci transactions rcre time - 3 bod date )
Rem : Inputs            date,bankid
Rem : Author            Vino Palani
SPOOL agddt_tbl_to_hist.log

SET TIME ON

SET TIMING ON

SET SERVEROUTPUT ON

DECLARE
    agddt_cnt   NUMBER := 0;
    my_code       NUMBER;
    my_errm       VARCHAR2(3000);
    err_loc       NUMBER := 0;
    commit_flg    CHAR;
    CURSOR agddtcur IS
SELECT
    bank_id,
    foracid,
    sol_id,
    dmd_date,
    dmd_eff_date,
    dmd_ovdu_date,
    dmd_amt,
    tot_adj_amt,
    last_adj_date,
    dep_tran_id,
    dep_tran_amt,
    dep_dccid,
    dep_srl_num,
    dep_command,
    prev_acct_bal,
    aft_acct_bal,
    rcre_user_id,
    rcre_time,
    lchg_user_id,
    lchg_time,
    del_flg,
    entity_cre_flg,
    free_text1,
    free_text2,
    free_text3,
    free_text4,
    free_text5,
    ROWID
FROM custom.agddt
WHERE bank_id = '&1' 
AND dep_command <> 'CSWOP'
AND dep_dccid <> 'BATCH'
AND dep_srl_num <> 'NOSWEEPDIRECT_CREDIT'
--AND del_flg <> 'N'
AND entity_cre_flg = 'Y'
AND trunc(rcre_time) <= ( SELECT db_stat_date - 3 FROM tbaadm.gct where bank_id='&1' );
BEGIN
    commit_flg := 'N';
    FOR i IN agddtcur LOOP --{
        BEGIN
            agddt_cnt := agddt_cnt + 1;
            err_loc := 1;
            INSERT INTO custom.agddt_hist_tbl (
    bank_id,
    foracid,
    sol_id,
    dmd_date,
    dmd_eff_date,
    dmd_ovdu_date,
    dmd_amt,
    tot_adj_amt,
    last_adj_date,
    dep_tran_id,
    dep_tran_amt,
    dep_dccid,
    dep_srl_num,
    dep_command,
    prev_acct_bal,
    aft_acct_bal,
    rcre_user_id,
    rcre_time,
    lchg_user_id,
    lchg_time,
    del_flg,
    entity_cre_flg,
    free_text1,
    free_text2,
    free_text3,
    free_text4,
    free_text5
            ) VALUES (
    i.bank_id,
    i.foracid,
    i.sol_id,
    i.dmd_date,
    i.dmd_eff_date,
    i.dmd_ovdu_date,
    i.dmd_amt,
    i.tot_adj_amt,
    i.last_adj_date,
    i.dep_tran_id,
    i.dep_tran_amt,
    i.dep_dccid,
    i.dep_srl_num,
    i.dep_command,
    i.prev_acct_bal,
    i.aft_acct_bal,
    i.rcre_user_id,
    i.rcre_time,
    i.lchg_user_id,
    i.lchg_time,
    i.del_flg,
    i.entity_cre_flg,
    i.free_text1,
    i.free_text2,
    i.free_text3,
    i.free_text4,
    i.free_text5
            );

            err_loc := 2;
            DELETE FROM custom.agddt WHERE
                    ROWID = i.rowid
                AND
                    foracid = i.foracid
                AND
                    dep_srl_num = i.dep_srl_num
                AND
                    bank_id = i.bank_id;

            IF
                agddt_cnt = 100
            THEN
                COMMIT;
                agddt_cnt := 0;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                my_code := sqlcode;
                my_errm := sqlerrm;
        END;
    END LOOP;
                 --}

    COMMIT;
END;
/

SHO ERR
/
