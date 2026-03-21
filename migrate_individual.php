<?php
require_once __DIR__ . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

use Illuminate\Database\Capsule\Manager as Capsule;

$capsule = new Capsule;
$capsule->addConnection([
    'driver'    => 'mysql',
    'host'      => $_SERVER['DB_HOST'],
    'database'  => $_SERVER['DB_NAME'],
    'username'  => $_SERVER['DB_USER'],
    'password'  => $_SERVER['DB_PASS'],
    'charset'   => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
]);
$capsule->setAsGlobal();
$capsule->bootEloquent();

$tabelas = [
    'tpds', 
    'radios_moveis', 
    'radios_portateis', 
    'celulares', 
    'computadores', 
    'impressoras', 
    'notebooks'
];

try {
    // Criar tabelas de ativos
    foreach ($tabelas as $tabela) {
        Capsule::schema()->dropIfExists($tabela);
        Capsule::schema()->create($tabela, function ($table) {
            $table->increments('id');
            $table->string('opm');
            $table->string('num_serie')->unique();
            $table->string('patrimonio')->unique();
            $table->string('tipo_material');
            $table->text('descricao');
            $table->decimal('valor', 15, 2);
            $table->string('localizacao');
            $table->enum('status', ['Operando', 'Baixado', 'Descarregado'])->default('Operando');
            $table->timestamps();
        });
        echo "Tabela '$tabela' criada.<br>";
    }

    // Criar tabela de observações polimórfica
    Capsule::schema()->dropIfExists('observacoes');
    Capsule::schema()->create('observacoes', function ($table) {
        $table->increments('id');
        $table->integer('observavel_id')->unsigned(); // ID do ativo
        $table->string('observavel_type');           // Nome do Model (ex: App\Models\Tpd)
        $table->integer('usuario_id')->unsigned();
        $table->text('observacao');
        $table->timestamps();
    });
    echo "Tabela 'observacoes' criada.<br>";

    echo "<br><b>Migração Individualizada concluída com sucesso!</b>";
} catch (Exception $e) {
    echo "Erro na migração: " . $e->getMessage();
}
