<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

abstract class AtivoBase extends Model {
    protected $fillable = [
        'opm',
        'num_serie',
        'patrimonio',
        'tipo_material',
        'descricao',
        'valor',
        'localizacao',
        'status'
    ];

    public function observacoes() {
        return $this->morphMany(Observacao::class, 'observavel')->orderBy('created_at', 'desc');
    }
}
