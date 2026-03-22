<?php

namespace App\Controllers;

use App\Models\RadioPortatil;

class RadioPortatilController extends PatrimonioController {
    protected $model = RadioPortatil::class;
    protected $slug = 'radioPortatil';
    protected $titulo_singular = 'Rádio Portátil';
}
