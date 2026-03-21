<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AtivoObservacao extends Model {
    protected $table = 'ativo_observacoes';

    protected $fillable = [
        'ativo_id',
        'usuario_id',
        'observacao'
    ];

    public function usuario() {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }
}
