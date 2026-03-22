{extends file="layouts/main.tpl"}

{block name=content}
<div class="container-fluid">
    <div class="row mb-4">
        <div class="col-12 text-center">
            <h2 class="display-6"><i class="fa fa-chart-line text-primary me-2"></i> Resumo de Ativos por OPM</h2>
            <p class="text-muted">Abaixo estão os totais de ativos distribuídos por Unidade (OPM).</p>
        </div>
    </div>

    <div class="row">
        {foreach from=$resumos key=tipo item=lista}
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-white py-3 border-0 d-flex align-items-center">
                        <i class="fa {if $tipo == 'TPDs'}fa-tablet-alt{elseif $tipo == 'Celulares'}fa-mobile-alt{elseif $tipo == 'Notebooks'}fa-laptop{elseif $tipo == 'Impressoras'}fa-print{elseif $tipo == 'Computadores'}fa-desktop{else}fa-broadcast-tower{/if} text-primary me-2"></i>
                        <h5 class="mb-0 fw-bold">{$tipo}</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle">
                                <thead class="bg-light small text-uppercase">
                                    <tr>
                                        <th class="ps-3">OPM</th>
                                        <th class="text-center">Operando</th>
                                        <th class="text-center">Baixados</th>
                                        <th class="text-center pe-3">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$lista item=res}
                                        <tr>
                                            <td class="ps-3 fw-medium text-secondary">{$res->opm}</td>
                                            <td class="text-center">
                                                <span class="badge bg-success-subtle text-success border border-success px-3">{$res->operando}</span>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-warning-subtle text-warning border border-warning px-3">{$res->baixado}</span>
                                            </td>
                                            <td class="text-center pe-3 fw-bold">{$res->total}</td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td colspan="4" class="text-center py-4 text-muted small">Nenhum ativo deste tipo registrado.</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
</div>

<style>
    .card { transition: transform 0.2s ease; }
    .card:hover { transform: translateY(-3px); }
    .bg-success-subtle { background-color: #e6ffed !important; }
    .bg-warning-subtle { background-color: #fff8eb !important; }
</style>
{/block}
