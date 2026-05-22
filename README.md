 # 📦 Symfony Bundle Skeleton (Template)
 
 Ce dépôt est un **Template GitHub** servant de base de départ industrielle pour créer des bundles Symfony réutilisables, isolés et configurés selon les standards professionnels les plus récents (**PHP 8.4+** et **Symfony 7.4+**).
 
 ---
 
 ## 🚀 1. Initialisation d'un nouveau Bundle
 
 Lorsque tu crées un nouveau dépôt à partir de ce template, suis ces étapes pour le personnaliser instantanément :
 
 1. Ouvre ton terminal dans le dossier de ton nouveau bundle.
 2. Lance le script de configuration interactif :
    ```bash
    ./configure.sh
    ```
 3. Réponds aux questions posées (Nom du Vendor, Nom du Bundle).
 
 > 💡 **Magie en coulisses** : Le script va générer automatiquement ton paquet Composer, configurer l'alias unique de l'AbstractBundle, injecter les namespaces PHP avec doubles slashes pour le format JSON et renommer la classe principale avant de s'autodétruire.
 
 ---
 
 ## 🛠️ 2. Workflow de Développement Local (Le Banc d'Essai)
 
 Pour développer et tester ton bundle en temps réel sans faire de `git push` incessants, utilise la méthode du **lien local (Symlink)** avec ton application hôte (ex: `symfony-skeleton`).
 
 Place ton dossier de bundle au même niveau que tes autres projets dans ton répertoire de travail :
 ```text
 Projets/
 ├── symfony-skeleton/      # Ton application Symfony hôte (Docker)
 └── mon-nouveau-bundle/    # Ton dossier de bundle en cours de dev
 ```
 
 ### Étape A : Déclarer le chemin local dans l'application hôte
 Ouvre le fichier `composer.json` de ton **application Symfony principale** (`symfony-skeleton`) et ajoute ton bundle dans la section `repositories` :
 
 ```json
 "repositories": [
     {
         "type": "path",
         "url": "../mon-nouveau-bundle",
         "options": {
             "symlink": true
         }
     }
 ],
 ```
 
 ### Étape B : Installer le bundle via Docker
 Depuis le terminal de ton **application Symfony principale**, demande à Composer d'injecter ton bundle. Il va détecter le chemin configuré et créer un lien symbolique direct :
 
 ```bash
 docker compose exec php composer require ube/mon-nouveau-bundle:@dev
 ```
 
 ---
 
 ## 🗂️ 3. Structure du Projet
 
 ```text
 ├── assets/                  # Assets front (CSS, JS, images sources)
 ├── config/
 │   └── services.php         # Déclaration moderne et typée des services en PHP
 ├── public/                  # Assets publics finaux exposés
 ├── src/
 │   ├── Entity/              # Dossier pour tes entités Doctrine (ex: ApplicationLog)
 │   ├── Service/             # Dossier pour tes services logiques (ex: HelloService)
 │   └── [Nom]Bundle.php      # Point d'entrée unique héritant d'AbstractBundle
 ├── templates/               # Vues Twig spécifiques au bundle
 ├── translations/            # Fichiers d'internationalisation (.yaml)
 ├── tests/
 │   └── phpunit.xml.dist     # Configuration pour tes tests automatisés isolés
 ├── composer.json            # Configuration Composer du paquet (Auteur : Florimond Jouffroy)
 └── README.md
 ```
 
 * **`[Nom]Bundle.php`** : La carte d'identité moderne de ton extension. Elle hérite d'`AbstractBundle` (Symfony 6.1+), fusionnant la déclaration du bundle, la racine de configuration YAML et l'injection de dépendances en un fichier unique.
 * **`config/services.php`** : Fichier de configuration typé et compilé plus rapidement par Symfony. Il utilise l'autowiring automatique sur l'ensemble de ton dossier `src/Service/`.
 
 ---
 
 ## 🔄 4. Déploiement et Publication
 
 Une fois ton code finalisé, validé et testé au travers de ton application cobaye :
 
 1. Publie ton bundle sur son propre dépôt Git public ou privé.
 2. Déclare-le sur [Packagist](https://packagist.org/) (ou sur ton GitLab/GitHub Package Registry privé d'entreprise).
 3. Dans tes futurs projets, tu n'auras plus besoin de la configuration `path` locale, tu pourras l'installer sur n'importe quelle application d'une seule ligne :
    ```bash
    composer require ube/mon-nouveau-bundle
    ```