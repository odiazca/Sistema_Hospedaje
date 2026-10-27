@extends('layouts.app')
@section('title', 'Chat IA')
@section('breadcrumb', 'Inteligencia / Chat IA')

@section('content')
<div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
    <div>
        <h1 class="hp-pagetitle">Chat IA</h1>
        <p class="text-muted small mb-0">Conversa con tu sistema: pregunta por reservas, ocupación, huéspedes, facturas o cómo usar cada módulo</p>
    </div>
    <a class="ia-soft" href="{{ route('asistente.index') }}"><i class="bi bi-gear-fill"></i> Configurar IA</a>
</div>
<div id="chatPage"></div>
@endsection
