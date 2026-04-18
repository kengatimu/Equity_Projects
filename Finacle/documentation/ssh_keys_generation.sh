1. Generate Keys FROM AZURE AGENT
	ssh-keygen -t ed25519 -C "azure-uat" -f fincicd_azure_itops_uat -N ""
	ssh-keygen -t ed25519 -C "azure-prod" -f fincicd_azure_itops_prod -N ""

2. Extract Keys from Agent
	cat fincicd_azure_itops_uat.pub
	cat fincicd_azure_itops_prod.pub

3. Install PUBLIC KEYS
	su - fincicd_azure_itops
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh

	vi ~/.ssh/authorized_keys

-- On UAT servers
	Paste: <contents of fincicd_azure_itops_uat.pub>
	Then: chmod 600 ~/.ssh/authorized_keys
	
-- On PROD servers
	Paste: <contents of fincicd_azure_itops_prod.pub>
	Then: chmod 600 ~/.ssh/authorized_keys

4. Validate Access BEFORE Azure Setup
	UAT: ssh -i fincicd_azure_itops_uat fincicd_azure_itops@<uat-ip>
	PROD: ssh -i fincicd_azure_itops_prod fincicd_azure_itops@<prod-ip>