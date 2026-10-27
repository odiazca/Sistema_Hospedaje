<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/** Configuración del proveedor de IA por empresa (la clave va cifrada y nunca se expone). */
class IaConfig extends Model
{
    protected $table = 'ia_configs';
    protected $guarded = [];
    protected $casts = ['resumen' => 'boolean'];
    protected $hidden = ['clave'];
}
