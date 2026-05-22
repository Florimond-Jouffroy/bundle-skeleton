<?php

declare(strict_types=1);

namespace {{NAMESPACE}};

use Symfony\Component\Config\Definition\Configurator\DefinitionConfigurator;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\DependencyInjection\Loader\Configurator\ContainerConfigurator;
use Symfony\Component\HttpKernel\Bundle\AbstractBundle;

final class {{BUNDLE_CLASS}} extends AbstractBundle
{
    protected string $extensionAlias = '{{BUNDLE_SLUG}}';

    public function configure(DefinitionConfigurator $definition): void
{
    // Définition de ta configuration de bundle (ex: mon_bundle.enabled)
    $definition->rootNode()
        ->children()
        ->booleanNode('enabled')->defaultTrue()->end()
        ->end()
    ;
}

    public function loadExtension(array $config, ContainerConfigurator $container, ContainerBuilder $builder): void
{
    $builder->setParameter('{{BUNDLE_SLUG}}.enabled', $config['enabled']);

    // Importation du fichier de services en PHP
    $container->import('../config/services.php');
}
}
