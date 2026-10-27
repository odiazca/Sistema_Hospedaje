<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/** Historial / favoritas del Asistente de reportes (por empresa y usuario). */
class IaConsulta extends Model
{
    protected $table = 'ia_consultas';
    protected $guarded = [];
    protected $casts = ['favorito' => 'boolean', 'ultimo_uso' => 'datetime'];
}
