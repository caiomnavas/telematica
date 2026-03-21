<?php

namespace App\Controllers;

use App\Core\Controller;

class DashboardController extends Controller {
    public function __construct() {
        parent::__construct();
        $this->middlewareAuth();
    }

    public function index() {
        $this->view('dashboard/index', [
            'titulo' => 'Painel de Controle'
        ]);
    }
}
