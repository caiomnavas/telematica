<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Observacao extends Model {
    protected $table = 'observacoes';

    protected $fillable = [
        'observavel_id',
        'observavel_type',
        'usuario_id',
        'observacao'
    ];

    public function usuario() {
        return $this->belongsTo(Usuario::class, 'usuario_id');
    }

    public function observavel() {
        return $this->morphTo();
    }
}
