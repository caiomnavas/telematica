<?php

namespace App\Controllers;

use App\Models\Notebook;

class NotebookController extends PatrimonioController {
    protected $model = Notebook::class;
    protected $slug = 'notebook';
    protected $titulo_singular = 'Notebook';
}
