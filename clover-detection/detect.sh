#!/usr/bin/env bash

# Clover Installer - System Detection Module

CLOVER_OS="Unknown"
CLOVER_OS_ID="unknown"
CLOVER_OS_LIKE=""
CLOVER_ARCH="unknown"
CLOVER_DISTRO_FAMILY="unknown"
CLOVER_PACKAGE_MANAGER="unknown"

CLOVER_GPU_NAME="Unknown"
CLOVER_GPU_ID="unknown"
CLOVER_GPU_BACKEND="unknown"

CLOVER_LLVM_VERSION="not found"
CLOVER_PATCH_RECOMMENDATIONS=()

clover_detect_system() {
    if [[ -r /etc/os-release ]]; then
        . /etc/os-release
        CLOVER_OS="${PRETTY_NAME:-Unknown}"
        CLOVER_OS_ID="${ID:-unknown}"
        CLOVER_OS_LIKE="${ID_LIKE:-}"
    fi

    CLOVER_ARCH="$(uname -m)"

    local distro_ids
    distro_ids=" ${CLOVER_OS_ID} ${CLOVER_OS_LIKE} "

    # Prefer explicit distribution IDs before ID_LIKE.
    case "$CLOVER_OS_ID" in
        rocky|almalinux|centos|rhel|ol)
            CLOVER_DISTRO_FAMILY="rhel"
            ;;
        fedora|nobara)
            CLOVER_DISTRO_FAMILY="fedora"
            ;;
        arch|manjaro|endeavouros)
            CLOVER_DISTRO_FAMILY="arch"
            ;;
        debian|ubuntu|linuxmint|pop|mx|antix|q4os|linuxlite|lubuntu|xubuntu)
            CLOVER_DISTRO_FAMILY="debian"
            ;;
        opensuse*|suse)
            CLOVER_DISTRO_FAMILY="suse"
            ;;
        *)
            # Fallback to compatible distribution families.
            case "$distro_ids" in
                *" rocky "*|*" almalinux "*|*" centos "*|*" rhel "*|*" ol "*)
                    CLOVER_DISTRO_FAMILY="rhel"
                    ;;
                *" arch "*)
                    CLOVER_DISTRO_FAMILY="arch"
                    ;;
                *" debian "*|*" ubuntu "*)
                    CLOVER_DISTRO_FAMILY="debian"
                    ;;
                *" fedora "*)
                    CLOVER_DISTRO_FAMILY="fedora"
                    ;;
                *" suse "*|*" opensuse "*)
                    CLOVER_DISTRO_FAMILY="suse"
                    ;;
                *)
                    CLOVER_DISTRO_FAMILY="unknown"
                    ;;
            esac
            ;;
    esac

    CLOVER_PACKAGE_MANAGER="unknown"

    case "$CLOVER_DISTRO_FAMILY" in
        arch)
            command -v pacman >/dev/null 2>&1 &&
                CLOVER_PACKAGE_MANAGER="pacman"
            ;;
        fedora|rhel)
            if command -v dnf >/dev/null 2>&1; then
                CLOVER_PACKAGE_MANAGER="dnf"
            elif command -v yum >/dev/null 2>&1; then
                CLOVER_PACKAGE_MANAGER="yum"
            fi
            ;;
        debian)
            command -v apt-get >/dev/null 2>&1 &&
                CLOVER_PACKAGE_MANAGER="apt"
            ;;
        suse)
            command -v zypper >/dev/null 2>&1 &&
                CLOVER_PACKAGE_MANAGER="zypper"
            ;;
    esac

    CLOVER_LLVM_VERSION="not found"
    if command -v llvm-config >/dev/null 2>&1; then
        CLOVER_LLVM_VERSION="$(llvm-config --version 2>/dev/null || printf 'unknown')"
    fi
}
clover_detect_gpu() {
    local gpu_info=""

    if command -v lspci >/dev/null 2>&1; then
        gpu_info="$(lspci -nn 2>/dev/null | grep -Ei 'VGA|3D controller|Display controller' || true)"
    fi

    CLOVER_GPU_NAME="${gpu_info:-Unknown}"

    if [[ "$gpu_info" == *"1002:980a"* ]] ||
       [[ "$gpu_info" == *"Radeon HD 7290"* ]] ||
       [[ "$gpu_info" == *"Wrestler"* ]]; then
        CLOVER_GPU_ID="1002:980a"
        CLOVER_GPU_BACKEND="r600"
        CLOVER_PATCH_RECOMMENDATIONS+=("libclc-r600-sparse")
    fi
}

clover_detect_all() {
    CLOVER_PATCH_RECOMMENDATIONS=()
    clover_detect_system
    clover_detect_gpu
}

clover_print_detection() {
    printf '\n'
    printf '%s\n' '===== Clover System Detection ====='
    printf 'OS:              %s\n' "$CLOVER_OS"
    printf 'OS ID:           %s\n' "$CLOVER_OS_ID"
    printf 'OS family:       %s\n' "$CLOVER_DISTRO_FAMILY"
    printf 'Architecture:    %s\n' "$CLOVER_ARCH"
    printf 'Package manager: %s\n' "$CLOVER_PACKAGE_MANAGER"
    printf 'GPU:             %s\n' "$CLOVER_GPU_NAME"
    printf 'GPU ID:          %s\n' "$CLOVER_GPU_ID"
    printf 'Gallium backend: %s\n' "$CLOVER_GPU_BACKEND"
    printf 'LLVM:            %s\n' "$CLOVER_LLVM_VERSION"

    printf 'Recommended patches: '
    if ((${#CLOVER_PATCH_RECOMMENDATIONS[@]})); then
        printf '%s ' "${CLOVER_PATCH_RECOMMENDATIONS[@]}"
    else
        printf 'none'
    fi
    printf '\n'
    printf '%s\n' '==================================='
}
