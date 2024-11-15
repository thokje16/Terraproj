# Terraform-prosjekt for webserver og MySQL-database på Azure

Dette prosjektet bruker Terraform for å sette opp en webserver og en MySQL (MariaDB)-database på Azure. Webserveren kjører Apache med et Python CGI-skript som kobler seg til MySQL-databasen.

## Prosjektstruktur

- **`main.tf`**: Hovedkonfigurasjonsfil for Terraform.
- **`playbook.yml`**: Ansible-playbook for konfigurasjon av webserveren.
- **`install_mariadb.sh`**: Skript for installasjon og konfigurasjon av MariaDB på databaseserveren.
- **`scripts/`**: Katalog med skripter brukt i distribusjonen.
- **`variables.tf`**: Definisjon av variabler for Terraform.

## Infrastrukturkomponenter

- **Azure Virtual Machines**:
  - **Webserver-VM**: Kjører Apache og Python CGI-skriptet.
  - **Databaseserver-VM-er**: Kjører MariaDB og er konfigurert i en backend-pool.
- **Azure Load Balancer**:
  - Distribuerer trafikk til databaseserverne på port `3306`.
- **Azure Storage Account**:
  - Lagrer skripter og playbooks for VM-provisjonering.
- **Nettverk**:
  - **Virtual Network og Subnets**: Separate subnets for web- og databaseservere.
  - **Network Security Groups**: Kontrollerer trafikk inn og ut.

## Oppsettinstruksjoner

### Forutsetninger

- Installert [Terraform](https://www.terraform.io/downloads.html).
- En Azure-konto med nødvendige rettigheter.
- Installert og autentisert Azure CLI (`az login`).

### Steg-for-steg

1. **Klone repositoriet**:

   ```bash
   git clone <repository-url>
   cd <repository-directory>
2. **ENDRINGER I SCRIPT**
    Endre til din egen subscription id i provider.tf
    Gjør de endringene du vil i terraform.tfvars
3. **TERRAFORM**
    az logout ; az login --scope https://management.core.windows.net//.default
    terraform init
    terraform plan -out main.tfplan
    terraform apply
    Kopier public ipen du blir foret med i terminalen.
4. **TESTING**
    Bruk ipen i nettleseren, hvis du blir sendt til index.html i starten så er det ikke ferdigkonfigurert, fikser seg selv etterhvert. 
    Eventuelt <ipaddresse>/hello.py