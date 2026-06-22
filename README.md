# yevgen setup

Ansible-based provisioning for a personal homelab server running self-hosted services behind a Caddy reverse proxy with automatic HTTPS.

## Architecture

```
                         oryks.org
                             |
                          Caddy
                     (reverse proxy)
                    /        |        \
                   /         |         \
              SearXNG      Dozzle      Gitea
           (metasearch)  (log viewer)  (Git host)  ← PostgreSQL
                   \         |         /
                    \        |        /
                   Docker network: oryks
                             |
                          Docker CE
                             |
                        Linux server
```

## Services

| Service     | Domain             | Description                                |
|-------------|--------------------|--------------------------------------------|
| **Caddy**   | `*.oryks.org`      | Reverse proxy, automatic HTTPS (Let's Encrypt) |
| **SearXNG** | `search.oryks.org` | Privacy-respecting metasearch engine       |
| **Dozzle**  | `logs.oryks.org`   | Real-time Docker log viewer (auth required) |
| **Gitea**   | `git.oryks.org`    | Self-hosted Git service + PostgreSQL       |

## Requirements

- **Local machine**: Ansible, `ssh` access to the target server
- **Target server**: Linux (Debian/Fedora), root/sudo access

## Quick start

```bash
# 1. Create environment config
cp .env.example .env
# Edit .env with your credentials — it's gitignored

# 2. Test connectivity
./test.sh

# 3. Run the full provisioning
./run.sh
```

`run.sh` installs Ansible Galaxy dependencies, then executes `playbook.yaml` with `--ask-become-pass`.

## Structure

```
├── playbook.yaml           # Main playbook (Docker → Dozzle → SearXNG → Gitea → Caddy)
├── inventory.ini           # Target server definition
├── requirements.yml        # Ansible Galaxy dependencies (geerlingguy.docker, community.docker)
├── run.sh                  # Entry point for provisioning
├── test.sh                 # Connectivity test
├── .env.example            # Credential template (gitignored)
└── roles/
    ├── dozzle/             # Dozzle log viewer container setup
    ├── searXNG/            # SearXNG metasearch engine container setup
    ├── gitea/              # Gitea + PostgreSQL with docker-compose
    ├── caddy/              # Caddy reverse proxy with Caddyfile template
    └── docker-compose-plugin/  # (Legacy) docker-compose-plugin installation
```

## Security

- Credentials and secrets are in `.env` and `credentials/` — both gitignored.
- Dozzle uses simple authentication with bcrypt-hashed passwords.
- Gitea registration is disabled by default (`DISABLE_REGISTRATION: true`).
- SearXNG and Gitea database passwords are randomly generated via Ansible's `password` lookup.

## Requirements (Ansible Galaxy)

```
ansible-galaxy role install geerlingguy.docker
ansible-galaxy collection install community.docker
```

These are installed automatically by `run.sh`.
