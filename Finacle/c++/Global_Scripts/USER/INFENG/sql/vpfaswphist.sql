Rem : File Name         eb_faswp_tbl_to_hist.sql
Rem : Date              28-09-2022
Rem : Description       Purge data from eb_faswp_tbl to eb_faswp_hist_tbl
Rem : Inputs            date,bankid
Rem : Author            Vino Palani
SPOOL eb_faswp_tbl_to_hist.log

SET TIME ON

SET TIMING ON

SET SERVEROUTPUT ON

DECLARE
    ebfaswp_cnt   NUMBER := 0;
    my_code       NUMBER;
    my_errm       VARCHAR2(3000);
    err_loc       NUMBER := 0;
    commit_flg    CHAR;
    CURSOR ebfaswpcursor IS
        SELECT
            acct_id,
            backend_req_num,
            bank_id,
            dcc_id,
            dcc_req_num,
            del_flg,
            end_rec_cnt,
            entity_cre_flg,
            from_date,
            has_more_date,
            last_cls_bal,
            lchg_time,
            lchg_user_id,
            num_of_tran_cnt,
            offset_cnt,
            part_tran_type,
            rcre_time,
            rcre_user_id,
            request_date,
            req_to_date,
            sol_id,
            sort_order,
            total_rec_cnt,
            ROWID
        FROM
            custom.eb_faswp_tbl
        WHERE
                bank_id IS NOT NULL
            AND
                request_date <= (
                    SELECT
                        db_stat_date - 3
                    FROM
                        tbaadm.gct where bank_id='&1'
                );

BEGIN
    commit_flg := 'N';
    FOR i IN ebfaswpcursor LOOP --{
        BEGIN
            ebfaswp_cnt := ebfaswp_cnt + 1;
            err_loc := 1;
            INSERT INTO custom.eb_faswp_hist_tbl (
                acct_id,
                backend_req_num,
                bank_id,
                dcc_id,
                dcc_req_num,
                del_flg,
                end_rec_cnt,
                entity_cre_flg,
                from_date,
                has_more_date,
                last_cls_bal,
                lchg_time,
                lchg_user_id,
                num_of_tran_cnt,
                offset_cnt,
                part_tran_type,
                rcre_time,
                rcre_user_id,
                request_date,
                req_to_date,
                sol_id,
                sort_order,
                total_rec_cnt
            ) VALUES (
                i.acct_id,
                i.backend_req_num,
                i.bank_id,
                i.dcc_id,
                i.dcc_req_num,
                i.del_flg,
                i.end_rec_cnt,
                i.entity_cre_flg,
                i.from_date,
                i.has_more_date,
                i.last_cls_bal,
                i.lchg_time,
                i.lchg_user_id,
                i.num_of_tran_cnt,
                i.offset_cnt,
                i.part_tran_type,
                i.rcre_time,
                i.rcre_user_id,
                i.request_date,
                i.req_to_date,
                i.sol_id,
                i.sort_order,
                i.total_rec_cnt
            );

            err_loc := 2;
            DELETE FROM custom.eb_faswp_tbl WHERE
                    ROWID = i.rowid
                AND
                    dcc_req_num = i.dcc_req_num
                AND
                    backend_req_num = i.backend_req_num
                AND
                    bank_id = i.bank_id;

            IF
                ebfaswp_cnt = 100
            THEN
                COMMIT;
                ebfaswp_cnt := 0;
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
