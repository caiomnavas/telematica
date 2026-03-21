<?php

// Configurações Globais (Algumas ainda podem ser constantes, ou lidas do $_ENV)
define('BASE_URL', $_ENV['BASE_URL'] ?? 'http://localhost/telematica/');
define('APP_ENV', $_ENV['APP_ENV'] ?? 'production');
