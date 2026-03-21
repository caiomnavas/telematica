{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom py-3">
                    <h5 class="mb-0"><i class="fa fa-user me-2 text-primary"></i> Meus Dados</h5>
                </div>
                <div class="card-body p-4">
                    
                    {if $message}
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            {$message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    {/if}

                    {if $error}
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            {$error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    {/if}

                    <div class="alert alert-info border-0 shadow-sm mb-4">
                        <i class="fa fa-info-circle me-2"></i> Caso você altere o seu <strong>e-mail</strong> ou <strong>senha</strong>, o sistema solicitará um novo login por questões de segurança.
                    </div>

                    <form action="index.php?c=usuario&a=minhaConta" method="POST">
                        <div class="mb-3">
                            <label for="nome" class="form-label fw-bold">Nome Completo</label>
                            <input type="text" name="nome" id="nome" class="form-control" value="{$user->nome}" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label fw-bold">E-mail de Acesso</label>
                            <input type="email" name="email" id="email" class="form-control" value="{$user->email}" required>
                        </div>

                        <div class="mb-4">
                            <label for="senha" class="form-label fw-bold">Nova Senha</label>
                            <input type="password" name="senha" id="senha" class="form-control" placeholder="Deixe em branco para manter a atual">
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary py-2"><i class="fa fa-save me-2"></i> Salvar Alterações</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/block}
