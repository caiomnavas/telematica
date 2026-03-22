{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fa {if isset($tpd)}fa-edit{else}fa-plus{/if} me-2 text-primary"></i> {$titulo}</h5>
                </div>
                <div class="card-body p-4">
                    
                    {if $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/if}

                    <form action="{if isset($tpd)}index.php?c=tpd&a=editar&id={$tpd->id}{else}index.php?c=tpd&a=novo{/if}" method="POST">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="opm" class="form-label fw-bold">OPM (Unidade)</label>
                                <input type="text" name="opm" id="opm" class="form-control" value="{$tpd->opm|default:''}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="num_serie" class="form-label fw-bold">Número de Série</label>
                                <input type="text" name="num_serie" id="num_serie" class="form-control" value="{$tpd->num_serie|default:''}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="patrimonio" class="form-label fw-bold">Nº Patrimônio</label>
                                <input type="text" name="patrimonio" id="patrimonio" class="form-control" value="{$tpd->patrimonio|default:''}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="tipo_material" class="form-label fw-bold">Tipo de Material</label>
                                <input type="text" name="tipo_material" id="tipo_material" class="form-control" placeholder="Ex: Terminal Portátil" value="{$tpd->tipo_material|default:''}" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="valor" class="form-label fw-bold">Valor (R$)</label>
                                <input type="text" name="valor" id="valor" class="form-control" placeholder="0,00" value="{if isset($tpd)}{$tpd->valor|number_format:2:',':'.'}{/if}" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="localizacao" class="form-label fw-bold">Localização (Seção)</label>
                                <input type="text" name="localizacao" id="local_izacao" class="form-control" value="{$tpd->localizacao|default:''}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="descricao" class="form-label fw-bold">Descrição do Material</label>
                            <textarea name="descricao" id="descricao" class="form-control" rows="3" required>{$tpd->descricao|default:''}</textarea>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="index.php?c=tpd" class="btn btn-light"><i class="fa fa-arrow-left me-2"></i> Voltar</a>
                            <button type="submit" class="btn btn-primary px-5"><i class="fa fa-save me-2"></i> Salvar TPD</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script>
        $(document).ready(function(){
            $('#valor').mask('#.##0,00', { reverse: true });
        });
    </script>
{/block}
