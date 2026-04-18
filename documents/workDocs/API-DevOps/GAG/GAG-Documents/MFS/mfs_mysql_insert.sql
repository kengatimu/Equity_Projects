SELECT * FROM `mfs-billers`.biller;

insert into `mfs-billers`.biller (id, biller_Code, notification_required, validation_required, created_on_utc, is_deleted, biller_category_id, 
daily_transaction_amount, is_featured, max_transaction_amount, min_transaction_amount, bank_id, presentment_required, listing_weight)
values
(1, '4020405', 0, 0, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20),
(2,'446773',  0, 0, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20),
(3, '090907',  0, 0, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20),
(4, '751107',  0, 0, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20),
(5, '070909', 0, 0, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20),
(6, '041000', 1, 1, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20),
(7, '979798', 1, 0, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20),
(8, '239017', 0, 1, '2023-11-22', 1, 10, 1000, 0, 20000, 100, 54, 1, 20);