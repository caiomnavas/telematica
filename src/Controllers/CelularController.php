<?php

namespace App\Controllers;

use App\Models\Celular;

class CelularController extends PatrimonioController {
    protected $model = Celular::class;
    protected $slug = 'celular';
    protected $titulo_singular = 'Celular';
}
