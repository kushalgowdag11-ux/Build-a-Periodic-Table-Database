
#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT=$($PSQL "SELECT CONCAT(elements.atomic_number, '|', elements.name, '|', elements.symbol, '|', properties.atomic_mass, '|', properties.melting_point_celsius, '|', properties.boiling_point_celsius, '|', types.type) FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.atomic_number = $1")
else
  ELEMENT=$($PSQL "SELECT CONCAT(elements.atomic_number, '|', elements.name, '|', elements.symbol, '|', properties.atomic_mass, '|', properties.melting_point_celsius, '|', properties.boiling_point_celsius, '|', types.type) FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.symbol ILIKE '$1' OR elements.name ILIKE '$1'")
fi

if [[ -z $ELEMENT ]]
then
  echo "I could not find that element in the database."
else
  echo "$ELEMENT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL MASS MELTING_POINT BOILING_POINT TYPE
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
fi
