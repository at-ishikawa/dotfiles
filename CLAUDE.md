# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is an Ansible-based dotfiles repository for automated configuration management across macOS, Linux (Ubuntu), and Windows (WSL) environments. The repository uses Ansible roles to manage various development tools and configurations.

## Architecture

### Role-Based Structure
The repository follows Ansible best practices with a role-based architecture:
- Each tool/configuration has its own role in `roles/`
- Roles contain `tasks/`, `templates/`, `vars/`, and sometimes `handlers/` directories
- Templates use Jinja2 for environment-specific configurations

### Key Components
- **bootstrap.yml**: Main playbook that orchestrates all roles based on OS detection
- **Makefile**: Entry point for setup commands
- **ansible.cfg**: Ansible configuration pointing to hosts.yml
- **hosts.yml**: Inventory file defining localhost variables (copy from hosts.yml.example)

### OS Detection and Branching
The bootstrap playbook automatically detects:
- Operating system (Ubuntu, macOS)
- WSL environment on Ubuntu
- Applies appropriate configurations based on detected environment

## Common Commands

### Initial Setup
```bash
# Copy and configure the hosts file
cp hosts.yml.example hosts.yml
# Edit hosts.yml with your specific configurations

# Install prerequisites and prepare environment
make prepare

# Run the main installation
make install
```

### Development Commands
```bash
# Update configurations (after changes)
make update

# Run tests
make test

# Run specific role with tags
ansible-playbook --diff --ask-become-pass bootstrap.yml --tags [role-name]

# Check mode (dry run)
ansible-playbook --diff --check bootstrap.yml

# Verbose output
ansible-playbook --verbose --diff bootstrap.yml
```

### Testing
```bash
# Run sanity tests
ansible-test sanity roles bootstrap.yml

# Run integration tests
ansible-test integration
```

## Key Variables (hosts.yml)

- `github_org`: GitHub organization name for gitconfig
- `host_user`: Windows username for WSL VSCode integration
- `install_aws_cli`: Toggle AWS CLI installation
- `install_gcloud_cli`: Toggle Google Cloud CLI installation
- `install_kubectl`: Toggle kubectl installation
- `install_desktop_config`: Toggle desktop configurations on Ubuntu

## Virtual Environment

The project uses Python virtual environment:
- Created in `venv/` directory
- Activated automatically by make commands
- Contains Ansible and linting tools defined in requirements.txt