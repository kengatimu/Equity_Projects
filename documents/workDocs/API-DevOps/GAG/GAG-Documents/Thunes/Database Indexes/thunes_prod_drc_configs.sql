
Insert into  [dbo].[imt_core_configs] values(729,'4e6650c2-79be-4c6c-b7e4-ac9e363271d3', 'Thunes DRC AuthKey', 'thunes.cod.auth.key', '4e6650c2-79be-4c6c-b7e4-ac9e363271d3');
Insert into  [dbo].[imt_core_configs] values(730,'D6745BD8-603F-4848-9209-F301B34AB809', 'Thunes DRC AuthSecret', 'thunes.cod.auth.secret', 'D6745BD8-603F-4848-9209-F301B34AB809');

update  [dbo].[imt_core_configs] set config_bin_value='BWA,BDI,MWI,RWA,TZA,UGA,ZMB,ZWE,AUS,BGD,BEN,BRA,BFA,CHL,CHN,FRA,DEU,LVA,ESP,SVN,SVK,SMR,PRT,NLD,MCO,MLT,LUX,LTU,ITA,IRL,GRC,CYP,FIN,EST,BEL,AUT,BGR,HRV,CZE,MYS,MEX,NER,NGA,PAK,DNK,HUN,ISL,LIE,NOR,POL,ROU,SWE,AND,CHE,VAT,GHA,GNB,HKG,IND,IDN,CIV,MLI,SGP,ZAF,KOR,LKA,THA,TGO,VNM,PHL,SEN,GBR,CAN,ARE,CMR,COD,ETH,ISR,JPN,MDG,TUR,IOT,KEN,SAU,SOM', config_value = 'Thunes Corridors' 
where config_id = 'thunes.corridor.country.code';
















