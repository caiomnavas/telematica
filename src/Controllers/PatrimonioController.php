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

    public function reconciliar() {
        $this->view("dashboard/patrimonio/reconciliar", [
            'titulo' => 'Reconciliação de ' . $this->titulo_singular . 's',
            'controller' => $this->slug,
            'titulo_singular' => $this->titulo_singular
        ]);
    }

    public function importar() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->redirect("index.php?c={$this->slug}&a=reconciliar");
        }

        $mes = $_POST['mes'] ?? date('m');
        $ano = $_POST['ano'] ?? date('Y');
        $arquivo = $_FILES['arquivo']['tmp_name'] ?? null;

        if (!$arquivo) {
            $this->redirect("index.php?c={$this->slug}&a=reconciliar&msg=file_error");
        }

        $debug_log = [];
        try {
            $instance = new $this->model;
            $table = $instance->getTable();
            $debug_log[] = "Iniciando importação para tabela: $table";
            
            $handle = fopen($arquivo, "r");
            if (!$handle) throw new \Exception("Erro ao abrir arquivo temporário: $arquivo");

            // Detectar delimitador
            $firstLine = fgets($handle);
            rewind($handle);
            $delimiter = (strpos($firstLine, ';') !== false) ? ";" : ",";
            $debug_log[] = "Delimitador detectado: '$delimiter'";

            // Pular cabeçalho
            $header = fgetcsv($handle, 1000, $delimiter);
            if ($header) {
                $debug_log[] = "Cabeçalho: " . implode(" | ", $header);
            }

            $present_ids = [];
            $count_new = 0;
            $count_updated = 0;
            $row_idx = 0;

            while (($data = fgetcsv($handle, 1000, $delimiter)) !== FALSE) {
                $row_idx++;
                
                // Limpeza de dados (remover BOM se existir na primeira coluna)
                if ($row_idx === 1 && isset($data[0])) {
                    $data[0] = preg_replace('/^[\xEF\xBB\xBF\xFF\xFE\xFE\xFF]*/', '', $data[0]);
                }

                if (count($data) < 7) {
                    $debug_log[] = "Linha $row_idx: Ignorada (Colunas insuficientes: " . count($data) . ")";
                    continue;
                }

                $opm           = trim($data[0]);
                $num_serie     = trim($data[1]);
                $patrimonio    = trim($data[2]);
                $tipo_material = trim($data[3]);
                $descricao     = trim($data[4]);
                $valorStr      = trim($data[5]);
                $localizacao   = trim($data[6]);

                if (empty($patrimonio) && empty($num_serie)) {
                    $debug_log[] = "Linha $row_idx: Ignorada (Patrimônio e Série estão vazios)";
                    continue;
                }

                $valor = (float) str_replace(['R$', '.', ','], ['', '', '.'], $valorStr);

                try {
                    // Buscar por patrimônio ou série
                    $query = $this->model::query();
                    if (!empty($patrimonio)) {
                        $query->where('patrimonio', $patrimonio);
                        if (!empty($num_serie)) {
                            $query->orWhere('num_serie', $num_serie);
                        }
                    } else {
                        $query->where('num_serie', $num_serie);
                    }
                    
                    $ativo = $query->first();

                    if ($ativo) {
                        $ativo->update(['status' => 'Operando']);
                        $present_ids[] = $ativo->id;
                        $count_updated++;
                    } else {
                        $novo = $this->model::create([
                            'opm'           => $opm,
                            'num_serie'     => $num_serie,
                            'patrimonio'    => $patrimonio,
                            'tipo_material' => $tipo_material,
                            'descricao'     => $descricao,
                            'valor'         => $valor,
                            'localizacao'   => $localizacao,
                            'status'        => 'Operando'
                        ]);
                        if ($novo && $novo->id) {
                            $present_ids[] = $novo->id;
                            $count_new++;
                        } else {
                            $debug_log[] = "Linha $row_idx: Falha ao criar registro (Eloquente não retornou ID)";
                        }
                    }
                } catch (\Exception $e) {
                    $debug_log[] = "Linha $row_idx: Erro DB: " . $e->getMessage();
                }
            }
            fclose($handle);
            
            $debug_log[] = "Processamento finalizado. Novos: $count_new, Atualizados: $count_updated, Total Linhas: $row_idx";

            // Marcar como Movimentado os que não constam no arquivo
            $faltando = $this->model::whereNotIn('id', $present_ids)->get();
            foreach ($faltando as $item) {
                if ($item->status !== 'Movimentado') {
                    $item->update(['status' => 'Movimentado']);
                    $item->observacoes()->create([
                        'usuario_id' => $_SESSION['user']['id'],
                        'observacao' => "Movimentado no LCM {$mes}-{$ano}"
                    ]);
                }
            }

            if ($count_new === 0 && $count_updated === 0 && $row_idx > 0) {
                 $_SESSION['import_debug'] = $debug_log;
                 throw new \Exception("Nenhum registro foi inserido ou atualizado. Verifique o formato do arquivo.");
            }

            $this->redirect("index.php?c={$this->slug}&a=reconciliar&msg=success&new=$count_new&upd=$count_updated");

        } catch (\Exception $e) {
            $this->view("dashboard/patrimonio/reconciliar", [
                'titulo' => 'Erro na Reconciliação',
                'controller' => $this->slug,
                'error' => $e->getMessage(),
                'titulo_singular' => $this->titulo_singular,
                'debug' => $debug_log
            ]);
        }
    }
}
