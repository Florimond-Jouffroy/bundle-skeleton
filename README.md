# 📦 Symfony Bundle Skeleton (Template)

Ce dépôt est un **Template GitHub** servant de base de départ industrielle pour créer des bundles Symfony réutilisables, isolés et configurés selon les standards professionnels.
 
---

## 🚀 1. Initialisation d'un nouveau Bundle

Lorsque tu crées un nouveau dépôt à partir de ce template, suis ces étapes pour le personnaliser instantanément :

1. Ouvre ton terminal dans le dossier de ton nouveau bundle.
2. Lance le script de configuration interactif :
    ```bash
    ./configure.sh
    ```
 3. Réponds aux questions posées (Nom de la classe en CamelCase et nom du paquet Composer).
 
 > 💡 **Magie en coulisses** : Le script va renommer automatiquement les fichiers physiques, ajuster les namespaces PHP internes, configurer le `composer.json` et s'autodétruire pour laisser le projet impeccable.
 
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
 docker compose exec php composer require florimond-jouffroy/mon-nouveau-bundle:@dev
 ```
 
 ---
 
 ## 🗂️ 3. Structure du Projet
 
 ```text
 ├── config/
 │   └── services.yaml          # Déclaration des services de ton bundle
 ├── src/
 │   ├── DependencyInjection/
 │   │   └── MonExtension.php   # Injecte automatiquement les services dans Symfony
 │   └── [Nom]Bundle.php        # Point d'entrée principal (Carte d'identité du bundle)
 ├── composer.json              # Configuration Composer du paquet
 └── README.md
 ```
 
 * **`[Nom]Bundle.php`** : C'est la prise de branchement de ton extension. Symfony l'exécute au démarrage pour enregistrer ton code dans le Kernel.
 * **`services.yaml`** : C'est ici que tu déclareras tes classes de services, tes managers ou tes extensions Twig pour qu'ils profitent de l'autowire de Symfony.
 
 ---
 
 ## 🔄 4. Déploiement et Publication
 
 Une fois ton code finalisé, validé et testé au travers de ton application cobaye :
 
 1. Publie ton bundle sur son propre dépôt GitHub public ou privé.
 2. Déclare-le sur [Packagist](https://packagist.org/) pour le rendre accessible mondialement.
 3. Dans tes futurs projets, tu n'auras plus besoin de la configuration `path` locale, tu pourras l'installer sur n'importe quelle application d'une seule ligne :
    ```bash
    composer require florimond-jouffroy/mon-nouveau-bundle
    ```