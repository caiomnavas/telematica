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
    // 1. Criar Tabela de Ativos (Generalista)
    Capsule::schema()->dropIfExists('ativos');
    Capsule::schema()->create('ativos', function ($table) {
        $table->increments('id');
        $table->string('tipo_dispositivo'); // TPD, Radio Movel, Radio Portatil, Celular, Computador, Impressora, Notebook
        $table->string('opm');
        $table->string('num_serie')->unique();
        $table->string('patrimonio')->unique();
        $table->string('tipo_material'); // Ex: Terminal, Rádio, etc.
        $table->text('descricao');
        $table->decimal('valor', 15, 2);
        $table->string('localizacao');
        $table->enum('status', ['Operando', 'Baixado', 'Descarregado'])->default('Operando');
        $table->timestamps();
    });

    // 2. Criar Tabela de Observações
    Capsule::schema()->dropIfExists('ativo_observacoes');
    Capsule::schema()->create('ativo_observacoes', function ($table) {
        $table->increments('id');
        $table->integer('ativo_id')->unsigned();
        $table->integer('usuario_id')->unsigned();
        $table->text('observacao');
        $table->timestamps();

        // Foreign keys (opcional, dependendo do motor MySQL, mas bom para integridade)
        // $table->foreign('ativo_id')->references('id')->on('ativos')->onDelete('cascade');
    });

    echo "Tabelas 'ativos' e 'ativo_observacoes' criadas com sucesso!";
} catch (Exception $e) {
    echo "Erro na migração: " . $e->getMessage();
}
