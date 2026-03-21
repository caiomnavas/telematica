<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Tpd;
use App\Models\RadioMovel;
use App\Models\RadioPortatil;
use App\Models\Celular;
use App\Models\Computador;
use App\Models\Impressora;
use App\Models\Notebook;
use Illuminate\Database\Capsule\Manager as Capsule;

class DashboardController extends Controller {
    public function __construct() {
        parent::__construct();
        $this->middlewareAuth();
    }

    private function getResumoPorModelo($modelClass) {
        return $modelClass::select('opm',
            Capsule::raw("SUM(CASE WHEN status = 'Operando' THEN 1 ELSE 0 END) as operando"),
            Capsule::raw("SUM(CASE WHEN status = 'Baixado' THEN 1 ELSE 0 END) as baixado"),
            Capsule::raw("SUM(CASE WHEN status = 'Descarregado' THEN 1 ELSE 0 END) as descarregado"),
            Capsule::raw("COUNT(*) as total")
        )
        ->groupBy('opm')
        ->get();
    }

    public function index() {
        $resumo = [
            'TPDs'              => $this->getResumoPorModelo(Tpd::class),
            'Rádios Móveis'     => $this->getResumoPorModelo(RadioMovel::class),
            'Rádios Portáteis'  => $this->getResumoPorModelo(RadioPortatil::class),
            'Celulares'         => $this->getResumoPorModelo(Celular::class),
            'Computadores'      => $this->getResumoPorModelo(Computador::class),
            'Impressoras'       => $this->getResumoPorModelo(Impressora::class),
            'Notebooks'         => $this->getResumoPorModelo(Notebook::class),
        ];

        $this->view('dashboard/index', [
            'titulo' => 'Painel de Controle',
            'resumos' => $resumo
        ]);
    }
}
