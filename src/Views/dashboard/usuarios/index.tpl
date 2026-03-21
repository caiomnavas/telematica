{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fa fa-users me-2 text-primary"></i> Gerenciar Usuários</h5>
                    <a href="index.php?c=usuario&a=novo" class="btn btn-sm btn-primary"><i class="fa fa-plus me-2"></i> Novo Usuário</a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Nome</th>
                                    <th>E-mail</th>
                                    <th>Nível</th>
                                    <th>Status</th>
                                    <th class="text-end pe-4">Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$usuarios item=u}
                                    <tr {if $u->status == 'inativo'}class="opacity-50 text-decoration-line-through"{/if}>
                                        <td class="ps-4">{$u->id}</td>
                                        <td><strong>{$u->nome}</strong></td>
                                        <td>{$u->email}</td>
                                        <td>
                                            <span class="badge {if $u->nivel == 'admin'}bg-danger{else}bg-secondary{/if}">
                                                {$u->nivel|upper}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge {if $u->status == 'ativo'}bg-success{else}bg-warning{/if}">
                                                {$u->status|upper}
                                            </span>
                                        </td>
                                        <td class="text-end pe-4">
                                            <a href="index.php?c=usuario&a=editar&id={$u->id}" class="btn btn-sm btn-outline-primary" title="Editar"><i class="fa fa-edit"></i></a>
                                            
                                            {if $u->id != $user_logged.id}
                                                <a href="index.php?c=usuario&a=toggleStatus&id={$u->id}" 
                                                   class="btn btn-sm {if $u->status == 'ativo'}btn-outline-warning{else}btn-outline-success{/if}" 
                                                   title="{if $u->status == 'ativo'}Desativar{else}Ativar{/if}"
                                                   onclick="return confirm('Tem certeza que deseja alterar o status deste usuário?')">
                                                    <i class="fa {if $u->status == 'ativo'}fa-user-times{else}fa-user-check{/if}"></i>
                                                </a>
                                            {/if}
                                        </td>
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
