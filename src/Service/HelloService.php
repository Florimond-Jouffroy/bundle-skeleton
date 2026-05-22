<?php

declare(strict_types=1);

namespace {{NAMESPACE}}\Service;

class HelloService
{
    public function sayHello(string $name): string
    {
        return 'Hello ' . $name;
    }
}