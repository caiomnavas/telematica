# Telematica MVC - Projeto PHP/MySQL

Sistema de gerenciamento de usuários desenvolvido com arquitetura MVC, utilizando componentes modernos do ecossistema PHP.

## 🚀 Tecnologias Utilizadas

- **PHP 8.2+**
- **MySQL**
- **MVC Architecture** (Model-View-Controller)
- **Composer** (Gerenciamento de dependências)
- **Eloquent ORM** (`illuminate/database`) - Manipulação de banco de dados
- **Smarty 5** - Motor de templates para as Views
- **PHP Dotenv** - Gerenciamento de variáveis de ambiente (`.env`)
- **Bootstrap 5** - Interface responsiva e moderna
- **FontAwesome 6** - Ícones do sistema

## 📂 Estrutura do Projeto

- `index.php`: Front Controller (Ponto de entrada único).
- `src/Core/`: Classes base do sistema (Controller, etc).
- `src/Controllers/`: Lógica de controle e rotas.
- `src/Models/`: Modelos do Eloquent para as tabelas.
- `src/Views/`: Templates Smarty (`.tpl`).
- `config/`: Arquivos de configuração global.
- `assets/`: Arquivos estáticos (CSS, JS, Imagens).

## 🛠️ Instalação e Configuração

1. **Clonar o projeto**:
   ```bash
   git clone https://github.com/caiomnavas/telematica.git
   ```

2. **Instalar dependências**:
   ```bash
   composer install
   ```

3. **Configurar variáveis de ambiente**:
   Renomeie ou crie o arquivo `.env` na raiz e preencha com seus dados:
   ```env
   DB_HOST=localhost
   DB_NAME=telematica_db
   DB_USER=root
   DB_PASS=
   BASE_URL=http://localhost/telematica/
   ```

4. **Instalar Banco de Dados**:
   Acesse no navegador: `http://localhost/telematica/install.php`
   *(Remova o arquivo install.php após a execução por segurança)*

## 🔐 Acesso Padrão

- **E-mail**: `admin@telematica.com.br`
- **Senha**: `admin123`

## 📝 Notas
Este projeto foi configurado para funcionar **sem URLs amigáveis** (mod_rewrite desativado), utilizando o padrão `index.php?c=controller&a=action`.
