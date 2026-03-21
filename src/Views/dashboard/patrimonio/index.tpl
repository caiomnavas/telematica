{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fa fa-boxes me-2 text-primary"></i> {$titulo}</h5>
                    <a href="index.php?c={$controller}&a=novo" class="btn btn-sm btn-primary"><i class="fa fa-plus me-2"></i> Novo Registro</a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Patrimônio</th>
                                    <th>Série</th>
                                    <th>OPM</th>
                                    <th>Status</th>
                                    <th>Localização</th>
                                    <th>Valor</th>
                                    <th class="text-end pe-4">Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$ativos item=a}
                                    <tr>
                                        <td class="ps-4"><strong>{$a->patrimonio}</strong></td>
                                        <td>{$a->num_serie}</td>
                                        <td>{$a->opm}</td>
                                        <td>
                                            <span class="badge {if $a->status == 'Operando'}bg-success{elseif $a->status == 'Baixado'}bg-warning{else}bg-danger{/if}">
                                                {$a->status}
                                            </span>
                                        </td>
                                        <td>{$a->localizacao}</td>
                                        <td>R$ {$a->valor|number_format:2:',':'.'}</td>
                                        <td class="text-end pe-4">
                                            <button type="button" 
                                                    class="btn btn-sm btn-outline-info btn-obs" 
                                                    title="Ver Observações"
                                                    data-patrimonio="{$a->patrimonio}"
                                                    data-obs='{json_encode($a->observacoes)}'>
                                                <i class="fa fa-history"></i>
                                            </button>
                                            <a href="index.php?c={$controller}&a=editar&id={$a->id}" class="btn btn-sm btn-outline-primary" title="Editar"><i class="fa fa-edit"></i></a>
                                            <a href="index.php?c={$controller}&a=excluir&id={$a->id}" 
                                               class="btn btn-sm btn-outline-danger" 
                                               title="Excluir"
                                               onclick="return confirm('Tem certeza que deseja remover este registro?')">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="7" class="text-center py-4 text-muted">Nenhum registro encontrado.</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Observações -->
    <div class="modal fade" id="modalObservacoes" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title"><i class="fa fa-history me-2"></i> Histórico de Observações - <span id="modalPatrimonio"></span></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-0">
                    <div id="listaObservacoes" class="list-group list-group-flush" style="max-height: 400px; overflow-y: auto;">
                        <!-- Conteúdo via JS -->
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('.btn-obs').on('click', function() {
                const patrimonio = $(this).data('patrimonio');
                const obsData = $(this).data('obs');
                
                $('#modalPatrimonio').text(patrimonio);
                const $lista = $('#listaObservacoes');
                $lista.empty();

                if (obsData && obsData.length > 0) {
                    obsData.forEach(function(item) {
                        const dataFormatada = new Date(item.created_at).toLocaleString('pt-BR');
                        $lista.append(`
                            <div class="list-group-item p-3">
                                <div class="d-flex w-100 justify-content-between mb-1">
                                    <h6 class="mb-1 fw-bold text-primary">${item.usuario.nome}</h6>
                                    <small class="text-muted">${dataFormatada}</small>
                                </div>
                                <p class="mb-1 small">${item.observacao}</p>
                            </div>
                        `);
                    });
                } else {
                    $lista.append('<div class="p-4 text-center text-muted">Nenhuma observação encontrada para este ativo.</div>');
                }

                $('#modalObservacoes').modal('show');
            });
        });
    </script>
{/block}
