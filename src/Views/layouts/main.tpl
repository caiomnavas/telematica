<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$titulo|default:"Telematica MVC"}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #2c3e50; color: #fff; width: 250px; position: fixed; left: 0; top: 0; }
        .sidebar a { color: #bdc3c7; text-decoration: none; padding: 10px 20px; display: block; }
        .sidebar a:hover { background-color: #34495e; color: #fff; }
        .sidebar a.active { background-color: #007bff; color: #fff; }
        .topbar { background-color: #fff; padding: 10px 20px; margin-left: 250px; border-bottom: 1px solid #dee2e6; }
        .main-content { margin-left: 250px; padding: 20px; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="p-3 text-center">
            <h4>Telemática</h4>
            <hr class="bg-light">
        </div>
        <a href="index.php?c=dashboard" class="active"><i class="fa fa-home me-2"></i> Dashboard</a>
        
        <div class="px-3 py-2 small text-uppercase text-muted fw-bold">Patrimônio</div>
        <a href="index.php?c=tpd"><i class="fa fa-tablet-alt me-2"></i> TPDs</a>
        <a href="index.php?c=radioMovel"><i class="fa fa-broadcast-tower me-2"></i> Rádios Móveis</a>
        <a href="index.php?c=radioPortatil"><i class="fa fa-walkie-talkie me-2"></i> Rádios Portáteis</a>
        <a href="index.php?c=celular"><i class="fa fa-mobile-alt me-2"></i> Celulares</a>
        <a href="index.php?c=computador"><i class="fa fa-desktop me-2"></i> Computadores</a>
        <a href="index.php?c=notebook"><i class="fa fa-laptop me-2"></i> Notebooks</a>
        <a href="index.php?c=impressora"><i class="fa fa-print me-2"></i> Impressoras</a>

        <div class="px-3 py-2 small text-uppercase text-muted fw-bold">Sistema</div>
        {if isset($user_logged.nivel) && $user_logged.nivel == 'admin'}
            <a href="index.php?c=usuario"><i class="fa fa-users me-2"></i> Usuários</a>
        {/if}

        <a href="#"><i class="fa fa-cog me-2"></i> Configurações</a>
    </div>

    <div class="topbar d-flex justify-content-between align-items-center">
        <h5 class="mb-0">{$titulo}</h5>
        <div class="dropdown">
            <button class="btn btn-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fa fa-user-circle me-1"></i> {$user_logged.nome}
            </button>
            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                <li><a class="dropdown-menu-item dropdown-item" href="index.php?c=usuario&a=minhaConta"><i class="fa fa-user me-2"></i> Minha Conta</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-menu-item dropdown-item text-danger" href="index.php?c=auth&a=logout"><i class="fa fa-sign-out-alt me-2"></i> Logout</a></li>
            </ul>
        </div>
    </div>

    <div class="main-content">
        {block name=content}{/block}
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
