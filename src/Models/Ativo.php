<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ativo extends Model {
    protected $table = 'ativos';

    protected $fillable = [
        'tipo_dispositivo',
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
        return $this->hasMany(AtivoObservacao::class, 'ativo_id')->orderBy('created_at', 'desc');
    }
}
