<?php

namespace App\Controllers;

use App\Core\Controller;

class HomeController extends Controller {
    public function index() {
        if (!isset($_SESSION['user'])) {
            $this->redirect('index.php?c=auth&a=login');
        } else {
            $this->redirect('index.php?c=dashboard');
        }
    }
}
