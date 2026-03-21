<?php

namespace App\Controllers;

use App\Models\RadioMovel;

class RadioMovelController extends PatrimonioController {
    protected $model = RadioMovel::class;
    protected $slug = 'radioMovel';
    protected $titulo_singular = 'Rádio Móvel';
}
