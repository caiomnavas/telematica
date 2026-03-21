{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fa fa-hand-holding-box me-2 text-primary"></i> Controle de TPDs</h5>
                    <a href="index.php?c=tpd&a=novo" class="btn btn-sm btn-primary"><i class="fa fa-plus me-2"></i> Novo TPD</a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Patrimônio</th>
                                    <th>OPM</th>
                                    <th>Nº de Série</th>
                                    <th>Material</th>
                                    <th>Localização</th>
                                    <th>Valor</th>
                                    <th class="text-end pe-4">Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$tpds item=t}
                                    <tr>
                                        <td class="ps-4"><strong>{$t->patrimonio}</strong></td>
                                        <td>{$t->opm}</td>
                                        <td>{$t->num_serie}</td>
                                        <td>{$t->tipo_material}</td>
                                        <td>{$t->localizacao}</td>
                                        <td>R$ {$t->valor|number_format:2:',':'.'}</td>
                                        <td class="text-end pe-4">
                                            <a href="index.php?c=tpd&a=editar&id={$t->id}" class="btn btn-sm btn-outline-primary" title="Editar"><i class="fa fa-edit"></i></a>
                                            <a href="index.php?c=tpd&a=excluir&id={$t->id}" 
                                               class="btn btn-sm btn-outline-danger" 
                                               title="Excluir"
                                               onclick="return confirm('Tem certeza que deseja remover este patrimônio?')">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="7" class="text-center py-4">Nenhum TPD cadastrado.</td>
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
