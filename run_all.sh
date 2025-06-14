#!/bin/bash
set -e -u -o pipefail

./Docker/build_and_run.sh dockerfile_path=./Docker

sleep 3 # Wait for the database to start

./run.sh # Run the main script to set up the database and tables
./save_and_restore/save_database.sh # Save the entire database
./save_and_restore/restore_full_database.sh # Restore the entire database
./save_and_restore/targeted_restoration.sh # Perform targeted restoration
./verify.sh # Verify the database state
