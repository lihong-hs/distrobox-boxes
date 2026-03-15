# quay.io/archlinux/archlinux:latest - Red Hat
# ghcr.io/archlinux/archlinux:latest  - GitHub Container Registry
# archlinux:latest - Official Docker Hub image
# docker.io/archlinux:latest - Docker Hub Community maintained same as official image

FROM quay.io/archlinux/archlinux:latest AS builder

# Install base-devel and git
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git go

# Create a non-root user for building
RUN useradd -m builder && \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER builder
WORKDIR /home/builder

# Build yay
RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -s --noconfirm

# Build oh-my-posh-bin
RUN git clone https://aur.archlinux.org/oh-my-posh-bin.git && \
    cd oh-my-posh-bin && \
    makepkg -s --noconfirm

FROM quay.io/archlinux/archlinux:latest

# Copy both built packages
COPY --from=builder /home/builder/yay/*.pkg.tar.zst /tmp/
COPY --from=builder /home/builder/oh-my-posh-bin/*.pkg.tar.zst /tmp/

# Install all packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm git nano zsh fzf zoxide fastfetch base-devel && \
    pacman -U --noconfirm /tmp/*.pkg.tar.zst && \
    # Clean up
    rm -rf /tmp/*.pkg.tar.zst && \
    pacman -Scc --noconfirm

# Set default shell
SHELL ["/bin/zsh"]
CMD ["/bin/zsh"]
