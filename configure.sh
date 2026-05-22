#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}====================================================${NC}"
echo -e "${GREEN}    🚀 INIT BUNDLE WORKFLOW (ENTERPRISE STYLE)      ${NC}"
echo -e "${CYAN}====================================================${NC}"

# 1. Collecte des informations
default_vendor="Ube"
read -p "🏢 Nom du Vendor (ex: Ube, Florimond) [$default_vendor] : " vendor_name
vendor_name=${vendor_name:-$default_vendor}

default_bundle="Awesome"
read -p "📦 Nom du Bundle (ex: Awesome, Log, Auth) [$default_bundle] : " bundle_name
bundle_name=${bundle_name:-$default_bundle}

# Formatage des variables de remplacement
bundle_class="${bundle_name}Bundle"
namespace="${vendor_name}\\${bundle_class}"
namespace_escaped="${vendor_name}\\\\${bundle_class}"

# Génération automatique du slug pour composer et alias (ex: ube_awesome ou ube/awesome-bundle)
vendor_slug=$(echo "$vendor_name" | tr '[:upper:]' '[:lower:]')
bundle_slug_raw=$(echo "$bundle_name" | sed 's/\([A-Z]\)/_\1/g' | sed 's/^_//' | tr '[:upper:]' '[:lower:]')
bundle_slug="${vendor_slug}_${bundle_slug_raw}"

package_name="${vendor_slug}/$(echo "$bundle_name" | sed 's/\([A-Z]\)/-\1/g' | sed 's/^-//' | tr '[:upper:]' '[:lower:]')-bundle"

echo -e "\n${YELLOW}⏳ Remplacement des patterns dans les fichiers...${NC}"

# 2. Remplacement textuel de tous les jetons d'entreprise
find . -type f \( -name "*.php" -o -name "*.json" -o -name "*.yaml" -o -name "*.md" -o -name "*.xml" -o -name "*.dist" \) ! -name "configure.sh" | while read -r file; do
    sed -i "s/{{PACKAGE_NAME}}/${package_name}/g" "$file"
    sed -i "s/{{VENDOR}}/${vendor_name}/g" "$file"
    sed -i "s/{{BUNDLE}}/${bundle_name}/g" "$file"
    sed -i "s/{{BUNDLE_CLASS}}/${bundle_class}/g" "$file"
    sed -i "s/{{BUNDLE_SLUG}}/${bundle_slug}/g" "$file"
    sed -i "s/{{NAMESPACE}}/${namespace}/g" "$file"
    sed -i "s/{{NAMESPACE_ESCAPED}}/${namespace_escaped}/g" "$file"
done

# 3. Renommer le fichier physique de la classe de bundle principale
mv "src/{{BUNDLE_CLASS}}.php" "src/${bundle_class}.php"

echo -e "${GREEN}✅ Configuration effectuée !${NC}"
echo -e "${CYAN}👉 Paquet : ${package_name}${NC}"
echo -e "${CYAN}👉 Alias  : ${bundle_slug}${NC}\n"

# Autodestruction sécurisée
rm -- "$0"