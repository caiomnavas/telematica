<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Observacao;

abstract class PatrimonioController extends Controller {
    protected $model;
    protected $slug;
    protected $titulo_singular;

    public function __construct() {
        parent::__construct();
        $this->middlewareAuth();
    }

    public function index() {
        $ativos = $this->model::with('observacoes.usuario')->get();
        $this->view("dashboard/patrimonio/index", [
            'titulo'    => 'Gerenciar ' . $this->titulo_singular . 's',
            'ativos'    => $ativos,
            'controller'=> $this->slug
        ]);
    }

    public function novo() {
        $error = null;
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $valorStr = str_replace(['R$', '.', ','], ['', '', '.'], $_POST['valor']);
                $this->model::create([
                    'opm'           => $_POST['opm'],
                    'num_serie'     => $_POST['num_serie'],
                    'patrimonio'    => $_POST['patrimonio'],
                    'tipo_material' => $_POST['tipo_material'],
                    'descricao'     => $_POST['descricao'],
                    'valor'         => (float) trim($valorStr),
                    'localizacao'   => $_POST['localizacao'],
                    'status'        => $_POST['status']
                ]);
                $this->redirect("index.php?c={$this->slug}&msg=created");
            } catch (\Exception $e) { $error = $e->getMessage(); }
        }
        $this->view("dashboard/patrimonio/form", ['titulo' => 'Novo ' . $this->titulo_singular, 'controller' => $this->slug, 'error' => $error]);
    }

    public function editar() {
        $id = $_GET['id'] ?? null;
        $ativo = $this->model::with('observacoes.usuario')->find($id);
        if (!$ativo) $this->redirect("index.php?c={$this->slug}");

        $error = null;
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $valorStr = str_replace(['R$', '.', ','], ['', '', '.'], $_POST['valor']);
                $ativo->update([
                    'opm'           => $_POST['opm'],
                    'num_serie'     => $_POST['num_serie'],
                    'patrimonio'    => $_POST['patrimonio'],
                    'tipo_material' => $_POST['tipo_material'],
                    'descricao'     => $_POST['descricao'],
                    'valor'         => (float) trim($valorStr),
                    'localizacao'   => $_POST['localizacao'],
                    'status'        => $_POST['status']
                ]);

                if (!empty($_POST['nova_observacao'])) {
                    $ativo->observacoes()->create([
                        'usuario_id' => $_SESSION['user']['id'],
                        'observacao' => $_POST['nova_observacao']
                    ]);
                }
                $this->redirect("index.php?c={$this->slug}&msg=updated");
            } catch (\Exception $e) { $error = $e->getMessage(); }
        }
        $this->view("dashboard/patrimonio/form", ['titulo' => 'Editar ' . $this->titulo_singular, 'ativo' => $ativo, 'controller' => $this->slug, 'error' => $error]);
    }

    public function excluir() {
        $id = $_GET['id'] ?? null;
        $ativo = $this->model::find($id);
        if ($ativo) $ativo->delete();
        $this->redirect("index.php?c={$this->slug}&msg=deleted");
    }
}
