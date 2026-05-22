<?php


declare(strict_types=1);

use Symfony\Component\DependencyInjection\Loader\Configurator\ContainerConfigurator;

return static function (ContainerConfigurator $container): void {
    $services = $container->services();

    $services
        ->defaults()
        ->autowire()
        ->autoconfigure();

    // Chargement automatique de tes services avec le bon Namespace dynamique
    $services
        ->load('{{NAMESPACE_ESCAPED}}\\Service\\', dirname(__DIR__) . '/src/Service/');
};