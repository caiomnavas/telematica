{extends file="layouts/main.tpl"}

{block name=content}
    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm border-0">
                <div class="card-body p-5 text-center">
                    <h1 class="display-4">Bem-vindo, {$user_logged.nome}!</h1>
                    <p class="lead text-muted">Este é o seu novo painel administrativo construído com PHP MVC, Eloquent e Smarty.</p>
                    <hr class="my-4">
                    <p>Você está logado como: <strong>{$user_logged.email}</strong></p>
                    <div class="mt-4">
                        <a href="#" class="btn btn-primary btn-lg px-4"><i class="fa fa-plus me-2"></i> Novo Registro</a>
                        <a href="#" class="btn btn-outline-secondary btn-lg px-4"><i class="fa fa-list me-2"></i> Listar Dados</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-primary text-white text-center p-3">
                <h3>150</h3>
                <span>Usuários Ativos</span>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-success text-white text-center p-3">
                <h3>85</h3>
                <span>Novas Vendas</span>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-warning text-white text-center p-3">
                <h3>12</h3>
                <span>Alertas</span>
            </div>
        </div>
    </div>
{/block}
