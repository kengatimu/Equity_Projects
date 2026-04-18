for file in *.js
    do
       echo $file >> FilesModified.file 

sed 's~"AutoTOD Contract Maintenance"~"Maintenance du  Contrat  Auto TOD"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function Code"~"Fonction Code"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contract ID"~"ID du Contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"-- Select--"~"Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A-Add"~"A-Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M-Modify"~"M-Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X-Cancel"~"X-Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"T-Terminate"~"T-Terminer/ Résilier  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-Verify"~"V-Vérifier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I-Inquire"~"  I- S’informer/ Enquêter  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"E-Enhance Extend"~"  E-Etendre l’augmentation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Z-ModifyEnhancement"~" Z-Modifier l’augmentation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"AutoTOD Contract Maintainence"~" Maintenance du  contrat Auto TOD"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Name"~"Nom \(intitulé\) du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SolId"~"Solde"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Scheme Code"~"Code du système  \(combinaison\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Min Contract Amount"~"Montant minimum du contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Max Contract Amount"~"Montant maximal du contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Max Contract Period"~"Période maximale du contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contract CCY/Amount"~"Contrat CCY / montant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contract Period"~" Période du contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charges"~"les Charges"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Terminate Reason Code"~" Code de la  raison de résiliation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"AutoTOD Contract Maintenance"~"Maintenance du contrat Auto TOD"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"General"~" Général"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"G"~"G"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Link Collaterals"~" Raccord des gages \(garanties\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"K"~"K"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/C Interest"~"Compte d'' Intérêt "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"C"~"C"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Details"~"Détails du prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"S"~"S"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"LA Interest"~"Intérêts  LA"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A"~"A"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Payment Schedule"~"Echéancier du remboursement "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Y"~"Y"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Refinance And Subsidy"~" Refinancement et subvention"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"U"~"U"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Related Party"~"Partie liée"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"P"~"P"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Multi Source Instruction"~"Instruction multi-sources"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"N"~"N"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MIS Codes"~"Codes MIS"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M"~"M"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Error Details"~"Détails de l''erreur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"R"~" R"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Savings Home"~"Maison d''épargne"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"H"~"H"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Document"~"Document"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D"~" D"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Internal Notes"~" Notes internes"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"T"~" T"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Fees"~"Frais"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"F"~" F"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rebates & Clawback"~"Remise et récupération"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"W"~"W"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Disbursement Schedule"~" Programme de déboursement "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"B"~"B"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Others"~" Autres"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"O"~"O"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Addl. Info."~"Ajouter  l’information ."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I"~" I"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Builder Details"~"Détails de l’entrepreneur "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"E"~"E"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contract Details"~" Détails du contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"J"~"J"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rescheduling Details"~"Détails de reprogrammation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"L"~"L"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OverDue Details"~"Détails échus "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"O"~" O"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account"~"Compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amount"~"Montant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--SELECT--"~"SELECTIONNER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Related Party Details"~"Détails de la partie liée"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Name"~"Nom"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Relation Code"~" Code de relation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Designation Code"~"Code de désignation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Address Line 1"~"Ligne d''adresse 1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Address Line 2"~"Ligne d''adresse 2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Address Line 3"~"Ligne d’adresse 3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"City"~"Ville"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"State"~"Etat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Country"~"Pays"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Postal Code"~" Code postal"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Phone No. 1"~"Numéro de téléphone 1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Phone No. 2"~"Numéro de téléphone 2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Fax No."~" Numéro de fax"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Email ID"~"Identification de l''e-mail"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tax ID No."~"Numéro d''identification fiscale"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Del."~"Supprimer."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text"~"Aucun texte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CIF ID"~"Identifiant CIF      "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 2"~"Aucun Texte  2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 3"~"Aucun Texte  3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 4"~"Aucun Texte 4"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Submit"~"Envoyer  \(soumettre\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cancel"~"Annuler /Effacer "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OK"~" OK"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Validate"~"Valider"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Clear"~"Effacer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Go"~" \(Aller\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Inquiry"~"Information \(recherche\) de la transaction \(transfert\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c. ID"~"Identifiant du compte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"From Date"~"De  telle date "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Date"~"À  telle date "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"From Amt."~"De tel montant "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Amt."~"A  tel montant "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"From Instrument No."~" De tel  mécanisme "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Instrument No."~"À   tel   mécanisme "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Order By"~"Consigner \(Arrêter\)  par "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Last 'n' Transactions"~"Dernières transactions \(transferts\) ''n''"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c.ID"~"Identifiant du compte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CCY/SOL ID"~"Identifiant CCY / SOL"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c.Name"~"Nom du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"General Ledger Subhead Code"~" Code général du grand livre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Balance"~"Solde"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Opening Balance"~" Solde d''ouverture"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Closing Balance"~" Solde de clôture"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Float Balance"~" Solde fébriles "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Funds in Clearing"~"Fonds en compensation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Available Amt."~"Montant disponible."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Effective Available Amt."~"Montant réel disponible ."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Customer Status"~"Statut  du client"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c. Opening Date"~"Date d''ouverture du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c. Status"~"Statut du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c. Status Date"~"Date de statut du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Purge Date"~" Date d’assainissement "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Address"~" Adresse"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"City"~" Ville"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"State"~" État"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Country"~" Pays"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Postal Code"~"Code postal"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Phone Type"~"Type de téléphone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Telex No."~" Numéro  télex"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Phone No."~"Numéro de téléphone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Email ID Type"~"Type d''identification d’email"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Email ID"~"Identification de l’email "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ok"~"OK"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OK"~"OK"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"File Name "~" Nom du fichier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function Code "~" Code de réception "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account No "~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Employer "~"Employeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amount "~"montant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Score "~"Compte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Period\(in Months\) "~"Période \(en mois\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"-- Select--"~" Sélectionner"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A-Add "~" A-Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M-Modify "~"M-Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I-Inquiry "~" I-Enquêter/S’informer/Demander "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Z-Close "~"Z-Fermer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-Verify "~"V-Vérifier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"U-Upload "~"U-Télécharger "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol ID "~" ID du sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Test?\(Y/N\)"~"Test? \(O / N\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Remarks"~"Remarques"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select"~"Sélectionner"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"P-Process"~"P-Processus "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"START DATE "~"DATE DU  DÉBUT"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"END DATE"~"DATE DE  LA  FIN"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Request Id"~"Demande de  l’ Identifiant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No Of chqbooks"~"Non du chéquier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ChqStart SerialNo"~"Numéro de début du série cheque "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ChqEnd SerialNo"~"Numéro de la fin du série cheque "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Request Status"~"Demande de la  situation \( statut, Etat\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~" Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SET ID"~"SET ID \(Etablissement du numéro d’identification\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ZONE DATE"~" DATE DE LA ZONE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ZONE CODE"~"CODE DE LA  ZONE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--SELECT--"~"SELECTIONNER --"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Report To"~"Signaler \(rapporter\) à  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Sub Type"~"Type de de sous transaction \(transfert\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Upload File Name"~"Télécharger le nom du fichier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Test Mode"~"Mode de test"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Remarks"~"Remarques du Transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rename Input File"~" Renommer le fichier d''entrée"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Code 3"~" Aucun Code  3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~""~""~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Payee Nick Name"~"Nom du bénéficiaire "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Code 1"~"Aucun Code  1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Code 2"~"Aucun Code  2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"L - Limit"~": L - Limite"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Debit A/c. No."~"Numéro de compte débiteur "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transfer"~" Transfert"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OK"~" OK"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 4"~" Aucun Texte  4"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 3"~"Aucun Texte 3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Autopay Information"~" Information de l’ Autopay"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 2"~"Aucun Texte  2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Customer Information"~"Informations du client"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Autopay Mode"~"Mode Autopay"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Registration Charge Code"~"Code de frais d''inscription \(enregistrement, suscription\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 5"~"Aucun Texte  5"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit Card Type"~"Type de carte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Payment Mode"~" Mode de paiement"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit Card"~"Carte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CIF ID"~"Identifiant CIF"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Waiver Reason Code"~"Code motif de renonciation \(sauvegarde\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Waiver of Charges"~" Renonciation \(sauvegarde\)  de  frais \(obligation\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Waiver Start Date"~" Date de début de  renonciation \(sauvegarde\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select"~"Sélectionnez"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Waiver End Date"~"Date de fin de  renonciation \(sauvegarde\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Submit"~"Envoyer/soumettre "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cancel"~" Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"F - Full"~"F – Complet \(full\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Validate"~"Valider"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Yes"~"Oui"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Customer Name"~" Nom du client"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller ID"~"ID de Biller"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit Card Expiry Date"~": Date d''expiration de la carte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller Name"~": Nom du Biller"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No"~"Non"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Autopay Limit Amt."~"Limite du montant autopay."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller Service ID"~"ID du service de facturation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CVV No."~"Numéro CVV "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller Service Name"~"Nom du service de la  facturation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit Card No."~" Numéro de carte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Autopay"~"Autopay"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Name on Credit Card"~"nom sur la carte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M - Min."~" M - Min."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Subscription Start Date"~"Date de début de l''abonnement"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function "~"Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select "~"Sélectionnez"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"U-Upload "~"U-Télécharger "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M-Modify "~" M-Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I-Inquire "~" I-S ’informer /Enquêter/Demander"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D-Delete "~": D-Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Serial Number "~" Numéro de série"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"BWY Req ID "~"Identifiant BWY requis"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Oper. A/C"~"Compte Opérationnel"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Oper Chrg A/C"~"Opération de Charge \(taxe, impôt\)  A / C"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency"~" Devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amount"~" Montant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Value Date"~"Date de valeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Dr. Cust Name"~" Nom du Dr. Client "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Dr. Cust Addr 1"~"Dr. Client Adresse   1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Dr. Cust Addr 2"~" Dr. Client  Adresse  2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Dr. Cust Addr 3"~"Dr. Client  Adresse  3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Dr. Cust Cnt"~" Dr. Client  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. Cust Name"~" Nom du client "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. Cust Addr 1"~" Cr. Client  Adresse 1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. Cust Addr 2"~" Cr. Client  Adresse  2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. Cust Addr 3"~" Cr. Client  Adresse 3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. Cust Cnt"~"Cr. Client "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bene Bank BIC"~" Banque BIC "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Payee Cor. BIC"~" Bénéficiaire Cor. BIC"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Lodged Bill ID"~" ID du \(facture, relevé, bon\)  consigné"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bill Rel. Date"~" date du  \(facture, relevé, bon\)  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Status"~"Statut"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Serial Number"~"numéro de série"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Report To"~" Signaler/Rapporter  à"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Sub Type"~"FLT026333: "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"DATE\(dd-mm-yyyy\)"~"FLT026334: "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"upload file name"~"FLT026334: Nom du fichier à télécharger "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Test?\(Y/N\)"~"FLT026335: Test? \(O / N\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran.Remarks"~"FLT026336: Remarque du transaction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"DUPLICATE"~"COPIE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"DOWNLOAD ID"~" ID  DU TÉLÉCHARGEMENT  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol ID "~" ID  du solde "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number "~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Status"~" Statut/Etat/Situation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SELECT"~"SELECTIONNER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"E-Request"~" E-demande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A-Authorised"~"A-Autorisé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D-Deleted"~"D-Supprimé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"S-Processed"~" S-Traitée"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Id"~" Identification du compte \( ID du compte\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Leaves\(25/50/100\)"~": Feuilles, pages \(25/50/100\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instr Type"~" Type d''instrument/mécanisme"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Role Id"~" rôle de ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~" Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--SELECT-- "~"SELECTIONNER--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Add "~"Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Delete "~" Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Verify "~"Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Modify"~"Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Inquire"~"Demande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency"~"Devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Role ID "~"Identifiant du rôle "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cash Cred Lmt"~" Lmt Cred Cash 5\( limite de crédit de liquidité ou cash crédit \) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transfr Cred Lmt"~"Transfr Cred Lmt \( limite de transfert de crédit \)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Clearng Cred Lmt "~"Clearing Cred Lmt  \(solde de crédit de liquidité\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cash IntSol Lmt"~"Trésorerie Int Sol Lmt \( limite de solde initial de la trésorerie\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transfr IntSol Lmt "~"Transfr Int Sol Lmt  \(limite de transfert initial du solde\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Clrg IntSol Lmt "~"Clrg Int Sol Lmt  \(limite de solde de liquidité\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency"~" Devise/Monnaie"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ADD"~" AJOUTER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MODIFY"~"MODIFIER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"VERIFY"~" VERIFIER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"INQUIRE"~"DEMANDE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CANCEL"~"ANNULER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Current Status"~"État actuel"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"New Status"~"Nouveau statut/Nouvelle situation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A-Activate"~"A-Activer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-Verify"~" V-Verifier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X-Cancel"~" X-Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"R-Reject "~"R-Rejeter "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X-Cancle "~" X-Annuler "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Originator Code"~"Code de l''expéditeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"File Name"~"Nom du fichier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr.A/c ID"~"Cr.A / c ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Test Mode\(Y/N\)"~"Mode test \(O / N\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Code"~"Code de la facturation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"From Period"~" de telle  période"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Period"~"à l’autre  période"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Print details when no transactions"~": Imprimer les détails lorsqu''aucune transaction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Print"~"Imprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran.Particulars"~"Transfert \(transaction\) des  particuliers "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rename input File"~" Renommer le fichier d''entrée"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number "~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Paysys ID "~"  ID du pays"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Test? \(Y/N\)"~"\(O / N\) Test?"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SOL "~" SOLDE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OLD NUM "~"ANCIEN NUMERO"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"USER ID"~"ID DE L’UTILISATEUR"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency Code"~" Code de la  devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select "~"Sélectionner"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Add "~"Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Modify "~" Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Inquire "~"Demande /Enquête"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Delete "~": Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency Code"~" Code de devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rate Code"~"Code tarifaire"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"PnL Account"~"Compte PnL"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Home Cy Account"~" Compte Cy \(local\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Foreign Cy Account"~" Compte Cy étranger"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ADD"~"AJOUTER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MODIFY"~"MODIFIER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"INQUIRE"~"DEMANDE "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"DELETE"~" SUPPRIMER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Code "~"Code de la  zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Date "~" Date de la zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instr Type"~"Type d''instrument \(mécanisme\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Begin ChqNO"~"Commencer Numéro de cheque "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No Of Leaves"~"Numéro \(nombres\) des feuilles  \(pages\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D-DESTROY"~": D-DETRUIRE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"S-STOP"~"S-ARRETER "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I-INQUIRE"~": I-INFORMER /ENQUETER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D-DESTORY"~"D-DETRUIRE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-Verify"~" V-Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X-CANCEL"~"X-ANNULER "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A - Add"~" A - Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"U - Issue"~"U - Problème"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I - Inquire"~" I – Demander/s’informer "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D - Delete"~": D - Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V- Verify"~"V- Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select"~" Sélectionnez"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"R-Reject"~": R-Rejeter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Number"~": Numéro d''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Amount"~"Montant de l''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SOL ID"~"ID du  SOLDE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number "~" Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Number"~"Numéro d''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Amount"~"Montant de l''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rejection Code"~" Code de rejet"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Code"~"Code de la  zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Date"~"Date de la zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Drawee Bank Code"~"Code de la banque debitrice "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Value Date"~": Date de valeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Drawee Branch Code"~"code de l''agence débitrice"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Drawee Sort Code"~" Code de tri  debiteur "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Pres Bank Code"~"Code banque Pres"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Pres Branch Code"~"Code de l''agence Pres"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Issue Bank code"~"Code de la banque d''émission"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Issue Branch code"~" Emettre le code de succursale"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Remarks"~" Remarques de Transaction \(transfert\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Pres Sort code"~": Pres Code de tri"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function\(V/X\) "~"Fonction \(V / X\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-Verify "~"V-Vérifier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X-Cancel "~"X-Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set Number "~" Définir le numéro"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Foracid "~" Foracide"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol Id"~"Id Sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set No"~"Définir No"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~" Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Date"~"Date de la zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Code"~"Code de la zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set No."~"Définir le Numéro."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~" --Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A - Add"~"A - Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D - Delete"~"D - Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"G - Regularize"~"G - Régulariser"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I - Inquiry"~"I - Demande des renseignements \(informations\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M - Modify"~"M - Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"R - Release"~" R - Libération"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V - Verify"~" V - Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"O - Outward Reject"~" Rejet externe"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bill Payment"~"Paiement de facture"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller ID"~"ID de Biller"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Type of Service"~"Type de service"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set No."~"Définir No."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit Account ID"~": ID de compte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ref. CCY/Amt."~"Réf. CCY / Montant."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rate Code/Rate"~"Code / tarif"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Type"~" Type d''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Alpha/Srl. No."~"Instrument Alpha / Srl. No."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Particulars"~"Détails de transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Remarks"~"Remarques sur la transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sort Code"~" Code de tri"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Particulars"~": Détails de transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Amount"~"Montant de l''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Amount"~"Montant facturé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Net Amount"~"montant net"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Nostro Account ID"~"ID de compte Nostro"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Date"~"Date de l''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Code"~"Code de la  zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Date"~" Date de la zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone CCY"~"Zone CCY"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Value Date"~" Date de valeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Paying Account ID"~"ID du compte payant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit A/c. Entity ID"~"Identifiant de l''enité du compte Crédit "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bank Code"~"Code bancaire"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Branch Code"~"Code del''agence"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Entity ID"~"ID d''entité d''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Target Zone Code"~"Code de la zone cible"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Target Sol Id"~"ID  du Sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Target Zone Date"~"Code de la zone cible"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Target Set No."~"N ° de l''ensemble de cibles"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Vostro Account ID"~" ID de compte Vostro"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Status"~"Status"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Init Entity Tran ID"~"ID de l''entité Initial du Transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Target Entity Tran ID"~" ID de l''entité cible Transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Tran ID"~" ID  Transaction \(transfert\)  facturé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Reject Reason"~" Raison rejetée "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Type"~"Type de transaction \(transfert\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Module Name"~" Nom du module"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Parameter Id"~"Idnetifiant de parametres"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol Id"~"Identifiant Sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"R - Reverse"~"R-Renverser"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I - Inquire"~" I – Demande /s’informer "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"C - Cancel Parameter"~"C - Annuler le paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V - Verify Parameter"~"V - Vérifier le paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MV - Modify Parameter Value"~"V - Modifier la veleur de paramètres"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"VV - Verify Parameter Value"~"VV - Vérifier la valeur de paramètres"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I - Inquire Parameter Value"~"Demander la valeur du paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CV - Cancel Parameter Value"~"Annuler la valeur du paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"DV - Delete Parameter Value"~" effacer la veleur de paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"VDV - Verify Deleted Parameter Value"~"Verifier le parametre effacé "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CD - Cash Deposit"~"CD - Dépôt en espèces"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CW - Cash Withdrawal"~"CW-retrait d''espece"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"TT - Transfer Transaction"~"TT-Transaction de transfert"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CL - Clearing"~"CL-liquidation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction ID"~"Identifiant de Transaction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Date"~"Date de la transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Ref No"~"Numéro de reference de transaction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency Code"~"Code monnaie"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Generic Level Code"~"Code de niveau générique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Generic Level Id"~"Identifiant de niveau générique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol Id"~"Identifiant Sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Type"~"Type d''operation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Remarks 1"~"Remarques 1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Remarks 2"~" Remarques 2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Particulars Code"~"Code de détails de transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amt. in A/c. CCY"~"FLT000714: Remarques 2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ref. No."~"FLT000709: Code de détails de transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Debit Account ID"~"Identifiant du montant débiteur "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Get Signature"~"Numéro de référence ."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Date"~"Date d''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Debit A/c. Entity ID"~"Identifiant de l''entité du compte débiteur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit A/c. Entity ID"~"Idnetifiant du compte créditeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"NI - Numeric Integer"~" NI - Entier numérique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"NF - Numeric Float"~"NF - Flotteur numérique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CH - Char"~"CH - Char"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"AN - Alpha Numeric"~"AN - Alpha Numérique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"AC - Account"~"AC - Compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"PL - Place Holder"~"PL - Espace reservé "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"GL - GL Sub Head Code"~"GL - GL Sous-code principal "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CF - CIF Id"~"ID CF - CIF"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SC - Scheme Code"~" SC - Code de schéma"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"PA - Payment To A/c. GL"~" PA - Paiement à A / c. GL"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Ref No."~"numéro du transaction "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"TF - Transfer Funds To Other Entity A/c."~" TF - Transférer des fonds à une autre entité A / c."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"RF - Receive Funds From Other Entity A/c."~"RF - Recevoir des fonds d''une autre entité A / c."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit A/c. Entity ID"~"Idnetifiant de l''entité du compte créditeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Treasury Ref. No./Rate"~" Numéro de Référence  ./Taux "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"LS - List Static"~" LS - Liste statique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"LD - List Dynamic"~" LD - Liste dynamique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Debit Account ID"~"ID de compte de débit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Incoming CP Account ID"~" ID du compte CP entrant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Debit A/c. Entity ID"~"Idnetifiant de l''entité du compte débiteur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Treasury Ref. No./Rate"~"No de Réf  ./Taux"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Treasury Ref. No./Rate"~"No de Réf  ./Taux"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cash Transaction"~" Transaction \(transfert\)  en espèces"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Document Type"~"Type de document"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"P - Passport"~" P - Passeport"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Document ID"~"ID de document"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sender Name"~"Nom de l''expéditeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Additional Details"~"Détails supplémentaires"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Receiver Name"~" Nom du destinataire"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"N - National ID"~" ID de  nationale"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Treasury Ref. No./Rate"~"No de Réf  ./Taux"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Phone No."~" Numéro de téléphone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Credit Account ID"~"ID de compte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function "~" Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Enterer_UserId "~" Id utilisateur entrant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Initiating SolId "~": Id Solde initial "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account''S SolId"~" Id Sol du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MERCHANTS MAITENANCE SCREEN"~"FLT031701: TRAME \(TABLEAU\)  DE MAITENANCE DES COMMERÇANTS"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"- Select -"~"Sélectionnez -"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I - Inquire"~": I – Information "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A - Add"~"A - Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M - Modify"~" M – Modifier   "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V - Verify"~"V - Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D - Delete"~" D - Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MERCHANTS NAME"~" NOM DES COMMERCANTS "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"TERMINAL/POS ID"~"ID TERMINAL / POS"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"PURCHASE PAYABLE A/C"~"ACHAT  PAYABLE A / C"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CASHBACK PAYABLE A/C"~" CASHBACK  PAYABLE  A / C \(remboursement payable\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CASHBACK COMM A/C"~" CASHBACK  COMMANDE   A / C  \(Commande du remboursment\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SETTLEMENT A/C"~"COMPTE DE REGLEMENT s"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CASHBACK COMM\(%\)"~"  CASHBACK COMMANDE  \(%\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"PURCHASE COMM\(%\)"~" COMMANDE  D’ACHAT \(%\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CHANNEL ID"~"ID DU CANAL \(CHAINE\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CONFIRM\(Y/N\)"~"CONFIRMER \(O / N\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cancel"~": Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MERCHANTS RESULT SCREEN"~"TRAME \(TABLEAU\)  DE RÉSULTAT DES MARCHANDS"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Scheme Code"~"Code de schéma"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Date"~" Date"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"B-Block"~"B-Bloc \(blocage\)  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"U-Unblock"~"U-Déblocage "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CIF ID"~": ID CIF"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select "~"Sélectionnez"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Modify "~" Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Inquire "~"date "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Delete"~"Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Customer ID "~"ID client"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Message1 "~"Message1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Message2 "~"Message2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Message3 "~"Message3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Message4 "~"Message4"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Message5 "~"Message5"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Message6 "~" Message6"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Message7 "~"Message7"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Commit Changes\(Y/N\)"~"Modifications de validation \(O / N\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~" --Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ADD"~"AJOUTER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MODIFY"~" MODIFIER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"DELETE"~": SUPPRIMER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Name "~"Nom du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Last Modified by "~"Dernière modification par"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Last Modified on "~"Dernière modification "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Order Capture Screen"~"Écran \(Capture de la commande du prêt\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function Code"~": Code de fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Account"~"Compte de prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Account Name"~"Nom du compte de prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cust ID"~"ID de la carte de crédit"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Acid"~"Acide du prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Scheme Code"~"Code du schéma"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"MIS Code"~"Code MIS"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Date"~"Date du prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Operative Account"~"Compte opérationnel"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Amount"~" Montant du prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Status"~"Statut/situation/état"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Order No."~"Numéro de commande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Own Contrib Amount"~"Montant de  contribution du personnelle"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contribution Account"~" Compte de contribution"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Recover Charges From?"~" Récupérer/relever les charges \(redevances\)  du ?"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"New"~" Nouveau"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Verified"~"Vérifié"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Pending"~" en attente"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Order Capture  Details Screen"~"Tableau de  Détails de capture d''ordre de prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ref Code"~"Code de référence"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Item Code"~" Code article"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Item Description"~": Description de l''article"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Unit Price"~" Prix unitaire"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Delete Flag"~"Supprimer le tableau"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Total Amount"~" Montant total"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan Order Capture Result Screen"~" Tableau  de résultat de capture d''ordre de prêt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ACCOUNT NO"~"Numéro du COMPTE "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Customer ID"~"ID du client"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"From Date"~": Date de début"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Date"~"à ce jour"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function "~"FLT026339: Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Print"~" Imprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select"~"Sélectionnez"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OCLG"~" OCLG"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OCLG2"~"OCLG2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set Id "~"Définir l''ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rpt Option "~"Option Rpt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Corporate SIG"~" SIG d''entreprise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CORPSIG menu for SVS"~"Menu CORPSIG pour SVS"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ok"~"Ok"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Parameter Level"~": Niveau de paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A - Add New Parameter"~" A - Ajouter un nouveau paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M - Modify Parameter"~"M - Modifier le paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"BNKL - Bank Level"~" BNKL - Niveau de banque"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SOLL - Sol Level"~"SOLL - Niveau Sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SCHM - Scheme Code Level"~"SCHM - Niveau du code de schéma"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CURL - Currency Level"~" CURL - Niveau du devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SHCR - Scheme Code Currency Level"~"SHCR - Niveau du devise du code de schéma"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"GENL - Generic Level"~" GENL - Niveau générique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Scheme Code"~" Code de schéma"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Parameter Level"~" Niveau de paramètre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Module Name"~"Nom du module"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol Id"~": Identification du  Solde"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Scheme Code"~"Code du schéma"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency Code"~"code la monnaie \( devise\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Generic Level Code"~"code du niveau de générique "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Generic Level Id"~"Id  du niveau de générique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Parameter Id"~"Paramètre de l’identité"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Parameter Description"~"description du paramètre "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Parameter Type"~"Type de paramètre "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Parameter Value"~"valeur du paramètre "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"List Type"~"type de liste "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Query Name"~"nom du point \(question\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Query Id"~"Id  du point "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Query Details"~"détails du point "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"FT - Free Text"~"FT -  aucun texte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Module ID"~"Module ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"--Sélectionner "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A-ADD"~"A-AJOUTER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I-INQUIRE"~"I-DEMANDER/S’INFORMER "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M-MODIFY"~"M-MODIFIER "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D-DELETE"~"D-EFFACER"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-VERIFY"~"V-VERIFIER "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X-CANCEL"~"X-ANNULER "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Label 1"~"Etiquette  1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Label 2"~"Etiquette  2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Module Id"~"Module Id"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Module Desc"~"Module Desc"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--SELECT--"~"--SELECTIONNER--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Employer ID"~"ID de L’employé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"File Name"~"Non du dossier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Name Mismatch"~"le nom mal assorti "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Dr.A/c.ID"~"Dr.A/c.ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Upload Type"~"Type de téléchargent "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Place Lien"~"Rétention  de place "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Test Mode"~"Mode de teste "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rename File"~"Renommé le dossier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Process"~"Procédure "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Upload"~"Télécharger "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"S-Statement P-Postage "~"S-relevé  P-Tarif "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ID Number"~"Numéro d’ Identification"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Share Purchase Page"~"Partage de page d’achat "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Type"~"Type de transaction "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CDSC Number"~"Numéro  CDSC"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Order Number"~"Numéro d’ordre "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"Numéro de compte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"--Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A--Add"~"A—Ajouter "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"H--Hold"~"H—retenir "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I--Inquire"~"I—Enquêter/Demander"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V--Verify"~" V - Verifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Transfer--"~"Transfer-"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Cash--"~"\(Espèce, devise, monnaie\)--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Id"~"ID de la transaction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Trading System-Share Purchase Details"~"FLT031859: Système d''échange – Détails d''achat "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Reference Number"~"FLT032156: Numéro de référence"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Id"~"FLT031850: ID du transaction \(transfert\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Serial Number"~"FLT032220: Numéro de série"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Date"~"FLT021862: Date de transaction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Mark Lien"~"FLT013609: marquer la rétention "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Remarks"~"FLT031854: Remarques Transaction \(transfert\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Purchase Details"~"FLT002043: Détails d''achat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"LineNumber"~"FLT032091: numéro de ligne"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SecurityCode"~"FLT031522: Code  de sécurité "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SecurityName"~"FLT031524: Nom de sécurité "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"AskingPrice"~"FLT031526: Prix demandé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Deposit"~"FLT029546: Dépôt"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"NoOfShares"~"FLT031562: No  d’Actions \(partage, cotisation\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OrderAmount"~"FLT031863: Montant Commandé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CommPercentage"~"FLT031739: Pourcentage commun "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CommAmount"~"FLT032155: Montant Commun "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Stamp"~"FLT031571: Timbre"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"TotalAmount"~"FLT031865: Montant total "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Residue"~"FLT031577: \(Reste, actif, net, résidu\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"OrderDate"~"FLT031767: date de la commande "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"del"~"FLT032012: Effacer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Total Amt"~"FLT031766: Total des taxes"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Details"~"FLT0265262: Détails du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CDSC Details"~"FLT0265263: CDSC Détails"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Details"~"FLT032045: Détails du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CDSC Details"~"FLT031846: CDSC Détails"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Share Purchase Results"~"FLT014548: Résultats d’actions d''achat "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ok"~"FLT031295: Ok"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Print Order Details"~"FLT031296: Imprimer les détails de la commande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Share Sell Trading"~"FLT031700: Partage de la vente"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol Id"~"FLT031589: ID de Sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"ID No./Cdsc No."~"FLT031590: numéro d''identification / numéro d''identification numérique"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Client Name"~"FLT031587: Nom du client"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Order Id."~"FLT031596: ID de la commande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Order Date"~"FLT025922: Date de la commande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"FLT031317: --Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A-Add"~"FLT031309: A-Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M-Modify"~"FLT031318: M-Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I-Inquire"~"FLT031323: I-demande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-Verify"~"FLT031340: V-Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"C-Cancel"~"FLT031341: Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cdsno."~"FLT031699: Numéro Cds ."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Client Names"~"FLT031585: Noms des clients"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Order Number"~"FLT031580: Numéro de commande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Branch"~"FLT007251: Branche"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Created By"~"FLT000625: Créé par"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Order Type"~"FLT019099: Type de commande"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Effective Bal"~"FLT031595: Bal efficace"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"DATE "~"FLT026334: DATE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"SOL SET"~"FLT026333: SOL SET \(Etablissement ou installation du solde\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"P-Print"~"FLT026342: P-\(imprimer\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Manual TOD Availment"~"FLT031590: Disponibilité manuelle de TOD"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"FLT112254: Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Id"~"FLT112259: Identifiant du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Availment Request ID"~"FLT031592: ID de demande de disponibilité"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--Select--"~"FLT700022: --Sélectionner--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A - Add"~"FLT031595: A - Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M - Modify"~"FLT031596: M - Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V - Verify"~"FLT031297: V - Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X - Cancel"~"FLT033219: X - Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contract Id"~"FLT031597: ID du contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Name"~"FLT031606: Nom du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Currency"~"FLT031700: Devise \(monnaie\)  du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contract Amount"~"FLT031701: Montant du contrat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Contract Period\(in months\)"~"FLT031702: Période du contrat \(en mois\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"TOD availment amount"~"FLT031715: TOD   montant disponible "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Availment  Period\(in days\)"~"FLT031732: Période disponible  \(en jours\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Amount"~"FLT031699: Montant facturé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Net TOD amount"~"FLT031733: TOD  montant Net "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Remarks"~"FLT112261: Remarques"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Expiry Date"~"FLT112262: Date d''expiration"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Available Availment Amount"~"FLT112263: Montant  disponible"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cancel"~"FLT027575: Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ok"~"FLT700008: Ok"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Temporary Role ID Maintenance"~"FLT031860: ID  de  rôle temporaire de maintenance temporaire "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"User ID"~"FLT019770: ID  de l’utilisateur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"User ID"~"FLT112251: ID de l’utilisateur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Current Role ID"~"FLT031861: ID   de rôle actuel"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Temporary Role ID"~"FLT031862: ID  de  rôle temporaire"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Expiry Date"~"FLT013480: Date d''expiration"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Validate"~"FLT021284: Valider"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Role Profile Maintenance"~"FLT014548: Maintenance du profil de rôle"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"FLT000003: Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M - Modify"~"FLT000009: M - Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I - Inquire"~"FLT000010: I -  information "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Inst Type"~"FLT000011: Type d''installation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Inst Number"~"FLT000012: numéro d''installation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Current/Old Status"~"FLT026334: état actuel / ancien"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"New Status "~"FLT026336: Nouveau état "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No. Of Leaves "~"FLT026337: Nombres Des feuilles \(pages\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Begin Chq No "~"FLT026338: Numéro de cheque de début"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Inst Type "~"FLT026339: Type d''installation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Inst Type"~"FLT026340: Type d''installation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Role Id"~"FLT026341:  Rôle de ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X - Cancel "~"FLT000007: X - Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V - Verify "~"FLT000008: V - Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A-Add "~"FLT026334: A-Ajouter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"B-Biller "~"FLT026336: B-Biller"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"D-Delete "~"FLT026335: D-Supprimer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M-Modify "~"FLT026337: M-Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Function"~"FLT022001: Fonction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"FLT022002: Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"REG. No."~"FLT022003: REG. No."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Name"~"FLT022004: Nom"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"From Date"~"FLT026333: Date de début"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Date"~"FLT026334: À ce jour"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"--SELECT--"~"FLT026335: --SELECTIONNER--"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol_id/Bank_ID"~"FLT026333: Solid / Bank_ID  \( volume/  ID de la Banque\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 1"~"FLT000145: Aucun Texte  1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c. ID"~"FLT000265: A / c. ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bank ID"~"FLT018812: ID de la banque"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Event ID"~"FLT000729: ID d''événement de la facturation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Validation Type"~"FLT009674: Type de validation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free Text 5"~"FLT000149: Aucun Texte  5"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller Code"~"FLT000150: Code Biller"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cash Exchange Transaction"~"FLT028900: Transaction d’échange en espèces"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"From Currency"~"FLT030311: De telle  monnaie"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Currency"~"FLT030541: A   telle   Monnaie"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amount Received"~"FLT030647: Montant reçu"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amount in From Currency"~"FLT030726: montant en devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amount in To Currency"~"FLT030897: montant en devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rate Code / Rate"~"FLT031293: Code tarif / tarif"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Event Id"~"FLT031294: Identifiant de l''événement de facturation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Amount"~"FHP000241: Montant facturé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Treasury Ref.Number"~"FLT031295: Numéro de référence du Trésor \( de la trésorerie\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency"~"FTT000072: Devise \(monnaie\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"System Calculated Amount"~"FLT031297: Montant calculé par le système"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"User Enterd Amount"~"FLT031309: Montant saisi par l''utilisateur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Particular"~"FLT031310: Charge particulière"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cash Exchange Transaction"~"FLT031296: Transaction d’échange en espèces"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CASH EXCHANGE SCREEN FOR SAME CURRENCY"~"FLT031830: TRAME \(TABLEAU\) D''ÉCHANGE DE TRÉSORERIE POUR LA MÊME MONNAIE"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency"~"FLT030604: Devise \(monnaie\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Amount Received"~"FLT031738: Montant reçu"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Accept"~"FLT023614: Accepter"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency Denominations Maintenance"~"FLT031734: Maintenance des dénominations monétaires"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"U - UnDelete"~"FLT031736: U – pas à supprimer "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Decimel Point Allowed"~"FLT031735: Point décimal autorisé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Denomination"~"FLT003523: Dénomination"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set Id"~"FLT020285: Définir l''ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Teller Id"~"FLT014433: Identité \(ID\)   du revendeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency"~"FLT015533: Devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol SetId"~"FLT1024473: Sol Set Id \( identité de l’installation du solde\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Position Report"~"FLS1000009: Rapport de position"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Go"~"FLT000885: GO/Aller"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Customer Interest Report"~"FLT000572: Rapport d''intérêt client"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Type"~"FLT111600: Type"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Criteria 1"~"FLT111601: Critères 1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Criteria 2"~"FLT111602: Critère 2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Placeholder"~"FLT111603: Espace réservé du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set ID"~"FLT111604: Définir l''ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Currency"~"FLT111605: Devise"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Start Tran Date"~"FLT111606: date du début du  transfert"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"End Tran Date"~"FLT111607: Date de fin du transfert"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"GL Account No."~"FLT111608: Numéro de compte GL"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran ID"~"FLT111609: ID Transfert "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Date"~"FLT111610: Date de transfert"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"To Set ID"~"FLT111611: Pour définir l''ID"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Clear"~"FLT000192: Effacer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ok"~"FLT000556: Ok"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/C Id."~"FLT11000030: A / C Id."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Reshedule Date"~"FLT11000031: Date de reprogrammation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Calc Int upto Reshdl Date"~"FLT11000032: Calcule de l’Intérêt  jusqu''à la date Reprogrammation "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Account Number"~"FLT11000033: Numéro de compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Loan OutStanding"~"FLT11000034: Perte échue"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No. of Instalments"~"FLT11000035: Nombre de versements"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Int. Rate"~"FLT11000036: Taux"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instalment Amount"~"FLT11000037: Montant de l''acompte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Prepayment Amount"~"FLT11000038: Montant du paiement anticipé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Prepayment Amount"~"FLT11000039: Montant du paiement anticipé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"EI Payment Frequency"~"FLT11000040: Fréquence de paiement de l''assurance-emploi"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Compounding Frequency"~"FLT11000041: Fréquence de composition"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"EI Formula Flg"~"FLT11000042: Formule EI Flg"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Capitalise Int. ?"~"FLT11000043: Intérêt de Capitalisation . ?"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Carry Overdue demands?"~"FLT11000044: demande de report échu?"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Int. Base Method"~"FLT11000045: Méthode de base d’intérêt "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No. of Days in a Year"~"FLT11000046: Nombre de jours dans une année"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Leap Year Adjustment"~"FLT11000047: Ajustement de l''année bissextile"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Outward Clearing"~"FLT013122: Compensation vers l''extérieur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. A/C Number"~"FLT031831: Cr. Numéro  dec ompte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Code"~"FLT007523: Code de zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone Date"~"FLT000637: Date de la zone"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Zone CCY Code"~"FLT009829: Code Zone CCY"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Single/Multiple Instruments"~"FLT031832: Instruments  \( mécanisme\)  simples / multiples"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No. of cheque"~"FLT031833: Numéro de chèques"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Total credit amt"~"FLT031834: Montant Total du crédit "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Set No."~"FLT000611: Etablir un numéro."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Batch Num"~"FLT031835: Numéro du série "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Id"~"FLT031836: ID du Transfert \(transaction\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"L - Lodge"~"FLT031837: L – Consigner/Déposer "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"R - Release"~"FLT031838: R - Libération"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"P - Representment"~"FLT031839: P - Représentation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Outward Clearing Detail page"~"FLT031840: page de détail vers l''extérieur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Outbound call"~"FLT031841: Appel sortant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/c. Details"~"FLT003971: A / c. Détails"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. Amount"~"FLT031847: Cr. Montant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/C Free Text-1"~"FLT031848: A / C   Aucun Texte 1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"A/C Free Text-2"~"FLT031849: A / C  Aucun  Texte 2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Details"~"FLT000916: Détails de l''instrument  \(mécanisme\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Amount"~"FLT031850: Montant de l''instrument "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument No."~"FLT021766: Numéro  d''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Image"~"FLT031858: Image"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Date"~"FLT007745: Date de l''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Paying Account No."~"FLT031851: Numéro de compte payant"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bank Code"~"FLT007794: Code de la  banque"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transaction Code"~"FLT031027: Code de la transaction"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Paying A/c. Name"~"FLT031857: Payant A / c. prénom"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Branch Code"~"FLT009907: Code de succursale"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Syndication Commitment Fee Notice"~"FLT021036: Avis de frais d''engagement de syndicat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. A/C No."~"FLT031846: Cr. A / C No."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Outward Clearing Result page"~"FLT031853: page de résultats de clarification vers l''extérieur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Teller Denomination Alteration"~"FLT027769: Modification de dénomination de guichet"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol Id"~"FHP000439: Identifiant Sol"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"M-Modify"~"M-Modifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"V-Verify"~"V-Vérifier"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I-Inquiry"~"FLT027768: I-Enquêter/S’informer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"X-Cancel"~" X-Annuler"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Func Code :"~" Code de Fonction :"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Crncy Code :"~"Code de la devise \( monnaie\):"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Teller Id :"~"ID de caissier:"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sol Id :"~"Id Sol:"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cash Account Balance :"~" Solde du compte de caisse:"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Id/Amount :"~"ID du  Transfert  / montant:"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Denom Ind"~"Identification de la Dénomination "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Denom Value"~"Valeur de Dénomination "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Denom Count\(Original\)"~"Calcul /Compte de dénomination \(Original\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Denom Amount"~"Montant de dénomination "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Total Cash :"~"Total des espèces:"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rate Code and Rate"~"Code tarifaire et tarif"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Del."~"Supprimer "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Adjust Margin Event"~"Ajuster l''événement en  marge"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Event"~" Événement"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Operative A/c. ID"~"Identifiant de compte opérationnel"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Summary"~"Résumé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Clear"~" Effacer"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Treasury Rate"~"Taux de trésorerie"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Collect"~"Collecter/collecte "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cash Margin"~" Marge de la  trésorerie"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Adjust Margin"~"Ajuster la marge"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Total Margin"~"Marge totale"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Lien Margin"~"Marge de privilège"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Min. Margin Amt."~"Montant de marge minimum ."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Collect/Release"~"Collecte / Libération"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Min. Margin Pcnt."~" Marge Minimum  Pcnt."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transfer"~"FLT021311: Transfert"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Sale"~"Soldes"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Transfer A/c. ID"~"Identifiant du compte de  Transfert "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"L - Lien"~"FLT014666: L – Privilège "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Margin A/c. ID"~"Identifiant du compte de marge "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"No"~"Non"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CD Denomination"~": Dénomination du CD"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Release Amt."~"Montant libéré ."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"CCY"~"CCY"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Yes"~"Oui"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Del."~" Del."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Treasury Ref. No."~"Numéro de référence de la Trésorerie"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Release"~" Libération/sortie "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"C - Cash"~" C - Espèces"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Margin Amt."~"Montant de la  Marge."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Margin Action"~" Action de la  marge"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Go"~" \(Aller\)"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Remarks"~"Remarques"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Purchase"~" Achat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Utility Bill Payment"~" Jusqu’au billet \(facture\) du payement "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Mode of Payment"~"Mode de paiement"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Cr. A/C Number"~"Numéro du compte"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bill Payment Ref. Num"~"Référence du numéro de facture de paiement "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Payer A/c. ID"~"Identifiant du compte du payeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Type of Service"~" Type de service"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Select"~"Sélectionnez"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"C-Cash"~" C-Cash \(monnaie, espèce\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"T-Transfer"~"T-Transfert"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"R-Reversal"~" R-Revirement/ Retournement "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Get Signature"~" Obtenir la signature"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Payer A/c ID"~"Identifiant du compte du payeur"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Charge Event ID"~"ID d''événement de la  facturation"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller A/c ID"~"Identifiant du compte de l''emeteur de factures "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Bill Payment Ref Num"~"Numéro de référence du paiement de facture"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Type of service"~"Type de service"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Payment Details"~"Détails du paiement"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Risk Note"~"Note de risque"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ref. CCY/Bill Amount"~" Réf. CCY / Montant du projet de loi"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Ref. Num"~"Numéro de référence "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Rate Code/Rate"~" Code / tarif"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Name."~" Nom."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Total Amount"~" Montant total"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Type"~"Type d''instrument"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Instrument Alpha/Srl. No."~"Instrument Alpha / Srl. Non."~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Particulars"~" Transfert \(transaction\) Particulier "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Tran Remarks"~" Remarques du Transfert \(transaction\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Biller Details"~"Détails de Biller"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Applicant Category"~"Catégorie de candidat"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free text 1"~"Aucun Texte  1"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free text 2"~"Texte  2"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free text 3"~"Aucun Texte 3"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free text 4"~"Aucun Texte 4"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free text 5"~"  Aucun  Texte 5"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free text 6"~"Aucun   Texte  6"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Free text 7"~"Aucun  Texte  7"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Retail"~" Détail"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Qualified Institutional Investor"~"FLT031828: Investisseur institutionnel qualifié"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Authorised Dealer"~"Concessionnaire autorisé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Employee"~"Employé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"I - In"~" I – dedans \( interne, intérieur\) "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"O - Out"~"O- dehors   \(externe, extérieur\)  "~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Employee"~" Employé"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"Maximum Amount Limit"~"Limite de la  quantité maximale"~g' $file > FRENCH/$file
cp FRENCH/$file $file
sed 's~"User ID"~" ID de l’utilisateur"~g' $file > FRENCH/$file 
cp FRENCH/$file $file

echo $file >> filename.txt
 
done