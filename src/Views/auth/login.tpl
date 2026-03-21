<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Telematica MVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-card { width: 100%; max-width: 400px; padding: 2rem; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); background: #fff; }
    </style>
</head>
<body>

    <div class="login-card">
        <h3 class="text-center mb-4">Acesso ao Sistema</h3>
        
        {if isset($smarty.get.msg) && $smarty.get.msg == 'updated'}
            <div class="alert alert-info small">Seus dados foram atualizados. Por favor, faça login novamente.</div>
        {/if}

        {if $error}
            <div class="alert alert-danger">{$error}</div>
        {/if}

        <form action="index.php?c=auth&a=login" method="POST">
            <div class="mb-3">
                <label for="email" class="form-label">E-mail</label>
                <input type="email" name="email" id="email" class="form-control" placeholder="admin@telematica.com.br" required>
            </div>
            <div class="mb-3">
                <label for="senha" class="form-label">Senha</label>
                <input type="password" name="senha" id="senha" class="form-control" placeholder="admin123" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 py-2">Entrar</button>
        </form>
        
        <div class="mt-4 text-center text-muted">
            <small>&copy; 2026 Telematica MVC</small>
        </div>
    </div>

</body>
</html>
