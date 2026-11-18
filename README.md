# Periodic Table Database

A PostgreSQL database containing chemical element information.

## Files

- element.sh: Bash script to search for elements.
- periodic_table.sql: SQL dump of the periodic_table database.

## Usage

Run the script with an atomic number, element symbol, or element name.

Examples:

./element.sh 1
./element.sh H
./element.sh Hydrogen
## Testing

Verified lookups by atomic number, symbol, and name.
Verified missing arguments and invalid element inputs.
