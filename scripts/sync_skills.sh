#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]:-$0}")")"
readonly SOURCE_DIR

readonly UTILS_DIR="${SOURCE_DIR}/utils"
readonly SKILLS_DIR="${SOURCE_DIR}/../.agents/skills"

# shellcheck source=./utils/check_has_commands.sh
source "${UTILS_DIR}"/check_has_commands.sh
# shellcheck source=./utils/print.sh
source "${UTILS_DIR}"/print.sh


HELP_TEXT="$(cat <<EOF
Copy skills between this clone and a project.

Usage:
    $0 push <skill|--all> <project> [--dry-run]
    $0 pull <skill|--all> <project> [--dry-run]

Commands:
    push         Copy from this clone to the project
    pull         Copy from the project to this clone

Options:
    --all        Copy every source skill
    --dry-run    Preview without changing files
    --help       Show this help

Examples:
    $0 push ddnomad-coding-style ../my-project
    $0 pull --all ../my-project --dry-run

Skills live in .agents/skills/ in each repository. Matching files are overwritten.
EOF
)"
readonly HELP_TEXT


function print_usage {
    print plain "${HELP_TEXT}"
}


function copy_skill {
    local source_directory_path
    source_directory_path="$1"

    local target_directory_path
    target_directory_path="$2"

    local dry_run
    dry_run="$3"

    if ! test -d "${source_directory_path}"; then
        print error "Skill directory does not exist: ${source_directory_path}"
        exit 1
    fi

    local rsync_options
    rsync_options=(-a --checksum '--out-format=    %n%L')

    if test "${dry_run}" = '--dry-run'; then
        rsync_options+=(--dry-run)

        if ! test -d "${target_directory_path}"; then
            check_has_commands tree
            print info 'Would create:'
            print plain "${target_directory_path}/"
            tree -a --noreport -- "${source_directory_path}" | sed '1d' >&2
            return
        fi
    else
        mkdir -p "${target_directory_path}"
    fi

    local changes
    changes="$(rsync "${rsync_options[@]}" -- "${source_directory_path}/" "${target_directory_path}/" | sed '/^    \.\/$/d')"

    if test -z "${changes}"; then
        print info "Already up to date: ${target_directory_path}/"
    elif test "${dry_run}" = '--dry-run'; then
        print info "Would update: ${target_directory_path}/"
        print plain "${changes}"
    else
        print success "Synchronised: ${target_directory_path}/"
        print plain "${changes}"
    fi
}


function main {
    if test "$#" -eq 1 && test "$1" = '--help'; then
        print_usage
        return
    fi

    if test "$#" -lt 3 || test "$#" -gt 4; then
        print_usage
        exit 1
    fi

    check_has_commands realpath rsync mkdir tput

    local direction
    direction="$1"

    local skill_name
    skill_name="$2"

    local project_directory_path
    project_directory_path="$(realpath "$3")"

    local dry_run
    dry_run="${4:-}"

    if ! test -d "${project_directory_path}"; then
        print error "Project directory does not exist: ${project_directory_path}"
        exit 1
    fi

    if test "${skill_name}" != '--all' && [[ ! "${skill_name}" =~ ^[a-zA-Z0-9][a-zA-Z0-9_-]*$ ]]; then
        print error 'Provide a single skill name or --all, not a path'
        exit 1
    fi

    if test "$#" -eq 4 && test "${dry_run}" != '--dry-run'; then
        print_usage
        exit 1
    fi

    if test "${project_directory_path}" = "$(realpath "${SOURCE_DIR}/..")"; then
        print error 'Project must be different from this clone'
        exit 1
    fi

    local source_directory_path
    local target_directory_path

    case "${direction}" in
        push )
            source_directory_path="${SKILLS_DIR}"
            target_directory_path="${project_directory_path}/.agents/skills"
            ;;
        pull )
            source_directory_path="${project_directory_path}/.agents/skills"
            target_directory_path="${SKILLS_DIR}"
            ;;
        * )
            print_usage
            exit 1
            ;;
    esac

    if test "${skill_name}" != '--all'; then
        copy_skill "${source_directory_path}/${skill_name}" "${target_directory_path}/${skill_name}" "${dry_run}"
        return
    fi

    if ! test -d "${source_directory_path}"; then
        if test "${dry_run}" = '--dry-run'; then
            print info "Would create ${source_directory_path}, no skills to copy"
            return
        fi

        mkdir -p "${source_directory_path}"
    fi

    local skill_directory_path

    for skill_directory_path in "${source_directory_path}"/*; do
        if ! test -d "${skill_directory_path}"; then
            continue
        fi

        skill_name="${skill_directory_path##*/}"
        copy_skill "${skill_directory_path}" "${target_directory_path}/${skill_name}" "${dry_run}"
    done
}


main "$@"
