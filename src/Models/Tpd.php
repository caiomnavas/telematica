<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tpd extends Model {
    protected $table = 'tpds';

    protected $fillable = [
        'opm',
        'num_serie',
        'patrimonio',
        'tipo_material',
        'descricao',
        'valor',
        'localizacao'
    ];
}
