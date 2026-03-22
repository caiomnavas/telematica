<?php

namespace App\Controllers;

use App\Models\Tpd;

class TpdController extends PatrimonioController {
    protected $model = Tpd::class;
    protected $slug = 'tpd';
    protected $titulo_singular = 'TPD';
}
