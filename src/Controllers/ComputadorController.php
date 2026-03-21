<?php

namespace App\Controllers;

use App\Models\Computador;

class ComputadorController extends PatrimonioController {
    protected $model = Computador::class;
    protected $slug = 'computador';
    protected $titulo_singular = 'Computador';
}
