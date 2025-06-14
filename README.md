# DB Admin Lab

## Table of Contents
- [DB Admin Lab](#db-admin-lab)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Features](#features)
  - [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Launching All Operations](#launching-all-operations)
    - [Individual Operations](#individual-operations)
      - [Clean the Docker environment](#clean-the-docker-environment)
      - [Build and run the Docker container](#build-and-run-the-docker-container)
      - [Execute the initial database setup](#execute-the-initial-database-setup)
      - [Backup the database](#backup-the-database)
      - [Restore a full database](#restore-a-full-database)
      - [Restore a specific table](#restore-a-specific-table)
      - [Check the status of the databases](#check-the-status-of-the-databases)


---

## Introduction
This project provides a set of Bash scripts to manage a PostgreSQL database via Docker: building and launching the container, performing backups (full or targeted), restores, and status checks – all in an automated way.

I chose to use Docker to host my PostgreSQL instance because I have always used the Docker version of PostgreSQL on my machine, and I also opted for this solution for practical reasons related to replicating the exercise.


## Features
- **Docker management**: build a custom PostgreSQL image, start/stop/remove the container.
- **Initialization**: creation of the *tp_multilang_db* database, tables with sample data, users, and privileges.
- **Logical backups**: `pg_dump` in optimized binary format (`-Fc`).
- **Full** or **targeted** (single table) **restores**.
- **Verification scripts**: check the status of databases, tables, roles, and privileges.
- **Full chain**: `run_all.sh` performs clean → build → config → backup → restore → verify.

## Prerequisites
- **Docker** (Engine or Desktop) running.
- **PostgreSQL client** (`psql`, `pg_dump`, `pg_restore`) compatible with PostgreSQL 17.
  ```bash
  psql --version
  pg_dump --version
    ```

# Project Structure
```txt
.
├── run_all.sh                  # Full execution
├── connect.sh                  # Live connection to PostgreSQL database
├── execute.sh                  # Initial setup
├── verify.sh                   # Operation verification
├── README.md                   # This file
├── Docker/
│   ├── Dockerfile              # PostgreSQL image
│   ├── clean.sh                # Docker cleanup
│   └── build_and_run.sh        # Build + run container
└── save_and_restore/
├── save_database.sh            # Backup
├── restore_full_database.sh    # Full restore
└── targeted_restoration.sh     # Table restore
```

# Usage

## Launching All Operations

```bash
chmod +x *.sh Docker/*.sh save_and_restore/*.sh
./run_all.sh
```

### Individual Operations

#### Clean the Docker environment
```bash
./Docker/clean.sh
```

#### Build and run the Docker container
```bash
# Default context (Docker/ folder)
./Docker/build_and_run.sh

# Custom context
./Docker/build_and_run.sh dockerfile_path=./path/to/Dockerfile
```

#### Execute the initial database setup
```bash
./execute.sh
```

#### Backup the database
```bash
./save_and_restore/save_database.sh
# => tp_multilang_db_backup.dump
```

#### Restore a full database
```bash
./save_and_restore/restore_full_database.sh
```

#### Restore a specific table
```bash
./save_and_restore/targeted_restoration.sh
```

#### Check the status of the databases
```bash
./verify.sh
```

---
