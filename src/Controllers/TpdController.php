<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Tpd;

class TpdController extends Controller {
    public function __construct() {
        parent::__construct();
        $this->middlewareAuth();
    }

    public function index() {
        $tpds = Tpd::all();
        $this->view('dashboard/tpds/index', [
            'titulo' => 'Controle de TPDs',
            'tpds' => $tpds
        ]);
    }

    public function novo() {
        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                // Limpar o valor da moeda (remover R$, pontos e trocar vírgula por ponto)
                $valorStr = str_replace(['R$', '.', ','], ['', '', '.'], $_POST['valor']);
                $valor = (float) trim($valorStr);

                Tpd::create([
                    'opm'           => $_POST['opm'],
                    'num_serie'     => $_POST['num_serie'],
                    'patrimonio'    => $_POST['patrimonio'],
                    'tipo_material' => $_POST['tipo_material'],
                    'descricao'     => $_POST['descricao'],
                    'valor'         => $valor,
                    'localizacao'   => $_POST['localizacao']
                ]);
                $this->redirect('index.php?c=tpd&msg=created');
            } catch (\Exception $e) {
                $error = "Erro ao cadastrar: " . $e->getMessage();
            }
        }

        $this->view('dashboard/tpds/form', [
            'titulo' => 'Cadastrar TPD',
            'error'  => $error
        ]);
    }

    public function editar() {
        $id = $_GET['id'] ?? null;
        $tpd = Tpd::find($id);

        if (!$tpd) $this->redirect('index.php?c=tpd');

        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            try {
                $valorStr = str_replace(['R$', '.', ','], ['', '', '.'], $_POST['valor']);
                $valor = (float) trim($valorStr);

                $tpd->update([
                    'opm'           => $_POST['opm'],
                    'num_serie'     => $_POST['num_serie'],
                    'patrimonio'    => $_POST['patrimonio'],
                    'tipo_material' => $_POST['tipo_material'],
                    'descricao'     => $_POST['descricao'],
                    'valor'         => $valor,
                    'localizacao'   => $_POST['localizacao']
                ]);
                $this->redirect('index.php?c=tpd&msg=updated');
            } catch (\Exception $e) {
                $error = "Erro ao atualizar: " . $e->getMessage();
            }
        }

        $this->view('dashboard/tpds/form', [
            'titulo' => 'Editar TPD',
            'tpd'    => $tpd,
            'error'  => $error
        ]);
    }

    public function excluir() {
        $id = $_GET['id'] ?? null;
        $tpd = Tpd::find($id);

        if ($tpd) {
            $tpd->delete();
        }

        $this->redirect('index.php?c=tpd&msg=deleted');
    }
}
