<?php

namespace App\Core;

use Smarty\Smarty;

abstract class Controller {
    protected $smarty;

    public function __construct() {
        $this->smarty = new Smarty();

        // Configuração dos diretórios do Smarty
        $this->smarty->setTemplateDir(__DIR__ . '/../Views/');
        $this->smarty->setCompileDir(__DIR__ . '/../../templates_c/');
        
        // Dados globais para todos os templates
        $this->smarty->assign('base_url', BASE_URL);
        $this->smarty->assign('user_logged', $_SESSION['user'] ?? null);
    }

    protected function view($viewName, $data = []) {
        foreach ($data as $key => $value) {
            $this->smarty->assign($key, $value);
        }
        $this->smarty->display("{$viewName}.tpl");
    }

    protected function middlewareAuth() {
        if (!isset($_SESSION['user'])) {
            header('Location: ' . BASE_URL . 'index.php?c=auth&a=login');
            exit;
        }
    }

    protected function middlewareAdmin() {
        if (!isset($_SESSION['user']) || $_SESSION['user']['nivel'] !== 'admin') {
            header('Location: ' . BASE_URL . 'index.php?c=dashboard&msg=admin_required');
            exit;
        }
    }

    protected function redirect($path) {
        header('Location: ' . BASE_URL . $path);
        exit;
    }
}
