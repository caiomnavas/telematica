<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Usuario;

class UsuarioController extends Controller {
    public function __construct() {
        parent::__construct();
        $this->middlewareAuth();
    }

    public function index() {
        $this->middlewareAdmin();
        // Buscar todos os usuários, exceto o que está logado
        $usuarios = Usuario::where('id', '!=', $_SESSION['user']['id'])->get();
        
        $this->view('dashboard/usuarios/index', [
            'titulo' => 'Gerenciar Usuários',
            'usuarios' => $usuarios
        ]);
    }

    public function novo() {
        $this->middlewareAdmin();
        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'];
            if (Usuario::where('email', $email)->exists()) {
                $error = "Este e-mail já está cadastrado.";
            } else {
                Usuario::create([
                    'nome'   => $_POST['nome'],
                    'email'  => $email,
                    'senha'  => password_hash($_POST['senha'], PASSWORD_DEFAULT),
                    'nivel'  => $_POST['nivel'],
                    'status' => 'ativo'
                ]);
                $this->redirect('index.php?c=usuario&msg=created');
            }
        }

        $this->view('dashboard/usuarios/form', [
            'titulo' => 'Novo Usuário',
            'error'  => $error
        ]);
    }

    public function editar() {
        $this->middlewareAdmin();
        $id = $_GET['id'] ?? null;
        $usuario = Usuario::find($id);

        if (!$usuario) $this->redirect('index.php?c=usuario');

        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'];
            if (Usuario::where('email', $email)->where('id', '!=', $id)->exists()) {
                $error = "Este e-mail já está em uso por outro usuário.";
            } else {
                $usuario->nome  = $_POST['nome'];
                $usuario->email = $email;
                $usuario->nivel = $_POST['nivel'];
                
                if (!empty($_POST['senha'])) {
                    $usuario->senha = password_hash($_POST['senha'], PASSWORD_DEFAULT);
                }

                $usuario->save();
                $this->redirect('index.php?c=usuario&msg=updated');
            }
        }

        $this->view('dashboard/usuarios/form', [
            'titulo'  => 'Editar Usuário',
            'usuario' => $usuario,
            'error'   => $error
        ]);
    }

    public function toggleStatus() {
        $this->middlewareAdmin();
        $id = $_GET['id'] ?? null;
        $usuario = Usuario::find($id);

        if ($usuario && $usuario->id != $_SESSION['user']['id']) {
            $usuario->status = ($usuario->status === 'ativo') ? 'inativo' : 'ativo';
            $usuario->save();
        }

        $this->redirect('index.php?c=usuario&msg=status_changed');
    }

    public function minhaConta() {
        $userId = $_SESSION['user']['id'];
        $user = Usuario::find($userId);
        
        $message = null;
        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $nome  = $_POST['nome'];
            $email = $_POST['email'];
            $senha = $_POST['senha'];

            $emailChanged = ($email !== $user->email);
            $passwordChanged = !empty($senha);

            // Verificar se o e-mail já existe para outro usuário
            if ($emailChanged && Usuario::where('email', $email)->where('id', '!=', $userId)->exists()) {
                $error = "Este e-mail já está sendo utilizado por outro usuário.";
            } else {
                $user->nome = $nome;
                $user->email = $email;

                if ($passwordChanged) {
                    $user->senha = password_hash($senha, PASSWORD_DEFAULT);
                }

                $user->save();

                if ($emailChanged || $passwordChanged) {
                    // Destruir sessão e forçar login se dados sensíveis mudarem
                    session_destroy();
                    $this->redirect('index.php?c=auth&a=login&msg=updated');
                } else {
                    // Apenas atualizar o nome na sessão atual
                    $_SESSION['user']['nome'] = $nome;
                    $message = "Dados atualizados com sucesso!";
                }
            }
        }

        $this->view('dashboard/minha_conta', [
            'titulo' => 'Minha Conta',
            'user' => $user,
            'message' => $message,
            'error' => $error
        ]);
    }
}
