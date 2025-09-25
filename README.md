
# 🚀 Auto-Git (com fzf)

Um script interativo em **[Shell Script](https://www.gnu.org/software/bash/)** que facilita o uso dos principais comandos do **[Git](https://git-scm.com/)** com uma interface amigável utilizando o **[fzf](https://github.com/junegunn/fzf)**.  
O objetivo é **praticar Git de forma didática** e **agilizar tarefas do dia a dia**, tornando mais rápido alternar branches, mesclar, visualizar logs e gerenciar commits.

---

## 📋 Pré-requisitos

Antes de começar, você precisa ter instalado:

- **[Git](https://git-scm.com/)**  
- **[fzf](https://github.com/junegunn/fzf)** (fuzzy finder)  
- **Bash** (normalmente já vem instalado no Linux/macOS; no Windows, use [Git Bash](https://gitforwindows.org/))

Verifique se o `fzf` está funcionando executando:

```bash
fzf --version
```

---

## 🔧 Instalação

1. Clone o repositório:

```bash
git clone https://github.com/victorsrp/auto-git.git
cd auto-git
```

2. Dê permissão de execução:

```bash
chmod +x auto-git.sh
```

3. (Opcional) Crie um alias global para usar o script em qualquer repositório Git:

```bash
echo "alias auto-git='~/caminho/para/auto-git/auto-git.sh'" >> ~/.bashrc
source ~/.bashrc
```

Agora você pode rodar o comando `auto-git` em qualquer repositório 🚀

---

## 🖥️ Funcionalidades

Ao rodar `auto-git`, você terá um menu interativo com as principais opções:

| Opção | Comando Git correspondente | Descrição |
|-------|---------------------------|-----------|
| 1 | `git switch <branch>` | Alterna entre branches |
| 2 | `git merge <branch>` | Faz merge de uma branch |
| 3 | `git branch -d <branch>` | Deleta uma branch local |
| 4 | `git status` | Mostra o status do repositório |
| 5 | `git log --oneline --graph --all` | Exibe o histórico de commits |
| 6 | `git add <files>` | Adiciona arquivos ao staging |
| 7 | `git commit -m "mensagem"` | Realiza commit |
| 8 | `git push origin <branch>` | Envia commits para o remoto |
| 9 | `git pull origin <branch>` | Atualiza branch local com remoto |
| 10 | `git stash / git stash pop` | Armazena ou aplica alterações temporárias |
| 11 | `git diff` | Mostra diferenças entre arquivos |
| ❌ | Exit | Sai do menu |

---

## 📦 Uso

Dentro de qualquer repositório Git, basta rodar:

```bash
auto-git
```

E escolher a ação desejada usando as setas ou digitando o nome da opção.

---

## 🛠️ Construído com

- **[Bash](https://www.gnu.org/software/bash/)** – Scripts de automação  
- **[fzf](https://github.com/junegunn/fzf)** – Interface interativa para seleção  
- **[Git](https://git-scm.com/)** – Sistema de controle de versão  

---

## ✒️ Autor

Victor Pereira – Desenvolvimento e Documentação  
✉️ Contato: [victorsrp@gmail.com](mailto:victorsrp@gmail.com)
