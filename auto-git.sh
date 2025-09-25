#!/bin/bash

function exit_exception () {
    if [ $? -eq 130 ]; then
        echo "Exiting..."
        exit 1
    fi
}

function validate_git_repository() {
    git status >> /dev/null 2>&1
    if [ $? -eq 128 ]; then
        echo "This is not a git repository"
        exit 1
    fi
}

# -------------------- GIT FUNCTIONS --------------------

function switch_branch() {
    selected=$(git branch | fzf +m \
        --header "Select the branch to switch:" \
        --preview 'git log --oneline --decorate --graph $(echo {} | tr -d "* ") | head -20' \
        --height 40% --layout reverse --border \
        --color bg:#222222,preview-bg:#333333)

    exit_exception
    selected=$(echo $selected | tr -d "* ")
    git switch "$selected"
}

function merge_branch() {
    selected=$(git branch | fzf +m \
        --header "Select branch to merge into current:" \
        --preview 'git log --oneline --decorate --graph $(echo {} | tr -d "* ") | head -20' \
        --height 40% --layout reverse --border)

    exit_exception
    selected=$(echo $selected | tr -d "* ")
    git merge "$selected"
}

function delete_branch() {
    selected=$(git branch | fzf +m \
        --header "Select branch to delete:" \
        --preview 'git log --oneline $(echo {} | tr -d "* ") | head -20' \
        --height 40% --layout reverse --border)

    exit_exception
    selected=$(echo $selected | tr -d "* ")
    git branch -d "$selected"
}

function show_status() {
    git status
}

function add_files() {
    selected=$(git ls-files -o -m --exclude-standard | fzf -m \
        --header "Select files to add:" \
        --preview 'git diff --color=always -- {}' \
        --height 40% --layout reverse --border)

    exit_exception
    if [ -n "$selected" ]; then
        echo "$selected" | xargs git add
        echo "Files added to staging"
    else
        echo "No files selected"
    fi
}

function commit_changes() {
    echo "Enter commit message: "
    read msg
    git commit -m "$msg"
}

function push_changes() {
    git push
}

function pull_changes() {
    git pull
}

function view_log() {
    git log --oneline --decorate --graph --all | fzf \
        --header "Commits:" \
        --preview 'git show --color=always {1}' \
        --height 80% --layout reverse --border
}

function stash_changes() {
    git stash push -m "Stash from auto-git"
    echo "Changes stashed"
}

function apply_stash() {
    selected=$(git stash list | fzf \
        --header "Select stash to apply:" \
        --preview 'git stash show -p {1} --color=always' \
        --height 40% --layout reverse --border)

    exit_exception
    if [ -n "$selected" ]; then
        stash_id=$(echo $selected | cut -d: -f1)
        git stash apply $stash_id
    fi
}

# -------------------- MENU --------------------

function main() {
    options=(\
        "1 - Switch branch (git switch <branch>)" \
        "2 - Merge branch (git merge <branch>)" \
        "3 - Delete branch (git branch -d <branch>)" \
        "4 - Show status (git status)" \
        "5 - Add files (git add <file...>)" \
        "6 - Commit changes (git commit -m \"msg\")" \
        "7 - Push changes (git push)" \
        "8 - Pull changes (git pull)" \
        "9 - View log (git log --oneline --graph)" \
        "10 - Stash changes (git stash)" \
        "11 - Apply stash (git stash apply)" \
        "Exit" \
    )

    selected=$(for opt in "${options[@]}"; do echo $opt; done | fzf +m \
        --header "Select an option:" \
        --height 60% --layout reverse --border)

    exit_exception

    case "$selected" in
        ${options[0]}) switch_branch ;;
        ${options[1]}) merge_branch ;;
        ${options[2]}) delete_branch ;;
        ${options[3]}) show_status ;;
        ${options[4]}) add_files ;;
        ${options[5]}) commit_changes ;;
        ${options[6]}) push_changes ;;
        ${options[7]}) pull_changes ;;
        ${options[8]}) view_log ;;
        ${options[9]}) stash_changes ;;
        ${options[10]}) apply_stash ;;
        ${options[11]}) exit 0 ;;
    esac
}

validate_git_repository
main
