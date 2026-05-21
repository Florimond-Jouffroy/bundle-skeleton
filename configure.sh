#!/bin/bash

# Couleurs pour le terminal
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}====================================================${NC}"
echo -e "${GREEN}    📦 CONFIGURATION DE TON NOUVEAU BUNDLE SYMFONY  ${NC}"
echo -e "${CYAN}====================================================${NC}"

# 1. Demander le nom du bundle en CamelCase
default_class="BlogBundle"
read -p "📝 Nom de la classe du Bundle (CamelCase, ex: CoreBundle, SecurityBundle) [$default_class] : " bundle_class
bundle_class=${bundle_class:-$default_class}

# 2. Demander le nom du paquet pour Composer (slug)
# On transforme automatiquement BlogBundle en blog-bundle pour composer
default_composer=$(echo "$bundle_class" | sed 's/\([A-Z]\)/-\1/g' | sed 's/^-//' | tr '[:upper:]' '[:lower:]')
read -p "📦 Nom du paquet Composer (slug, ex: core-bundle) [$default_composer] : " composer_name
composer_name=${composer_name:-$default_composer}

# Calcul de l'extension pour l'injection de dépendances (ex: BlogExtension)
extension_class="${bundle_class%Bundle}Extension"
# Calcul d'un nom propre pour la suite de tests (ex: Blog Bundle)
test_suite_name=$(echo "$bundle_class" | sed 's/\([A-Z]\)/ \1/g' | sed 's/^ //')

echo -e "\n${YELLOW}⏳ Initialisation des fichiers...${NC}"

# 3. Remplacement dynamique dans les fichiers
find . -type f \( -name "*.php" -o -name "*.json" -o -name "*.yaml" -o -name "*.md" -o -name "*.xml" -o -name "*.dist" \) ! -name "configure.sh" | while read -r file; do
    # Remplacement du namespace/classe principale
    sed -i "s/MonBundle/${bundle_class}/g" "$file"
    # Remplacement de la classe de dépendance
    sed -i "s/MonExtension/${extension_class}/g" "$file"
    # AJUSTÉ ICI : Remplacement du nom composer basé sur ton vrai nom de dossier
    sed -i "s/bundle-skeleton/${composer_name}/g" "$file"
    # Remplacement du nom de la suite de tests PHPUnit
    sed -i "s/Mon Bundle Test Suite/${test_suite_name} Test Suite/g" "$file"
done

# 4. Renommer les fichiers physiques pour correspondre au nouveau nom
mv src/MonBundle.php "src/${bundle_class}.php"
mv src/DependencyInjection/MonExtension.php "src/DependencyInjection/${extension_class}.php"

echo -e "${GREEN}✅ Ton bundle est configuré avec succès !${NC}"
echo -e "${CYAN}👉 Classe principale : ${bundle_class}.php${NC}"
echo -e "${CYAN}👉 Paquet Composer   : florimond-jouffroy/${composer_name}${NC}\n"

# Nettoyage : Le script s'autodétruit
rm -- "$0"