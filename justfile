set shell := ["bash", "-c"]
set dotenv-load := true

image_name := "arch-dev"
box_name := "arch"

# Default recipe lists available commands
default:
    @just --list

list:
    distrobox list

build:
    docker build -f Dockerfile.arch -t {{ image_name }} .

build-no-cache:
    docker build --no-cache -f Dockerfile.arch -t {{ image_name }} .

create:
    distrobox create --image {{ image_name }} --name {{ box_name }}
    distrobox enter {{ box_name }}

enter:
    distrobox enter {{ box_name }} -- zsh

stop a_box_name=box_name:
    distrobox stop {{ a_box_name }}

rm a_box_name=box_name:
    distrobox rm {{ a_box_name }}

upgrade a_box_name=box_name:
    distrobox enter {{ a_box_name }} -- yay -Syu
