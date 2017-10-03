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

echo

#
# If passed arguments, do a look-up by name
#

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
  4. Learn more about the Grimoire

Please select one of the above (1-4): \c'

  #
  #  Read & interpret selection
  #

  read choice
  echo

  case "$choice"
  in
    1) echo "Enter name to look up: \c"
       read name
       #### TODO: lu name
       validchoice=TRUE
       ;;
    2) echo "Enter name to be added: \c"
       read name
       #### TODO: add name, also add other stats, maybe put in function
       validchoice=TRUE
       ;;
    3) echo "Enter name to be removed: \c"
       read name
       #### TODO: rem name
       validchoice=TRUE
       ;;
    4) echo
       echo "  ABOUT GRIMOIRE:"
       echo "  This program is used to catalog creatures for"
       echo "  use in role-playing games, similar to a D&D monster manual."
       echo
       echo "  The data is stored in the format: "
       echo '  name|level|hit points|STR|DEX|CON|INT|WIS|CHA'
       echo
       ;;
    *) echo "Invalid choice.";;
  esac
done


echo "Exiting."