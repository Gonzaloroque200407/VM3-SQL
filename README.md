# VM3 — Banco de Dados do GkEvents

VM dedicada ao **banco de dados** do sistema GkEvents.
- SGBD: **MySQL/MariaDB** (ajuste se usa Postgres).
- Rede interna: `172.16.120.0/24`.
- A API (VM2) conecta na VM3 pela porta 3306 (MySQL).

Pastas deste repositório:
- `schema/` — scripts SQL de criação/índices.
- `dumps/` — backups `.sql` (opcional versionar).
- `docs/` — anotações de setup/ops.

Comandos úteis (na VM3):
```bash
# Dump (MySQL/MariaDB)
mysqldump -u <user> -p gkevents > dumps/gkevents-$(date +%F).sql

# Restore
mysql -u <user> -p gkevents < dumps/gkevents-AAAA-MM-DD.sql
