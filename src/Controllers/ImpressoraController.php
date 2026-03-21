<?php

namespace App\Controllers;

use App\Models\Impressora;

class ImpressoraController extends PatrimonioController {
    protected $model = Impressora::class;
    protected $slug = 'impressora';
    protected $titulo_singular = 'Impressora';
}
