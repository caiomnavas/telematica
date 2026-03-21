{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fa fa-boxes me-2 text-primary"></i> {$titulo}</h5>
                    <a href="index.php?c=ativo&a=novo&t={$tipo_slug}" class="btn btn-sm btn-primary"><i class="fa fa-plus me-2"></i> Novo Registro</a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Patrimônio</th>
                                    <th>Série</th>
                                    <th>OPM</th>
                                    <th>Material</th>
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
                                        <td>{$a->tipo_material}</td>
                                        <td>
                                            <span class="badge {if $a->status == 'Operando'}bg-success{elseif $a->status == 'Baixado'}bg-warning{else}bg-danger{/if}">
                                                {$a->status}
                                            </span>
                                        </td>
                                        <td>{$a->localizacao}</td>
                                        <td>R$ {$a->valor|number_format:2:',':'.'}</td>
                                        <td class="text-end pe-4">
                                            <a href="index.php?c=ativo&a=editar&t={$tipo_slug}&id={$a->id}" class="btn btn-sm btn-outline-primary" title="Editar / Observações"><i class="fa fa-edit"></i></a>
                                            <a href="index.php?c=ativo&a=excluir&t={$tipo_slug}&id={$a->id}" 
                                               class="btn btn-sm btn-outline-danger" 
                                               title="Excluir"
                                               onclick="return confirm('Tem certeza que deseja remover este registro?')">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="8" class="text-center py-4 text-muted">Nenhum registro encontrado.</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
