{extends file="layouts/main.tpl"}

{block name=content}
<div class="container-fluid">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.php?c={$controller}">{$titulo_singular}s</a></li>
            <li class="breadcrumb-item active" aria-current="page">Reconciliação</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fa fa-file-excel me-2"></i> Reconciliação de {$titulo_singular}s</h5>
                </div>
                <div class="card-body">
                    {if isset($smarty.get.msg) && $smarty.get.msg == 'success'}
                        <div class="alert alert-success">
                            Reconciliação concluída com sucesso! Novos registros foram adicionados e os ausentes marcados como "Movimentado".
                        </div>
                    {elseif isset($smarty.get.msg) && $smarty.get.msg == 'file_error'}
                        <div class="alert alert-danger">
                            Erro: O arquivo não foi enviado corretamente.
                        </div>
                    {/if}

                    {if isset($error)}
                        <div class="alert alert-danger">
                            <strong>Erro:</strong> {$error}
                        </div>
                    {/if}

                    {if isset($debug) && !empty($debug)}
                        <div class="mt-3">
                            <h6>Log de Processamento:</h6>
                            <div class="bg-dark text-light p-3 rounded small" style="max-height: 200px; overflow-y: auto;">
                                {foreach from=$debug item=line}
                                    <div>> {$line}</div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}

                    <div class="alert alert-info py-2 small">
                        <strong>Formato esperado (CSV):</strong><br>
                        <code>opm; num_serie; patrimonio; tipo_material; descricao; valor; localizacao</code>
                    </div>

                    <form action="index.php?c={$controller}&a=importar" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Arquivo CSV</label>
                            <input type="file" name="arquivo" class="form-control" accept=".csv" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Mês de Referência</label>
                                <select name="mes" class="form-select" required>
                                    <option value="Janeiro">Janeiro</option>
                                    <option value="Fevereiro">Fevereiro</option>
                                    <option value="Março" selected>Março</option>
                                    <option value="Abril">Abril</option>
                                    <option value="Maio">Maio</option>
                                    <option value="Junho">Junho</option>
                                    <option value="Julho">Julho</option>
                                    <option value="Agosto">Agosto</option>
                                    <option value="Setembro">Setembro</option>
                                    <option value="Outubro">Outubro</option>
                                    <option value="Novembro">Novembro</option>
                                    <option value="Dezembro">Dezembro</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Ano</label>
                                <input type="number" name="ano" class="form-control" value="{$smarty.now|date_format:"%Y"}" required>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fa fa-sync me-2"></i> Processar Reconciliação
                            </button>
                            <a href="index.php?c={$controller}" class="btn btn-outline-secondary">Voltar</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
{/block}
