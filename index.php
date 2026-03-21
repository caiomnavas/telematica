<?php

// Iniciar sessão
session_start();

// Habilitar a exibição de erros durante o desenvolvimento
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Requerer o autoload do Composer e as configurações do projeto
require_once __DIR__ . '/vendor/autoload.php';

// Carregar variáveis de ambiente do arquivo .env
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Inicializar o Eloquent ORM
use Illuminate\Database\Capsule\Manager as Capsule;

$capsule = new Capsule;
$capsule->addConnection([
    'driver'    => 'mysql',
    'host'      => $_ENV['DB_HOST'],
    'database'  => $_ENV['DB_NAME'],
    'username'  => $_ENV['DB_USER'],
    'password'  => $_ENV['DB_PASS'],
    'charset'   => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'prefix'    => '',
]);

// Tornar a instância do Capsule disponível globalmente via métodos estáticos
$capsule->setAsGlobal();
// Inicializar o Eloquent
$capsule->bootEloquent();

require_once __DIR__ . '/config/config.php';

use App\Controllers\HomeController;

// Roteamento Simples (Sem URL Amigável)
$controllerName = isset($_GET['c']) ? ucfirst($_GET['c']) . 'Controller' : 'HomeController';
$actionName     = isset($_GET['a']) ? $_GET['a'] : 'index';

// Namespace completo do controlador
$controllerClass = "App\\Controllers\\$controllerName";

// Verificar se o controlador existe
if (class_exists($controllerClass)) {
    $controller = new $controllerClass();

    // Verificar se o método existe no controlador
    if (method_exists($controller, $actionName)) {
        // Chamar a ação
        $controller->$actionName();
    } else {
        header("HTTP/1.0 404 Not Found");
        echo "404 - Ação '{$actionName}' não encontrada no controlador '{$controllerName}'.";
    }
} else {
    header("HTTP/1.0 404 Not Found");
    echo "404 - Controlador '{$controllerName}' não encontrado.";
}
