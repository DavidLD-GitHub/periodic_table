#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if  [[ $1 ]]
# tiene argumento
then
  if [[ $1 =~ [0-9]+$ ]]
  # filtrar por numero atomico
  then
    A_N=$($PSQL "SELECT atomic_number FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1 ")
    NAME=$($PSQL "SELECT name  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1 ")
    SYMBOL=$($PSQL "SELECT symbol  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1 ")
    TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1 ")
    A_M=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1 ")
    M_P=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1 ")
    B_P=$($PSQL "SELECT boiling_point_celsius  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1 ")
  elif [[ ${#1} -le 2 ]]
  # filtrar por simbolo
  then
    A_N=$($PSQL "SELECT atomic_number FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' ")
    NAME=$($PSQL "SELECT name  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' ")
    SYMBOL=$($PSQL "SELECT symbol  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' ")
    TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' ")
    A_M=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' ")
    M_P=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' ")
    B_P=$($PSQL "SELECT boiling_point_celsius  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1' ")
  else
  # filtrar por nombre
    A_N=$($PSQL "SELECT atomic_number FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' ")
    NAME=$($PSQL "SELECT name  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' ")
    SYMBOL=$($PSQL "SELECT symbol  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' ")
    TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' ")
    A_M=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' ")
    M_P=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' ")
    B_P=$($PSQL "SELECT boiling_point_celsius  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' ")
  fi
  if [[ -z $A_N ]]
  then
    # el elemento no esta en la tabla
    echo "I could not find that element in the database."
  else
    echo "The element with atomic number "$A_N" is "$NAME" ("$SYMBOL"). It's a "$TYPE", with a mass of "$A_M" amu. "$NAME" has a melting point of "$M_P" celsius and a boiling point of "$B_P" celsius." 
  fi
else
  echo Please provide an element as an argument.
fi
