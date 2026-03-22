{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row">
        <div class="col-md-{if isset($ativo)}7{else}12{/if}">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fa {if isset($ativo)}fa-edit{else}fa-plus{/if} me-2 text-primary"></i> {$titulo}</h5>
                </div>
                <div class="card-body p-4">
                    {if $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/if}

                    <form action="{if isset($ativo)}index.php?c={$controller}&a=editar&id={$ativo->id}{else}index.php?c={$controller}&a=novo{/if}" method="POST">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">OPM</label>
                                <input type="text" name="opm" class="form-control" value="{$ativo->opm|default:''}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Nº de Série</label>
                                <input type="text" name="num_serie" class="form-control" value="{$ativo->num_serie|default:''}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Patrimônio</label>
                                <input type="text" name="patrimonio" class="form-control" value="{$ativo->patrimonio|default:''}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Tipo de Material</label>
                                <input type="text" name="tipo_material" class="form-control" value="{$ativo->tipo_material|default:''}" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label fw-bold">Status</label>
                                <select name="status" class="form-select" required>
                                    <option value="Operando" {if isset($ativo) && $ativo->status == 'Operando'}selected{/if}>Operando</option>
                                    <option value="Baixado" {if isset($ativo) && $ativo->status == 'Baixado'}selected{/if}>Baixado</option>
                                    <option value="Descarregado" {if isset($ativo) && $ativo->status == 'Descarregado'}selected{/if}>Descarregado</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label fw-bold">Valor (R$)</label>
                                <input type="text" name="valor" id="valor" class="form-control" value="{if isset($ativo)}{$ativo->valor|number_format:2:',':'.'}{/if}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Localização (Seção)</label>
                            <input type="text" name="localizacao" class="form-control" value="{$ativo->localizacao|default:''}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Descrição</label>
                            <textarea name="descricao" class="form-control" rows="3" required>{$ativo->descricao|default:''}</textarea>
                        </div>

                        {if isset($ativo)}
                        <hr>
                        <div class="mb-3 bg-light p-3 border rounded">
                            <label class="form-label fw-bold text-primary"><i class="fa fa-comment-medical me-2"></i> Adicionar Nova Observação</label>
                            <textarea name="nova_observacao" class="form-control" rows="2" placeholder="Descreva aqui manutenções..."></textarea>
                        </div>
                        {/if}

                        <div class="d-flex justify-content-between mt-4">
                            <a href="index.php?c={$controller}" class="btn btn-light"><i class="fa fa-arrow-left me-2"></i> Voltar</a>
                            <button type="submit" class="btn btn-primary px-5"><i class="fa fa-save me-2"></i> Salvar Registro</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        {if isset($ativo)}
        <div class="col-md-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fa fa-history me-2 text-primary"></i> Histórico de Observações</h5>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush" style="max-height: 500px; overflow-y: auto;">
                        {foreach from=$ativo->observacoes item=obs}
                            <div class="list-group-item p-3">
                                <div class="d-flex w-100 justify-content-between mb-1">
                                    <h6 class="mb-1 fw-bold">{$obs->usuario->nome}</h6>
                                    <small class="text-muted">{$obs->created_at->format('d/m/Y H:i')}</small>
                                </div>
                                <p class="mb-1 small">{$obs->observacao}</p>
                            </div>
                        {foreachelse}
                            <div class="p-4 text-center text-muted">Nenhuma observação.</div>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
        {/if}
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script>
        $(document).ready(function(){
            $('#valor').mask('#.##0,00', { reverse: true });
        });
    </script>
{/block}
