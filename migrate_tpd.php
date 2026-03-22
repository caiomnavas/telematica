<?php
require_once __DIR__ . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

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
]);
$capsule->setAsGlobal();
$capsule->bootEloquent();

try {
    Capsule::schema()->create('tpds', function ($table) {
        $table->increments('id');
        $table->string('opm');
        $table->string('num_serie')->unique();
        $table->string('patrimonio')->unique();
        $table->string('tipo_material');
        $table->text('descricao');
        $table->decimal('valor', 15, 2);
        $table->string('localizacao');
        $table->timestamps();
    });
    echo "Tabela 'tpds' criada com sucesso!";
} catch (Exception $e) {
    echo "Erro ao criar tabela 'tpds': " . $e->getMessage();
}
