exec dbms_stats.create_stat_table('CUSTOM','DTD_DTH_STATS');

grant analyze any to custom;

grant all on custom.DTD_DTH_STATS to tbagen,tbautil,tbaadm;

