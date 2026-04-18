#------------------------------------------------------------
# update_menu_CORPSIG.sql
#------------------------------------------------------------

set define off;

UPDATE tbaadm.mod
SET
MOP_TYPE = 'U',
EXE_NAME='https://$W/finbranch',
INPUT_FILENAME = 'Customize/Customize_ctrl.jsp?sessionid=$S', ADDITIONAL_PARAMS='&CORPSIG=$TCORPSIG=$SCORPSIG=$CCORPSIG=$'
WHERE MOP_ID='CORPSIG'
/
commit
/
