#
# Catalog of D&D-inspired creatures.
#
# Data stored in format of:
# name|level|hit points|STR|DEX|CON|INT|WIS|CHA
#

: ${GRIMOIRE:=$HOME/grimoire}
export GRIMOIRE

if [ ! -f "$GRIMOIRE" ] ; then
  echo "No monster manual found at $GRIMOIRE."
  echo
  echo "Set the path to your grimoire using:"
  echo '$ GRIMOIRE=path/to/grimoire'
  echo '    or'
  echo "Place a file named grimoire in $HOME"
  exit 1
fi

#
# Helper function to perform lookups of a record.
#

function lu() {
  search="$1"

  if [ -z "$search" ] ; then
    echo "Please enter a creature's name to search for."
    return 1
  fi

  echo "Searching for $search in $GRIMOIRE..."
  found="$(grep $search $GRIMOIRE)"

  if [ -z $found ] ; then
    echo "\""$search"\" not found."
    return 1
  fi

  display_stats "$found"

  return 0
}

#
# Helper to display creature stats in a nice format.
#

function display_stats() {
  found="$1"

  name="$(echo $found         | cut -d'|' -f1)"
  level="$(echo $found        | cut -d'|' -f2)"
  hitpoints="$(echo $found    | cut -d'|' -f3)"
  strength="$(echo $found     | cut -d'|' -f4)"
  dexterity="$(echo $found    | cut -d'|' -f5)"
  constitution="$(echo $found | cut -d'|' -f6)"
  intelligence="$(echo $found | cut -d'|' -f7)"
  wisdom="$(echo $found       | cut -d'|' -f8)"
  charisma="$(echo $found     | cut -d'|' -f9)"

  echo
  echo "============================="
  echo ">> CREATURE FOUND <<"
  echo ">> Name: $name"
  echo ">> Level: $level"
  echo ">> Hitpoints: $hitpoints"
  echo "============================="
  echo ">> ABILITY SCORES <<"
  echo ">> STR: $strength"
  echo ">> DEX: $dexterity"
  echo ">> CON: $constitution"
  echo ">> INT: $intelligence"
  echo ">> WIS: $wisdom"
  echo ">> CHA: $charisma"
  echo "============================="
  echo
}

#
# If passed arguments, do a look-up by name
#

if [ "$#" -ne 0 ] ; then
  if lu "$@" ; then
    exit 0
  else
    exit 1
  fi
fi

echo

##### TODO #####

#
# If no arguments passed, run interactive mode.
#

validchoice=

until [ -n "$validchoice" ] ; do
  #
  # Main Menu
  #
  echo '
  =======================================
  >> GRIMOIRE    -    INTERACTIVE MODE <<
  =======================================

  Would you like to:
  1. Look up a monster
  2. Add a monster to the Grimoire
  3. Remove a monster from the Grimoire
  4. Edit an existing record in the Grimoire
  5. Learn more about the Grimoire
  6. Close the Grimoire

Please select one of the above (1-6): \c'

  #
  #  Read & interpret selection
  #

  read choice
  echo

  case "$choice"
  in
    1) echo "Enter name to look up: \c"
       read name
       if lu "$name" ; then
         validchoice=TRUE
       fi
       ;;
    2) echo "Enter name to be added: \c"
       read name
       echo "Enter challenge level of creature: \c"
       read level
       echo "Enter hitpoints or hit dice: \c"
       read hitpoints
       echo "Enter strength (STR) score: \c"
       read strength
       echo "Enter dexterity (DEX) score: \c"
       read dexterity
       echo "Enter constitution (CON) score: \c"
       read constitution
       echo "Enter intelligence (INT) score: \c"
       read intelligence
       echo "Enter wisdom (WIS) score: \c"
       read wisdom
       echo "Enter charisma (CHA) score: \c"
       read charisma

       echo
       echo "Writing creature to $GRIMOIRE..."
       creature="$name|$level|$hitpoints|$strength|$dexterity|$constitution|$intelligence|$wisdom|$charisma" 
       echo $creature >> $GRIMOIRE
       echo "Successfully added: $creature"
       echo
       validchoice=TRUE
       ;;
    3) echo "Enter name to be removed: \c"
       read name
       #### TODO: rem "$name"
       validchoice=TRUE
       ;;
    4) echo "NO"
       #### TODO: edit "$name" and so on
       validchoice=TRUE
       ;;
    5) echo
       echo "  ABOUT GRIMOIRE:"
       echo "  This program is used to catalog creatures for"
       echo "  use in role-playing games, similar to a D&D monster manual."
       echo
       echo "  The data is stored in the format: "
       echo '  name|level|hit points|STR|DEX|CON|INT|WIS|CHA'
       echo
       ;;
    6) echo "Goodbye... for now."
       validchoice=TRUE # then just exit
       ;;
    *) echo "Invalid choice.";;
  esac
done


echo "Exiting."