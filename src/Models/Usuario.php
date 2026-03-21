<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Usuario extends Model {
    protected $table = 'usuarios';

    protected $fillable = ['nome', 'email', 'senha', 'nivel', 'status'];

    // Método auxiliar para verificar se é admin
    public function isAdmin() {
        return $this->nivel === 'admin';
    }

    // Método auxiliar para verificar se está ativo
    public function isActive() {
        return $this->status === 'ativo';
    }
}
