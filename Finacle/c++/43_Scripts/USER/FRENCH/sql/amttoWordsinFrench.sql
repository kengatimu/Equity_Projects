CREATE OR REPLACE function CUSTOM.spell_number_french( p_amt in varchar )
return varchar2
as
begin
    return replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace( replace( replace(
           replace( replace( replace( replace( replace(
           replace( replace( replace( replace( replace(
           replace( replace( replace( replace( replace(
           replace( replace( replace( replace( replace(
           replace( replace( replace( replace( replace(
           replace( replace( replace( replace( replace(
           replace( replace( replace( replace( replace(
           replace(
           lower(p_amt)
           , 'duodecillion', 'Bidecillion'     )
           , 'quintillion' , 'Cintillion'      )
           , 'billion'     , 'Milliard'        )
           , 'thousand'    , 'Mille'           )
           , 'hundred'     , 'Cent'            )
           , 'ninety'      , 'Quatre-Vingt-Dix')
           , 'eighty'      , 'Quatre-Vingt'    )
           , 'seventy'     , 'Soixante-Dix'    )
           , 'sixty'       , 'Soixante'        )
           , 'fifty'       , 'Cinquante'       )
           , 'forty'       , 'Quarante'        )
           , 'thirty'      , 'Trente'          )
           , 'twenty'      , 'Vingt'           )
           , 'nineteen'    , 'Dix-Neuf'        )
           , 'eighteen'    , 'Dix-Huit'        )
           , 'seventeen'   , 'Dix-Sept'        )
           , 'sixteen'     , 'Seize'           )
           , 'fifteen'     , 'Quinze'          )
           , 'fourteen'    , 'Quatorze'        )
           , 'thirteen'    , 'Treize'          )
           , 'twelve'      , 'Douze'           )
           , 'eleven'      , 'Onze'            )
           , 'ten'         , 'Dix'             )
           , 'nine'        , 'Neuf'            )
           , 'eight'       , 'Huit'            )
           , 'seven'       , 'Sept'            )
           , 'five'        , 'Cinq'            )
           , 'four'        , 'Quatre'          )
           , 'three'       , 'Trois'           )
           , 'two'         , 'Deux'            )
           , 'one'         , 'Un'              )
           , '-Dix six'     , ' Seize'           )
           , '-Dix Cinq'    , ' Quinze'          )
           , '-Dix Quatre'  , ' Quatorze'        )
           , '-Dix Trois'   , ' Treize'          )
           , '-Dix Deux'    , ' Douze'           )
           , '-Dix Un'      , ' Onze'            )
           , '-un '        , '-Une '           )         
           , 'Une'         , 'Un'           )
       , 'and Mille'   , 'et Un Mille'     )
       , 'and Cent'    , 'et Un Cent'      )
       , 'and'         , 'et')
	   , 'Vingt Un','Vingt et un')
	   , 'Trente Un','Trente et un')
	   , 'Quarante Un','Quarante et un')
	   , 'Cinquante Un','Cinquante et un')
	   , 'Soixante Un','Soixante et un')
	   , 'Soixante Onze','Soixante et onze')
	   , 'Quatre-Vingt Onze','Quatre-Vingt et onze')
	   , 'Cent et Un','Cent un')
	   , 'Un Cent'     , 'Cent'            )
	   , 'Un Mille'    , 'Mille'           );
end spell_number_french;
/
