<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Ativo;
use App\Models\AtivoObservacao;

class AtivoController extends Controller {
    
    private $tipos_validos = [
        'tpd' => 'TPDs',
        'radio-movel' => 'Rádios Móveis',
        'radio-portatil' => 'Rádios Portáteis',
        'celular' => 'Celulares Funcionais',
        'computador' => 'Computadores',
        'impressora' => 'Impressoras',
        'notebook' => 'Notebooks'
    ];

    public function __construct() {
        parent::__construct();
        $this->middlewareAuth();
    }

    private function getTipo() {
        $tipo = $_GET['t'] ?? 'tpd';
        if (!array_key_exists($tipo, $this->tipos_validos)) {
            $this->redirect('index.php?c=dashboard');
        }
        return $tipo;
    }

    public function index() {
        $tipo = $this->getTipo();
        $ativos = Ativo::where('tipo_dispositivo', $tipo)->get();
        
        $this->view('dashboard/ativos/index', [
            'titulo' => 'Gerenciar ' . $this->tipos_validos[$tipo],
            'ativos' => $ativos,
            'tipo_slug' => $tipo
        ]);
    }

    public function novo() {
        $tipo = $this->getTipo();
        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $valorStr = str_replace(['R$', '.', ','], ['', '', '.'], $_POST['valor']);
                $valor = (float) trim($valorStr);

                Ativo::create([
                    'tipo_dispositivo' => $tipo,
                    'opm'              => $_POST['opm'],
                    'num_serie'        => $_POST['num_serie'],
                    'patrimonio'       => $_POST['patrimonio'],
                    'tipo_material'    => $_POST['tipo_material'],
                    'descricao'        => $_POST['descricao'],
                    'valor'            => $valor,
                    'localizacao'      => $_POST['localizacao'],
                    'status'           => $_POST['status']
                ]);
                $this->redirect("index.php?c=ativo&t=$tipo&msg=created");
            } catch (\Exception $e) {
                $error = "Erro ao cadastrar: " . $e->getMessage();
            }
        }

        $this->view('dashboard/ativos/form', [
            'titulo' => 'Novo ' . substr($this->tipos_validos[$tipo], 0, -1), // Remove o plural simples para o título
            'tipo_slug' => $tipo,
            'error'  => $error
        ]);
    }

    public function editar() {
        $tipo = $this->getTipo();
        $id = $_GET['id'] ?? null;
        $ativo = Ativo::with('observacoes.usuario')->find($id);

        if (!$ativo) $this->redirect("index.php?c=ativo&t=$tipo");

        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $valorStr = str_replace(['R$', '.', ','], ['', '', '.'], $_POST['valor']);
                $valor = (float) trim($valorStr);

                $ativo->update([
                    'opm'           => $_POST['opm'],
                    'num_serie'     => $_POST['num_serie'],
                    'patrimonio'    => $_POST['patrimonio'],
                    'tipo_material' => $_POST['tipo_material'],
                    'descricao'     => $_POST['descricao'],
                    'valor'         => $valor,
                    'localizacao'   => $_POST['localizacao'],
                    'status'        => $_POST['status']
                ]);
                
                // Se houver uma nova observação
                if (!empty($_POST['nova_observacao'])) {
                    AtivoObservacao::create([
                        'ativo_id'   => $ativo->id,
                        'usuario_id' => $_SESSION['user']['id'],
                        'observacao' => $_POST['nova_observacao']
                    ]);
                }

                $this->redirect("index.php?c=ativo&t=$tipo&msg=updated");
            } catch (\Exception $e) {
                $error = "Erro ao atualizar: " . $e->getMessage();
            }
        }

        $this->view('dashboard/ativos/form', [
            'titulo' => 'Editar ' . substr($this->tipos_validos[$tipo], 0, -1),
            'ativo'  => $ativo,
            'tipo_slug' => $tipo,
            'error'  => $error
        ]);
    }

    public function excluir() {
        $tipo = $this->getTipo();
        $id = $_GET['id'] ?? null;
        $ativo = Ativo::find($id);

        if ($ativo) {
            $ativo->delete();
        }

        $this->redirect("index.php?c=ativo&t=$tipo&msg=deleted");
    }
}
