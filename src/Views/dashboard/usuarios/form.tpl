{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fa {if isset($usuario)}fa-edit{else}fa-user-plus{/if} me-2 text-primary"></i> {$titulo}</h5>
                </div>
                <div class="card-body p-4">
                    
                    {if $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/if}

                    <form action="{if isset($usuario)}index.php?c=usuario&a=editar&id={$usuario->id}{else}index.php?c=usuario&a=novo{/if}" method="POST">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nome" class="form-label fw-bold">Nome Completo</label>
                                <input type="text" name="nome" id="nome" class="form-control" value="{$usuario->nome|default:''}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label fw-bold">E-mail</label>
                                <input type="email" name="email" id="email" class="form-control" value="{$usuario->email|default:''}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nivel" class="form-label fw-bold">Nível de Acesso</label>
                                <select name="nivel" id="nivel" class="form-select" required>
                                    <option value="usuario" {if isset($usuario) && $usuario->nivel == 'usuario'}selected{/if}>Usuário Comum</option>
                                    <option value="admin" {if isset($usuario) && $usuario->nivel == 'admin'}selected{/if}>Administrador</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="senha" class="form-label fw-bold">Senha {if isset($usuario)}<small class="text-muted">(deixe em branco para manter)</small>{/if}</label>
                                <input type="password" name="senha" id="senha" class="form-control" {if !isset($usuario)}required{/if}>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="index.php?c=usuario" class="btn btn-light"><i class="fa fa-arrow-left me-2"></i> Voltar</a>
                            <button type="submit" class="btn btn-primary px-5"><i class="fa fa-save me-2"></i> Salvar Usuário</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/block}
