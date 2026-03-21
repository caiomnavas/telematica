<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Usuario;

class AuthController extends Controller {
    public function login() {
        if (isset($_SESSION['user'])) {
            $this->redirect('index.php?c=dashboard');
        }

        $error = null;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $email = $_POST['email'];
            $senha = $_POST['senha'];

            $user = Usuario::where('email', $email)->first();

            if ($user && password_verify($senha, $user->senha)) {
                if ($user->status !== 'ativo') {
                    $error = "Sua conta está inativa. Entre em contato com o administrador.";
                } else {
                    $_SESSION['user'] = [
                        'id'    => $user->id,
                        'nome'  => $user->nome,
                        'email' => $user->email,
                        'nivel' => $user->nivel
                    ];
                    $this->redirect('index.php?c=dashboard');
                }
            } else {
                $error = "E-mail ou senha inválidos.";
            }
        }

        $this->view('auth/login', ['error' => $error]);
    }

    public function logout() {
        session_destroy();
        $this->redirect('index.php?c=auth&a=login');
    }
}
