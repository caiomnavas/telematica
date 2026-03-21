{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row mb-4">
        <div class="col-md-12 text-center">
            <h1 class="display-6">Resumo de Ativos por OPM</h1>
            <p class="lead text-muted">Acompanhamento de status operacional por unidade.</p>
        </div>
    </div>

    <div class="row">
        {foreach from=$resumos key=tipo item=dados}
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-white py-3 border-bottom d-flex align-items-center">
                        <h6 class="mb-0 fw-bold text-primary text-uppercase small">
                            <i class="fa fa-boxes me-2"></i> {$tipo}
                        </h6>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 small">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="ps-3">OPM</th>
                                        <th class="text-center">Operando</th>
                                        <th class="text-center">Baixados</th>
                                        <th class="text-center">Descarregados</th>
                                        <th class="text-end pe-3">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$dados item=row}
                                        <tr>
                                            <td class="ps-3 fw-bold">{$row->opm}</td>
                                            <td class="text-center text-success fw-bold">{$row->operando|default:0}</td>
                                            <td class="text-center text-warning fw-bold">{$row->baixado|default:0}</td>
                                            <td class="text-center text-danger fw-bold">{$row->descarregado|default:0}</td>
                                            <td class="text-end pe-3"><strong>{$row->total}</strong></td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td colspan="5" class="text-center py-3 text-muted italic">Nenhum registro encontrado.</td>
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
{/block}
